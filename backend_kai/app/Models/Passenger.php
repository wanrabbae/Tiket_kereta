<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Passenger extends Model
{
    use HasFactory;

    protected $table = 'passenger';
    protected $guarded = [];

    public function detail_booking()
    {
        return $this->belongsTo(DetailBooking::class, 'book_det');
    }

    public function wagon_seat()
    {
        return $this->belongsTo(WagonSeat::class, 'passenger_id');
    }
}
