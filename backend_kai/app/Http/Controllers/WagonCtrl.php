<?php

namespace App\Http\Controllers;

use App\Models\Wagon;
use App\Models\Train;
use App\Models\WagonSeat;
use Illuminate\Http\Request;

class WagonCtrl extends Controller
{
    // CRUD ADMIN TRAINS
    public function addWagon(Request $request)
    {
        $validate = $request->validate([
            "name" => "required|max:255",
            "type" => "required|max:255",
            "seat_num" => "required|max:100|int",
        ]);

        if ($wagon = Wagon::create($request->except('_token', 'seat_num'))) {
            for ($i = 1; $i < (int)$validate["seat_num"] + 1; $i++) {
                WagonSeat::create(['wagon_id' => $wagon->id, 'seat' => $i]);
            }
            return redirect()->back()->with("success", "Success create new train cars!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train cars"]);
    }

    public function updateWagon(Request $request, $id)
    {
        $validate = $request->validate([
            "name" => "required|max:255",
            "type" => "required|max:255",
            "seat_num" => "required|max:100|int",
        ]);

        $wagon = Wagon::find($id);
        // dd($wagon);
        // $wagon->wagon_seat->delete();
        WagonSeat::where('wagon_id', $id)->delete();

        if ($wagon->update($request->except('_token', 'seat_num'))) {
            for ($i = 1; $i < (int)$validate["seat_num"] + 1; $i++) {
                WagonSeat::create(['wagon_id' => $wagon->id, 'seat' => $i]);
            }
            return redirect()->back()->with("success", "Success update train car!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update train car"]);
    }

    public function deleteWagon($id)
    {
        $customer = Wagon::find($id);

        if ($customer->delete()) {
            WagonSeat::where('wagon_id', $id)->delete();
            return redirect()->back()->with("success", "Success delete the train car");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train car"]);
    }
}
