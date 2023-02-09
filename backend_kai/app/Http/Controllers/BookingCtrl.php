<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BookingCtrl extends Controller
{
    public function getData()
    {

        return view('booking.index', [
            "title" => "KAI booking"
        ]);
    }
}
