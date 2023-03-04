<?php

namespace App\Http\Controllers;

use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainJourney;
use App\Models\TrainRoute;
use App\Models\TrainStation;
use App\Models\Wagon;
use Illuminate\Http\Request;

class TrainApiCtrl extends Controller
{
    public function getStations(Request $request)
    {
        $data = TrainStation::orderBy('id', 'DESC')->get(['id', 'station_code', 'station_name', 'city']);
        return response()->json($data);
    }

    public function findTicket(Request $request)
    {
        $data = [];
        if ($request->has('depart') && $request->has('arrival')) {
            $data = TrainJourney::with(['train', 'train_station_depart', 'train_station_arrival'])->whereRelation('train_station_depart', 'station_name', '=', $request->query('depart'))->whereRelation('train_station_arrival', 'station_name', '=', $request->query('arrival'))->get();

            if ($data) {
                foreach ($data as $key) {
                    $fare = TrainFare::with(['wagon', 'wagon.wagon_seat'])->where('train_no', $key['train_no'])->get(["id", "class", "fare"]);
                    if ($fare) {
                        $key["train_fare"] = $fare;
                    }
                }
            }
        } else {
            $data = TrainJourney::with(['train', 'train_station_depart', 'train_station_arrival'])->get();
            if ($data) {
                foreach ($data as $key) {
                    $fare = TrainFare::where('train_no', $key['train_no'])->get(["id", "class", "fare"]);
                    if ($fare) {
                        $key["train_fare"] = $fare;
                    }
                }
            }
        }
        return response()->json($data);
    }

    public function getListSeat(Request $request)
    {
        return response()->json(
            Wagon::with(['train_fare', 'wagon_seat'])->where('fare_id', $request->query('fare_id'))->get()
        );
    }
}
