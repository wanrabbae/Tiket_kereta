<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainStation extends Model
{
    use HasFactory;

    protected $table = 'train_station';
    protected $guarded = [];
}
