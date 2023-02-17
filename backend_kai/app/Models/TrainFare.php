<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainFare extends Model
{
    use HasFactory;

    protected $table = 'train_fare';
    protected $guarded = [];

    public function train_journey()
    {
        return $this->hasMany(TrainJourney::class, 'train_no');
    }

    public function wagon()
    {
        return $this->hasMany(Wagon::class, 'fare_id');
    }
}
