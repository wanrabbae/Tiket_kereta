<?php

namespace App\Http\Controllers;

use App\Models\TrainStation;
use Illuminate\Http\Request;

class TrainCtrl extends Controller
{
    // CRUD ADMIN STATION
    public function addTrainStation(Request $request)
    {
        $validate = $request->validate([
            "station_name" => "required|max:255",
            "station_code" => "required|max:10|unique:train_station",
            "city" => "required",
        ]);

        if (TrainStation::create($validate)) {
            return redirect()->back()->with("success", "Success create new station!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the station"]);
    }

    public function updateTrainStation(Request $request, $id)
    {
        $validate = $request->validate([
            "station_name" => "required|max:255",
            "station_code" => "required|max:10",
            "city" => "required",
        ]);

        if (TrainStation::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update station!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update station"]);
    }

    public function deleteTrainStation($id)
    {
        $customer = TrainStation::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the station");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the station"]);
    }
}
