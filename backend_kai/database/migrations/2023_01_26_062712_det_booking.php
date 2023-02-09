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
        Schema::create('det_booking', function (Blueprint $table) {
            $table->bigIncrements("id");
            $table->integer("travel_no");
            $table->string("status")->nullable();
            $table->unsignedBigInteger("fare_id")->nullable();
            $table->foreign("fare_id")->references("id")->on("train_fare")->onDelete("cascade");
            $table->string("booking_code");
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
        Schema::dropIfExists("det_booking");
    }
};
