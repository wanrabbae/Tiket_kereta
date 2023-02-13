<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Wagon extends Model
{
    use HasFactory;
    protected $table = 'train_wagon';
    protected $guarded = [];
    public $timestamps = false;

    public function train()
    {
        return $this->belongsTo(Train::class, 'train_id');
    }
    public function wagon_seat()
    {
        return $this->hasMany(WagonSeat::class, 'wagon_id');
    }

    public static function boot()
    {
        parent::boot();

        static::deleting(function ($wagon) { // before delete() method call this
            $wagon->wagon_seat()->delete();
            // do the rest of the cleanup...
        });
    }
}
