<?php

namespace App\Http\Controllers;

use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainJourney;
use App\Models\TrainRoute;
use App\Models\TrainStation;
use Illuminate\Http\Request;

class TrainApiCtrl extends Controller
{
    public function getStations(Request $request)
    {
        response()->json(TrainStation::all());
    }

    public function findTicket(Request $request)
    {
        $data = [];
        if ($request->has('depart') && $request->has('arrival')) {
            $data = TrainJourney::with(['train', 'train_fare', 'train_station_depart', 'train_station_arrival'])->where('train_station_depart.station_name', $request->query('depart'))->where('train_station_arrival.station_name', $request->query('arrival'))->get();
        } else {
            $data = TrainJourney::with(['train', 'train_fare', 'train_station_depart', 'train_station_arrival'])->get();
        }
        response()->json($data);
    }
}
