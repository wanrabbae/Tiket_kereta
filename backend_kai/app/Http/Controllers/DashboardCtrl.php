<?php

namespace App\Http\Controllers;

use App\Models\Booking;
use App\Models\Customer;
use App\Models\Train;
use App\Models\TrainStation;
use App\Models\User;
use Illuminate\Http\Request;

class DashboardCtrl extends Controller
{
    public function index()
    {
        $income = Booking::where('payment_status', 'paid')->sum('payment_total');
        return view('index', [
            "title" => "KAI Dashboard",
            "income" => $income,
            "customer" => Customer::count(),
            "station" => TrainStation::count(),
            "train" => Train::count(),
            "user" => User::count(),
        ]);
    }
}
