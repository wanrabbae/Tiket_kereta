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
        Schema::create('booking', function (Blueprint $table) {
            $table->bigIncrements("id");
            $table->string("booking_code");
            $table->unsignedBigInteger("customer_id");
            $table->foreign("customer_id")->references("id")->on("customers")->onDelete("cascade");
            $table->dateTime("booking_date")->default(date(now()));
            $table->integer("booking_count")->nullable();
            $table->string("status")->nullable();
            $table->integer("payment_total")->nullable();
            $table->string("payment_status")->default("pending");
            $table->string("train_no");
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
        Schema::dropIfExists("booking");
    }
};
