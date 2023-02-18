<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainJourney;
use App\Models\TrainRoute;
use App\Models\TrainStation;
use App\Models\Wagon;
use App\Models\Booking;
use App\Models\DetailBooking;
use App\Models\Passenger;
use App\Models\WagonSeat;

class BookingApiCtrl extends Controller
{
    public function getBooking(Request $request)
    {
        $data = Booking::where('customer_id', $request->user()->id)->get();
        foreach ($data as $dt) {
            $findJourney = TrainJourney::with(['train_station_depart', 'train_station_arrival'])->where('train_no', $dt->train_no)->first();
            $passenger = Passenger::where('id_no', $dt->booking_code)->get();
            $dt["train_journey"] = $findJourney;
            $dt["passengers"] = $passenger;
            if ($passenger) {
                foreach ($passenger as $psg) {
                    $seat = WagonSeat::where('passenger_id', $dt->id)->first();
                    $psg["seat"] = $seat;
                }
            }
        }
        return response()->json($data);
    }
}
