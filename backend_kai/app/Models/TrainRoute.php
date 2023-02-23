<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainRoute extends Model
{
    use HasFactory;

    protected $table = 'train_route';
    protected $guarded = [];

    public function train_journey()
    {
        return $this->belongsTo(TrainJourney::class, 'train_no');
    }

    public function get_passenger()
    {
        return $this->hasMany(DetailBooking::class, 'travel_no');
    }

    public function train_station_start()
    {
        return $this->belongsTo(TrainStation::class, 'start_route');
    }
    public function train_station_end()
    {
        return $this->belongsTo(TrainStation::class, 'end_route');
    }
}
