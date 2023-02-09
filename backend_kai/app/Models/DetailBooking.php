<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DetailBooking extends Model
{
    use HasFactory;

    protected $table = 'det_booking';

    public function booking()
    {
        return $this->belongsTo(Booking::class, 'booking_code');
    }
    public function passenger()
    {
        return $this->hasMany(Passenger::class, 'book_det');
    }
    public function train_route()
    {
        return $this->belongsTo(TrainRoute::class, 'travel_no');
    }
}
