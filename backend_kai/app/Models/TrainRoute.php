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
}
