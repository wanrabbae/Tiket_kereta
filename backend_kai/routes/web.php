<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// DASHBOARD
Route::get('/', function () {
    return view('index', [
        "title" => "KAI Dashboard"
    ]);
});

// TRAINS
Route::get('/trains', function () {
    return view('train.index', [
        "title" => "KAI Trains"
    ]);
});

// TRAIN STATIONS
Route::get('/train_station', function () {
    return view('train_station.index', [
        "title" => "KAI Train Stations"
    ]);
});

// TRAINS JOURNEY
Route::get('/trains/journey', function () {
    return view('train.index', [
        "title" => "KAI Journey"
    ]);
});
// TRAINS ROUTE
Route::get('/trains/route', function () {
    return view('train.index', [
        "title" => "KAI Route"
    ]);
});
// TRAINS FARE
Route::get('/trains/fare', function () {
    return view('train.index', [
        "title" => "KAI Fare"
    ]);
});

// CUSTOMER
Route::get('/customers', function () {
    return view('customer.index', [
        "title" => "KAI Customer"
    ]);
});

// BOOKING DATA
Route::get('/booking', function () {
    return view('booking.index', [
        "title" => "KAI booking"
    ]);
});


// BOOKING DATA
Route::get('/users', function () {
    return view('users.index', [
        "title" => "KAI Pengguna Sistem"
    ]);
});
