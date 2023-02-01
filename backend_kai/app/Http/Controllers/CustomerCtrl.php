<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerCtrl extends Controller
{
    public function addCustomer(Request $request)
    {
        $validate = $request->validate([
            "nik" => "required|number|unique:customers",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:customers",
            "city" => "required",
            "country" => "required"
        ]);

        $validate["id"] = $validate["nik"];

        if (Customer::create($validate)) {
            return back()->with("success", "Success create new customer!");
        }

        return back()->with("error", "Error cant create new customer");
    }

    public function updateCustomer(Request $request, $id)
    {
        $customer = Customer::find($id);

        $validate = $request->validate([
            "nik" => "required|number|unique:customers",
            "name" => "required|max:255",
            "email" => "required|email:dns|max:100|unique:customers",
            "city" => "required",
            "country" => "required"
        ]);

        $validate["id"] = $validate["nik"];

        if ($customer::update($validate)) {
            return back()->with("success", "Success update customer!");
        }

        return back()->with("error", "Error cant update customer");
    }

    public function deleteCustomer($id)
    {
        $customer = Customer::find($id);

        if ($customer->delete()) {
            return back()->with("success", "Success delete the customer");
        }

        return back()->with("error", "Error cant delete the customer");
    }
}
