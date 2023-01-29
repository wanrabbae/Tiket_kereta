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
