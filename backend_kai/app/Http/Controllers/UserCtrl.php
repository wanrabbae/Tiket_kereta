<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class UserCtrl extends Controller
{
    public function auth(Request $request)
    {
        $request->password = bcrypt($request->password);
        $credentials = $request->only('email', 'password');

        if (Auth::attempt($credentials)) {
            $request->session()->regenerate();
            return redirect()->route("dashboard")->with("success", "Login successfuly!");
        }

        return redirect()->route("login")->with("error", "Incorrect email or password!");
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect()->route('login')->with('success', 'You are now logged out!');
    }

    public function addUser(Request $request)
    {
        $validate = $request->validate([
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:users",
            "password" => "required|min:6",
            "password_confirmed" => "required|min:6",
        ]);

        if ($validate["password"] != $validate["password_confirmed"]) {
            return redirect()->back()->withErrors(["msg" => "Password doesnt match!"]);
        }

        $validate["password"] = bcrypt($validate["password"]);

        if (User::create($validate)) {
            return redirect()->back()->with("success", "Success create new User!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant create the User"]);
    }

    public function updateUser(Request $request, $id)
    {
        $validate = $request->validate([
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100",
        ]);

        if (User::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update User!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update User"]);
    }

    public function deleteUser($id)
    {
        $User = User::find($id);

        if ($User->delete()) {
            return redirect()->back()->with("success", "Success delete the User");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the User"]);
    }
}
