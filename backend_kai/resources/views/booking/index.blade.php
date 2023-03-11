@extends('templating.template')
<style>
    #table-print,
    #table-print>thead,
    #table-print>tbody,
    #table-print>th,
    #table-print>td {
        border: 1px solid black;
    }

    #table-print>thead>tr>th,
    #table-print>tbody>tr>td {
        padding: 10px;
        border: 1px solid black;
    }
</style>
@section('content')
    <div class="page-wrapper">
        <!-- ============================================================== -->
        <!-- Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <div class="page-breadcrumb">
            <div class="row align-items-center">
                <div class="col-6">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb mb-0 d-flex align-items-center">
                            <li class="breadcrumb-item"><a href="index.html" class="link"><i class="mdi mdi-home-outline fs-4"></i></a></li>
                            <li class="breadcrumb-item active" aria-current="page">Starter Page</li>
                        </ol>
                    </nav>
                    <h1 class="mb-0 fw-bold">{{ $title ?? '' }}</h1>
                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End Bread crumb and right sidebar toggle -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Container fluid  -->
        <!-- ============================================================== -->
        <div class="container-fluid">
            <!-- ============================================================== -->
            <!-- Start Page Content -->
            <!-- ============================================================== -->
            <div class="row">
                <div class="col-12">
                    <div class="pb-2 d-flex justify-content-between">
                        <div class="d-flex">
                            <form action="" method="get" class="d-flex align-items-center">
                                @csrf
                                <input type="date" name="start" id="start" class="form-control">
                                <input type="date" name="end" id="end" class="form-control ms-2">
                                {{-- @if ($isFiltered) --}}
                                <a href="/booking" class="fs-3 ms-2 mdi mdi-refresh"></a>
                                {{-- @endif --}}
                                <button class="btn btn-success text-white btn-lg ms-2" type="sub
                            " name="filter">Filter</button>
                            </form>
                        </div>
                        <button class="btn btn-success text-white btn-lg ms-4" onclick="printDiv()">Export</button>
                    </div>
                    <div class="card">
                        <div class="card-body" id="table1">
                            <table id="customer-table" class="table-class" style="width:100%">
                                <div class="card-body" id="#">
                                    <thead>
                                        <tr>
                                            <th>No</th>
                                            <th>Booking Code</th>
                                            <th>Customer Name</th>
                                            <th>Class Type</th>
                                            <th>Booking Seat Count</th>
                                            <th>Payment Total</th>
                                            <th>Payment Status</th>
                                            <th>Booking Date</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php $no = 1; ?>
                                        @foreach ($bookings as $booking)
                                            <?php
                                            // $pay_status = if($booking->payment_status == 'paid') {return 'success'}else if($booking->payment_status == 'pending') {return 'warning'} else {return 'danger'};
                                            ?>
                                            <tr>
                                                <td>{{ $no++ }}</td>
                                                <td>{{ $booking->booking_code }}</td>
                                                <td>{{ $booking->customer->name }}</td>
                                                <td>{{ $booking->train_fare[0]->class }}</td>
                                                <td>{{ $booking->booking_count }}</td>
                                                <td>Rp. {{ number_format($booking->payment_total, 2, ',', '.') }}</td>
                                                <td>
                                                    @if ($booking->payment_status == 'paid')
                                                        <span class="text-success fw-bold">{{ $booking->payment_status }}</span>
                                                    @elseif ($booking->payment_status == 'pending')
                                                        <span class="text-warning fw-bold">{{ $booking->payment_status }}</span>
                                                    @else
                                                        <span class="text-danger fw-bold">{{ $booking->payment_status }}</span>
                                                    @endif
                                                </td>
                                                <td>{{ $booking->booking_date }}</td>
                                                <td class="hidden">
                                                    <button type="button" class="btn btn-sm btn-success text-white" class="btn btn-info btn-lg" data-bs-toggle="modal"
                                                        data-bs-target="#staticBackdrop2{{ $booking->id }}" id="editCustomer">Detail</button>

                                                    {{-- MODAL EDIT --}}
                                                    <div class="modal fade" id="staticBackdrop2{{ $booking->id }}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                                        aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
                                                            <div class="modal-content">
                                                                <div class="modal-header">
                                                                    <h1 class="modal-title fs-2" id="staticBackdropLabel">Detail Booking {{ $booking->customer->name }}</h1>
                                                                    <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                </div>
                                                                <div class="modal-body">
                                                                    <ul class="list-group">
                                                                        <li class="list-group-item active fs-3 fw-bold" aria-current="true">
                                                                            Customer Name: {{ $booking->customer->name }}
                                                                        </li>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Booking Code</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->booking_code }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Class Type</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_fare[0]->class }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Booking Seat Count</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->booking_count }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Payment Total</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->payment_total }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Payment Status</li>
                                                                            @if ($booking->payment_status == 'paid')
                                                                                <li class="list-group-item w-50 text-success">{{ $booking->payment_status }}</li>
                                                                            @elseif ($booking->payment_status == 'pending')
                                                                                <li class="list-group-item w-50 text-warning">{{ $booking->payment_status }}</li>
                                                                            @else
                                                                                <li class="list-group-item w-50 text-danger">{{ $booking->payment_status }}</li>
                                                                            @endif

                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Booking Date</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->booking_date }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Train No</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_fare[0]->train_no }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Station Depart</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_journey->train_station_depart->station_name ?? 'N/A' }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Station Arrival</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_journey->train_station_arrival->station_name ?? 'N/A' }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Station Depart Time</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_journey->depart_time ?? 'N/A' }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Station Arrival Time</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->train_journey->arrival_time ?? 'N/A' }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Customer Idendity Card Number</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->customer->id }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Customer Email</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->customer->email }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Customer City</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->customer->city }}</li>
                                                                        </ul>
                                                                        <ul class="list-group list-group-horizontal">
                                                                            <li class="list-group-item w-50">Customer Country</li>
                                                                            <li class="list-group-item w-50 fw-bold">{{ $booking->customer->country }}</li>
                                                                        </ul>
                                                                    </ul>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                </div>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>
                                        @endforeach
                                    </tbody>
                            </table>
                        </div>
                    </div>

                    <div id="print-area">
                        <h2 class="text-center pb-3">Booking Data</h2>
                        <table class="table-class" id="table-print" style="width:100%">
                            <thead>
                                <tr>
                                    <th>No</th>
                                    <th>Booking Code</th>
                                    <th>Customer Name</th>
                                    <th>Class Type</th>
                                    <th>Booking Seat Count</th>
                                    <th>Payment Total</th>
                                    <th>Payment Status</th>
                                    <th>Booking Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $no = 1; ?>
                                @foreach ($bookings as $booking)
                                    <?php
                                    // $pay_status = if($booking->payment_status == 'paid') {return 'success'}else if($booking->payment_status == 'pending') {return 'warning'} else {return 'danger'};
                                    ?>
                                    <tr>
                                        <td>{{ $no++ }}</td>
                                        <td>{{ $booking->booking_code }}</td>
                                        <td>{{ $booking->customer->name }}</td>
                                        <td>{{ $booking->train_fare[0]->class }}</td>
                                        <td>{{ $booking->booking_count }}</td>
                                        <td>Rp. {{ number_format($booking->payment_total, 2, ',', '.') }}</td>
                                        <td>
                                            @if ($booking->payment_status == 'paid')
                                                <span class="text-success fw-bold">{{ $booking->payment_status }}</span>
                                            @elseif ($booking->payment_status == 'pending')
                                                <span class="text-warning fw-bold">{{ $booking->payment_status }}</span>
                                            @else
                                                <span class="text-danger fw-bold">{{ $booking->payment_status }}</span>
                                            @endif
                                        </td>
                                        <td>{{ $booking->booking_date }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>
        <!-- ============================================================== -->
        <!-- End PAge Content -->
        <!-- ============================================================== -->
        <!-- ============================================================== -->
        <!-- Right sidebar -->
        <!-- ============================================================== -->
        <!-- .right-sidebar -->
        <!-- ============================================================== -->
        <!-- End Right sidebar -->
        <!-- ============================================================== -->
    </div>
    <!-- ============================================================== -->
    <!-- End Container fluid  -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- footer -->
    <!-- ============================================================== -->
    <footer class="footer text-center">
        All Rights Reserved by Flexy Admin. Designed and Developed by <a href="https://www.wrappixel.com">WrapPixel</a>.
    </footer>
    <script>
        var table = $('#customer-table').DataTable({
            scrollX: true
        });
        $('#print-area').hide()

        async function printDiv() {
            $('#table1').hide();
            $('#print-area').show()

            var printContents = document.getElementById("print-area").innerHTML;
            var originalContents = document.body.innerHTML;
            document.body.innerHTML = printContents;

            $('#table1').show();
            await window.print();
            window.location.reload()
            $('#print-area').hide();
            document.body.innerHTML = originalContents;
        }
    </script>
    <!-- ============================================================== -->
    <!-- End footer -->
    <!-- ============================================================== -->
    </div>
@endsection
