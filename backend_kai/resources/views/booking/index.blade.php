@extends('templating.template')

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
                    <div class="container pb-2 d-flex justify-content-end">
                        <button class="btn btn-primary btn-lg">Add</button>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="customer-table" class="display" style="width:100%">
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
                                            <td><span class="text-success fw-bold">{{ $booking->payment_status }}</span>
                                            </td>
                                            <td>{{ $booking->booking_date }}</td>
                                            <td>
                                                <a href="/booking/detail/:id" class="btn btn-info text-white">Detail</a>
                                            </td>
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
            $(document).ready(function() {
                $('#customer-table').DataTable();
            });
        </script>
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
@endsection
