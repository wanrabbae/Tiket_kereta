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
                            <li class="breadcrumb-item active" aria-current="page">Dashboard</li>
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
            <!-- Sales chart -->
            <!-- ============================================================== -->
            <div class="row">
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class=" d-flex align-items-center">
                                <i class="mdi mdi-cart-outline display-3 text-primary"></i>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold fs-3">Income</h5>
                                    <span class="badge bg-light fs-6 text-success text-sm">Rp. {{ number_format($income, 2, ',', '.') }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <i class="mdi mdi-account-multiple display-3 text-warning"></i>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold fs-3">Customers</h5>
                                    <span class="badge bg-light fs-6 text-success text-sm">{{ $customer }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex align-items-center">
                                <i class="mdi mdi-subway display-3 text-success"></i>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold fs-3">Train Stations</h5>
                                    <span class="badge bg-light fs-6 text-success text-sm">{{ $station }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class=" d-flex align-items-center">
                                <i class="mdi mdi-train display-3 text-info"></i>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold fs-3">Trains</h5>
                                    <span class="badge bg-light fs-6 text-success text-sm">{{ $train }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class=" d-flex align-items-center">
                                <i class="mdi mdi-account text-danger display-3"></i>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold fs-3">Users</h5>
                                    <span class="badge bg-light fs-6 text-success text-sm">{{ $user }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
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
        <!-- ============================================================== -->
        <!-- End footer -->
        <!-- ============================================================== -->
    </div>
@endsection
