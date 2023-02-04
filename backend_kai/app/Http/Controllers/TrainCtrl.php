<?php

namespace App\Http\Controllers;

use App\Models\Train;
use App\Models\TrainFare;
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

    // CRUD ADMIN TRAIN FARE
    public function addTrainFare(Request $request)
    {
        $validate = $request->validate([
            "class" => "required|max:255",
            "train_no" => "required|max:100|unique:train_fare",
            "fare" => "required|int",
        ]);

        if (TrainFare::create($validate)) {
            return redirect()->back()->with("success", "Success create new train fare!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train fare"]);
    }

    public function updateTrainFare(Request $request, $id)
    {
        $validate = $request->validate([
            "class" => "required|max:255",
            "train_no" => "required|max:100|unique:train_fare",
            "fare" => "required|int",
        ]);

        if (TrainFare::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update train fare!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update train fare"]);
    }

    public function deleteTrainFare($id)
    {
        $customer = TrainFare::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the train fare");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train fare"]);
    }

    // CRUD ADMIN TRAINS
    public function addTrain(Request $request)
    {
        $validate = $request->validate([
            "train_name" => "required|max:255|unique:trains",
            "eco_seat_num" => "required|int",
            "busines_seat_num" => "required|int",
            "exec_seat_num" => "required|int",
        ]);

        if (Train::create($validate)) {
            return redirect()->back()->with("success", "Success create new trains!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the trains"]);
    }

    public function updateTrain(Request $request, $id)
    {
        $validate = $request->validate([
            "train_name" => "required|max:255|unique:trains",
            "eco_seat_num" => "required|int",
            "busines_seat_num" => "required|int",
            "exec_seat_num" => "required|int",
        ]);

        if (Train::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update trains!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update trains"]);
    }

    public function deleteTrain($id)
    {
        $customer = Train::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the trains");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the trains"]);
    }
}
