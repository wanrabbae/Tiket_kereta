<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class CustomerCtrl extends Controller
{
    public function addCustomer(Request $request)
    {
        $validate = $request->validate([
            "id" => "required|int|unique:customers|min:16",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:customers",
            "city" => "required",
            "country" => "required",
            "password" => "required|min:5"
        ]);

        $validate["password"] = bcrypt($validate["password"]);

        if (Customer::create($validate)) {
            return redirect()->back()->with("success", "Success create new customer!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the customer"]);
    }

    public function updateCustomer(Request $request, $id)
    {
        $validate = $request->validate([
            "id" => "required|int",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100",
            "city" => "required",
            "country" => "required",
        ]);

        if ($request->has('password')) {
            $validate["password"] = bcrypt($request->password);
        }

        if (Customer::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update customer!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update customer"]);
    }

    public function deleteCustomer($id)
    {
        $customer = Customer::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the customer");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the customer"]);
    }

    public function loginApi(Request $request)
    {
        $request->validate(['email' => 'required|email', 'password' => 'required',]);
        $user = Customer::where('email', $request->email)->first();
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response(['success'   => false, 'message' => ['Email or Password is incorrect!']], 401);
        }
        $token = $user->createToken('ApiToken')->plainTextToken;
        $response = ['success' => true, 'user' => $user, 'token' => $token];
        return response($response, 201);
    }
    public function registerApi(Request $request)
    {
        $validate = Validator::make($request->all(), [
            "id" => "required|int|unique:customers|min:16",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:customers",
            "city" => "required",
            "country" => "required",
            "password" => "required|min:5|confirmed"
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }

        $request["password"] = bcrypt($request["password"]);

        if ($user = Customer::create($request->only(['id', 'name', 'email', 'city', 'country', 'password']))) {
            $token = $user->createToken('ApiToken')->plainTextToken;
            return response()->json([
                "success" => true,
                "user" => $request->only(['id', 'name', 'email', 'city', 'country']),
                "token" => $token
            ]);
        }
    }
}
