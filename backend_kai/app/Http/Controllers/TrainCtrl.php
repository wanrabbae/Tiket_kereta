<?php

namespace App\Http\Controllers;

use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainJourney;
use App\Models\TrainRoute;
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
            "train_no" => "required|max:100",
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
            "train_no" => "required|max:100",
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
            "train_no" => "required|max:255|unique:trains",
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
            "train_no" => "required|max:255|unique:trains",
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

    // CRUD ADMIN TRAIN JOURNEY
    public function addTrainJourney(Request $request)
    {
        $validate = $request->validate([
            "depart_station" => "required|int",
            "arrival_station" => "required|int",
            "train_no" => "required|max:100",
            "depart_time" => "required|date",
            "arrival_time" => "required|date",
            "train_id" => "required|int",
        ]);

        if (TrainJourney::create($validate)) {
            return redirect()->back()->with("success", "Success create new train journey!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train journey"]);
    }

    public function updateTrainJourney(Request $request, $id)
    {
        $validate = $request->validate([
            "depart_station" => "required|int",
            "arrival_station" => "required|int",
            "train_no" => "required|max:100",
            "depart_time" => "required|date",
            "arrival_time" => "required|date",
            "train_id" => "required|int",
        ]);

        if (TrainJourney::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update train journey!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update train journey"]);
    }

    public function deleteTrainJourney($id)
    {
        $customer = TrainJourney::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the train journey");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train journey"]);
    }

    // CRUD ADMIN TRAIN ROUTE
    public function addTrainRoute(Request $request)
    {
        $validate = $request->validate([
            "train_no" => "required|max:100",
            "start_route" => "required|max:100",
            "end_route" => "required|max:100",
            "depart_time" => "required|date",
            "arrival_time" => "required|date",
        ]);

        if (TrainRoute::create($validate)) {
            return redirect()->back()->with("success", "Success create new train route!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train route"]);
    }

    public function updateTrainRoute(Request $request, $id)
    {
        $validate = $request->validate([
            "train_no" => "required|max:100",
            "start_route" => "required|max:100",
            "end_route" => "required|max:100",
            "depart_time" => "required|date",
            "arrival_time" => "required|date",
        ]);

        if (TrainRoute::where('id', $id)->update($validate)) {
            return redirect()->back()->with("success", "Success update train route!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant update train route"]);
    }

    public function deleteTrainRoute($id)
    {
        $customer = TrainRoute::find($id);

        if ($customer->delete()) {
            return redirect()->back()->with("success", "Success delete the train route");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant delete the train route"]);
    }
}
