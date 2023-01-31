<!DOCTYPE html>
<html dir="ltr" lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- Tell the browser to be responsive to screen width -->
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="KAI, KAI INDONESIA, KAI ALWAN">
    <meta name="description" content="Flexy Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
    <meta name="robots" content="noindex,nofollow">
    <title>{{ $title ?? 'KAI Admin System' }}</title>
    <link rel="canonical" href="https://www.wrappixel.com/templates/Flexy-admin-lite/" />
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="{{ url('/template/assets/images/favicon.png') }}">
    <!-- Custom CSS -->
    <link href="{{ url('/template/assets/libs/chartist/dist/chartist.min.css') }}" rel="stylesheet">
    <link href="{{ url('/template/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.css" rel="stylesheet') }}">
    <!-- Custom CSS -->
    <link href="{{ url('/template/dist/css/style.min.css') }}" rel="stylesheet">
    {{-- JQUERY --}}
    <script src="{{ url('/template/assets/libs/jquery/dist/jquery.min.js') }}"></script>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.1/css/jquery.dataTables.min.css">
    <script src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
<![endif]-->
</head>

<body>
    <style>
        .wrapper {
            width: 100%;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url("https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/MRTset3.jpg/1600px-MRTset3.jpg");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }
    </style>
    <div class="wrapper">
        <div class="row">
            <div class="col-md-12">
                <div class="card p-3">
                    <div class="card-body">
                        <div class="d-flex justify-content-center mb-3">
                            <img src="{{ url('/kai.png') }}" alt="homepage" class="dark-logo" width="100">
                        </div>
                        @if (session()->has('error'))
                            <span class="text-center text-danger text-sm py-2">
                                {{ session()->get('error') }}
                            </span>
                        @endif
                        <form class="form-horizontal form-material mx-2" method="POST" action="/login">
                            @csrf
                            <div class="form-group">
                                <label class="col-md-12">Email</label>
                                <div class="col-md-12">
                                    <input type="email" name="email" placeholder="Enter Email" class="form-control form-control-line">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-md-12">Password</label>
                                <div class="col-md-12">
                                    <input type="password" name="password" class="form-control form-control-line" placeholder="Enter Password">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="d-flex justify-content-center">
                                        <button type="submit" class="btn btn-success text-white">Login</button>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- ============================================================== -->
    <!-- End Wrapper -->
    <!-- ============================================================== -->
    <!-- ============================================================== -->
    <!-- All Jquery -->
    <!-- ============================================================== -->

    <!-- Bootstrap tether Core JavaScript -->
    <script src="{{ url('/template/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js') }}"></script>
    <script src="{{ url('/template/dist/js/app-style-switcher.js') }}"></script>
    <!--Wave Effects -->
    <script src="{{ url('/template/dist/js/waves.js') }}"></script>
    <!--Menu sidebar -->
    <script src="{{ url('/template/dist/js/sidebarmenu.js') }}"></script>
    <!--Custom JavaScript -->
    <script src="{{ url('/template/dist/js/custom.js') }}"></script>
    <!--This page JavaScript -->
    <!--chartis chart-->
    <script src="{{ url('/template/assets/libs/chartist/dist/chartist.min.js') }}"></script>
    <script src="{{ url('/template/assets/libs/chartist-plugin-tooltips/dist/chartist-plugin-tooltip.min.js') }}"></script>
    <script src="{{ url('/template/dist/js/pages/dashboards/dashboard1.js') }}"></script>
</body>

</html>
