<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\TrainFare;
use Illuminate\Http\Request;

class BookingCtrl extends Controller
{
    public function getData(Request $request)
    {
        if ($request->has('filter')) {
            $data = Booking::with(['customer', 'detail_booking'])->whereBetween('booking_date', [$request->get('start'), $request->get('end')])->get();
            foreach ($data as $dt) {
                $findFare = TrainFare::where('train_no', $dt->train_no)->get();
                $dt["train_fare"] = $findFare;
            }
            return view('booking.index', [
                "title" => "KAI booking",
                "bookings" => $data
            ]);
        } else {
            $data = Booking::with(['customer', 'detail_booking'])->get();
            foreach ($data as $dt) {
                $findFare = TrainFare::where('train_no', $dt->train_no)->get();
                $dt["train_fare"] = $findFare;
            }
            return view('booking.index', [
                "title" => "KAI booking",
                "bookings" => $data
            ]);
        }
    }
}
