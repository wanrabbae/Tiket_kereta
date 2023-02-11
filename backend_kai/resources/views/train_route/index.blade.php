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
            <div class="container mb-2">
                @if ($errors->any())
                    <div class="alert alert-danger p-2" role="alert">
                        {{ $errors->first() }}
                    </div>
                @endif

                @if (session()->has('success'))
                    <div class="alert alert-success p-2" role="alert">
                        {{ session()->get('success') }}
                    </div>
                @endif
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="container pb-2 d-flex justify-content-end">
                        <button type="button" class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#staticBackdrop">Add</button>
                    </div>
                    <div class="card">
                        <div class="card-body">
                            <table id="customer-table" class="display" style="width:100%">
                                <thead>
                                    <tr>
                                        <th>No</th>
                                        <th>Train No</th>
                                        <th>Start Route</th>
                                        <th>End Route</th>
                                        <th>Route Seq</th>
                                        <th>Depart Time</th>
                                        <th>Arrival Time</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($train_routes as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->train_no }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->start_route }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->end_route }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->route_seq }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->depart_time }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->arrival_time }}
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-success" class="btn btn-primary btn-lg" data-bs-toggle="modal"
                                                    data-bs-target="#staticBackdrop2{{ $item->id }}" id="editCustomer">Edit</button>

                                                {{-- MODAL EDIT --}}
                                                <div class="modal fade" id="staticBackdrop2{{ $item->id }}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                                    aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h1 class="modal-title fs-2" id="staticBackdropLabel">Edit Station</h1>
                                                                <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="/trains/route/update/{{ $item->id }}" method="post">
                                                                @csrf
                                                                <div class="modal-body">
                                                                    <div class="mb-3">
                                                                        <label for="train_no">Train No</label>
                                                                        <input required class="form-control" list="datalistOptions" value="{{ $item->train_no }}" id="exampleDataList" name="train_no"
                                                                            placeholder="Type to search...">
                                                                        <datalist id="datalistOptions">
                                                                            @foreach ($train_fares as $fare)
                                                                                <option value="{{ $fare->train_no }}">
                                                                            @endforeach
                                                                        </datalist>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="start_route">Start Route</label>
                                                                        <input value="{{ $item->start_route }}" required type="text" name="start_route" id="start_route" class="form-control"
                                                                            placeholder="Enter start_route" value="{{ old('start_route') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="end_route">End Route</label>
                                                                        <input value="{{ $item->end_route }}" required type="text" name="end_route" id="end_route" class="form-control"
                                                                            placeholder="Enter end_route" value="{{ old('end_route') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="route_seq">Route Seq</label>
                                                                        <input value="{{ $item->route_seq }}" required type="text" name="route_seq" id="route_seq" class="form-control"
                                                                            placeholder="Enter route_seq" value="{{ old('route_seq') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="depart_time">Depart Time</label>
                                                                        <input value="{{ $item->depart_time }}" required type="date" name="depart_time" id="depart_time" class="form-control"
                                                                            placeholder="Enter depart_time" value="{{ old('depart_time') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="arrival_time">Arrival Time</label>
                                                                        <input value="{{ $item->arrival_time }}" required type="date" name="arrival_time" id="arrival_time" class="form-control"
                                                                            placeholder="Enter arrival_time" value="{{ old('arrival_time') }}">
                                                                    </div>
                                                                </div>
                                                                <div class="modal-footer">
                                                                    <button type="button" id="closeModal" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                                                    <button type="submit" class="btn btn-primary">Save</button>
                                                                </div>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                |

                                                <a class="btn btn-sm btn-danger" href="/trains/route/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
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

        {{-- MODAL CREATE --}}
        <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create New Station</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/trains/route/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="train_no">Train No</label>
                                <input required class="form-control" list="datalistOptions" value="{{ old('train_no') }}" id="exampleDataList" name="train_no" placeholder="Type to search...">
                                <datalist id="datalistOptions">
                                    @foreach ($train_fares as $fare)
                                        <option value="{{ $fare->train_no }}">
                                    @endforeach
                                </datalist>
                            </div>
                            <div class="mb-3">
                                <label for="start_route">Start Route</label>
                                <input required type="text" name="start_route" id="start_route" class="form-control" placeholder="Enter start_route" value="{{ old('start_route') }}">
                            </div>
                            <div class="mb-3">
                                <label for="end_route">End Route</label>
                                <input required type="text" name="end_route" id="end_route" class="form-control" placeholder="Enter end_route" value="{{ old('end_route') }}">
                            </div>
                            <div class="mb-3">
                                <label for="route_seq">Route Seq</label>
                                <input required type="text" name="route_seq" id="route_seq" class="form-control" placeholder="Enter route_seq" value="{{ old('route_seq') }}">
                            </div>
                            <div class="mb-3">
                                <label for="depart_time">Depart Time</label>
                                <input required type="date" name="depart_time" id="depart_time" class="form-control" placeholder="Enter depart_time" value="{{ old('depart_time') }}">
                            </div>
                            <div class="mb-3">
                                <label for="arrival_time">Arrival Time</label>
                                <input required type="date" name="arrival_time" id="arrival_time" class="form-control" placeholder="Enter arrival_time" value="{{ old('arrival_time') }}">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save</button>
                        </div>
                    </form>
                </div>
            </div>
            <!-- ============================================================== -->
            <!-- End Container fluid  -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- footer -->
            <!-- ============================================================== -->
            <!-- ============================================================== -->
            <!-- End footer -->
            <!-- ============================================================== -->
        </div>

        <footer class="footer text-center">
            All Rights Reserved by Flexy Admin. Designed and Developed by <a href="https://www.wrappixel.com">WrapPixel</a>.
        </footer>
        <script>
            $('#customer-table').DataTable();
        </script>
    </div>
@endsection
