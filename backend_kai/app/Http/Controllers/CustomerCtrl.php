<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerCtrl extends Controller
{
    public function addCustomer(Request $request)
    {
        $validate = $request->validate([
            "id" => "required|int|unique:customers|min:16",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:customers",
            "city" => "required",
            "country" => "required"
        ]);

        if (Customer::create($validate)) {
            return redirect()->back()->with("success", "Success create new customer!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the customer"]);
    }

    public function updateCustomer(Request $request, $id)
    {
        $validate = $request->validate([
            "id" => "required|int|unique:customers",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100",
            "city" => "required",
            "country" => "required"
        ]);

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
}
