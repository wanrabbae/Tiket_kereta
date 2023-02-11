<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class WagonSeat extends Model
{
    use HasFactory;
    protected $table = 'train_wagon_seat';
    protected $guarded = [];
    public $timestamps = false;

    public function wagon()
    {
        return $this->belongsTo(Wagon::class, 'wagon_id');
    }
}
