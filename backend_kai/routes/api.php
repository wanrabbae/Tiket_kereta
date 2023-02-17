<?php

use App\Http\Controllers\NewsCtrl;
use App\Http\Controllers\TrainApiCtrl;
use App\Http\Controllers\TrainCtrl;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
// NEWS API
Route::get('/news', [NewsCtrl::class, 'getNews']);
Route::get('/news/{id}', [NewsCtrl::class, 'getSingleNews']);

// TRAIN STATION
Route::get('/stations', [TrainApiCtrl::class, 'getStations']);

// FIND TICKET
Route::get('/findTicket', [TrainApiCtrl::class, 'findTicket']);
// SEAT LIST
Route::get('/listSeat', [TrainApiCtrl::class, 'getListSeat']);
