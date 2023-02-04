<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TrainFare extends Model
{
    use HasFactory;

    protected $table = 'train_fare';
    protected $guarded = [];
}
