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
                                        <th>Fare</th>
                                        <th>Payment Status</th>
                                        <th>Bookin Date</th>
                                        <th>Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <td>1</td>
                                    <td>TRX-001</td>
                                    <td>Alwan</td>
                                    <td>ECONOMY</td>
                                    <td>Rp. 245.000,00</td>
                                    <td><span class="text-success fw-bold">Paid</span></td>
                                    <td>2020-10-10</td>
                                    <td>Dewasa</td>
                                    <td>
                                        <a href="/booking/detail/:id" class="btn btn-info text-white">Detail</a>
                                    </td>
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
