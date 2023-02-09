<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainJourney extends Model
{
    use HasFactory;

    protected $table = 'train_journeys';
    protected $guarded = [];

    public function train()
    {
        return $this->belongsTo(Train::class, 'train_id');
    }
    public function train_fare()
    {
        return $this->belongsTo(TrainFare::class, 'train_no');
    }
    public function train_station_depart()
    {
        return $this->belongsTo(TrainStation::class, 'depart_station');
    }
    public function train_station_arrival()
    {
        return $this->belongsTo(TrainStation::class, 'arrival_station');
    }
}
