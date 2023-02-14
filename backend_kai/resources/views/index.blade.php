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
                <div class="col-lg-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-md-flex align-items-center">
                                <div>
                                    <h4 class="card-title">Sales Summary</h4>
                                    <h6 class="card-subtitle">Ample admin Vs Pixel admin</h6>
                                </div>
                                <div class="ms-auto d-flex no-block align-items-center">
                                    <ul class="list-inline dl d-flex align-items-center m-r-15 m-b-0">
                                        <li class="list-inline-item d-flex align-items-center text-warning"><i class="fa fa-circle font-10 me-1"></i> Pending
                                        </li>
                                        <li class="list-inline-item d-flex align-items-center text-success"><i class="fa fa-circle font-10 me-1"></i> Pixel
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="amp-pxl mt-4" style="height: 350px;">
                                <div class="chartist-tooltip"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="card">
                        <div class="card-body">
                            <div class="pb-3 d-flex align-items-center">
                                <span class="btn btn-primary btn-circle d-flex align-items-center">
                                    <i class="mdi mdi-cart-outline fs-4"></i>
                                </span>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold">Income</h5>
                                    <span class="badge bg-light text-success text-sm">Rp. {{ number_format($income, 2, ',', '.') }}</span>
                                </div>
                            </div>
                            <div class="py-3 d-flex align-items-center">
                                <span class="btn btn-warning btn-circle d-flex align-items-center">
                                    <i class="mdi mdi-account-multiple fs-4"></i>
                                </span>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold">Customers</h5>
                                    <span class="badge bg-light text-success text-sm">{{ $customer }}</span>
                                </div>
                            </div>
                            <div class="py-3 d-flex align-items-center">
                                <span class="btn btn-success btn-circle d-flex align-items-center">
                                    <i class="mdi mdi-subway text-white fs-4"></i>
                                </span>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold">Train Stations</h5>
                                    <span class="badge bg-light text-success text-sm">{{ $station }}</span>
                                </div>
                            </div>
                            <div class="py-3 d-flex align-items-center">
                                <span class="btn btn-info btn-circle d-flex align-items-center">
                                    <i class="mdi mdi-train fs-4 text-white"></i>
                                </span>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold">Trains</h5>
                                    <span class="badge bg-light text-success text-sm">{{ $train }}</span>
                                </div>
                            </div>

                            <div class="pt-3 d-flex align-items-center">
                                <span class="btn btn-danger btn-circle d-flex align-items-center">
                                    <i class="mdi mdi-account fs-4 text-white"></i>
                                </span>
                                <div class="ms-3">
                                    <h5 class="mb-0 fw-bold">Users</h5>
                                    <span class="badge bg-light text-success text-sm">{{ $user }}</span>
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
