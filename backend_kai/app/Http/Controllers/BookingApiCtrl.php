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
use Illuminate\Support\Str;
use App\Models\WagonSeat;
use Carbon\Carbon;
use Illuminate\Support\Facades\Validator;

class BookingApiCtrl extends Controller
{
    public function getBooking(Request $request)
    {
        $data = Booking::where('customer_id', $request->user()->id)->orderBy('id', 'DESC')->get();
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

    public function booking(Request $request)
    {
        $validate = Validator::make($request->all(), [
            "count" => "required|int",
            "payment_total" => "required|max:100",
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 400);
        }

        // booking table
        $book_code = "TRX-" . Str::random(5);
        $customer_id = $request->user()->id;
        $book_date = Carbon::now()->toDateTimeString();
        $book_count = $request->count;
        $payment_total = $request->payment_total;
        $payment_status = 'paid';
        $train_no = $request->train_no;

        if ($booking = Booking::create([
            "booking_code" => $book_code,
            "customer_id" => $customer_id,
            "booking_date" => $book_date,
            "booking_count" => $book_count,
            "payment_total" => $payment_total,
            "payment_status" => $payment_status,
            "train_no" => $train_no,
        ])) {
            // det booking table
            $travel_no = $request->travel_no ?? 0;
            $fare_id = $request->fare_id ?? null;

            if ($det_book = DetailBooking::create([
                "travel_no" => $travel_no,
                "fare_id" => $fare_id,
                "booking_code" => $booking->booking_code,
            ])) {
                foreach ($request->passengers as $passenger) {
                    $book_det = $det_book->id; // detail booking id;
                    $name = $passenger["name"];
                    $id_no = $booking->booking_code;
                    $status = $passenger["status"];
                    $wagon_seat_id = $passenger["wagon_seat_id"];

                    $psg = Passenger::create([
                        "book_det" => $book_det,
                        "name" => $name,
                        "id_no" => $id_no,
                        "status" => $status
                    ]);

                    if ($psg) {
                        WagonSeat::find($wagon_seat_id)->update(["passenger_id" => $psg->id]);
                    }
                }

                $data = Booking::where('id', $booking->id)->first();

                $findJourney = TrainJourney::with(['train_station_depart', 'train_station_arrival'])->where('train_no', $data->train_no)->first();
                $passenger = Passenger::where('id_no', $data->booking_code)->get();
                $data["train_journey"] = $findJourney;
                $data["passengers"] = $passenger;
                if ($passenger) {
                    foreach ($passenger as $psg) {
                        $seat = WagonSeat::where('passenger_id', $data->id)->first();
                        $psg["seat"] = $seat;
                    }
                }
                return response()->json([$data], 201);
            }
        }
    }
}
