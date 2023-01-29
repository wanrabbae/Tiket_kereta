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
        Schema::create('train_route', function (Blueprint $table) {
            $table->bigIncrements("id");
            $table->string("train_no");
            $table->string("start_route");
            $table->string("end_route");
            $table->smallInteger("route_seq");
            $table->date("depart_time");
            $table->date("arrival_time");
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
        Schema::dropIfExists("train_route");
    }
};
