<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Train extends Model
{
    use HasFactory;

    protected $table = 'trains';
    protected $guarded = [];

    public function wagon()
    {
        return $this->hasMany(Wagon::class, 'train_id');
    }

    public static function boot()
    {
        parent::boot();

        static::deleting(function ($train) { // before delete() method call this
            $train->wagon()->delete();
            // do the rest of the cleanup...
        });
    }
}
