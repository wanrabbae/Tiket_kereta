<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('train_journeys', function (Blueprint $table) {
            $table->id();
            $table->string("depart_station");
            $table->string("arrival_station");
            $table->string("train_no");
            $table->date("depart_time");
            $table->date("arrival_time");
            $table->unsignedBigInteger("train_id");
            $table->foreign("train_id")->references("id")->on("trains");
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists("train_journeys");
    }
};
