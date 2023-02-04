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
                                        <th>Depart Station</th>
                                        <th>Arrival Station</th>
                                        <th>Train No</th>
                                        <th>Depart Time</th>
                                        <th>Arrival Time</th>
                                        <th>Train</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($train_journeys as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->train_station_depart->station_code }} | {{ $item->train_station_depart->station_name }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->train_station_arrival->station_code }} | {{ $item->train_station_arrival->station_name }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->train_no }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->depart_time }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->arrival_time }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->train->train_name }}
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
                                                                <h1 class="modal-title fs-2" id="staticBackdropLabel">Edit Train Journey</h1>
                                                                <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="/trains/journey/update/{{ $item->id }}" method="post">
                                                                @csrf
                                                                <div class="modal-body">
                                                                    <div class="mb-3">
                                                                        <label for="depart_station">Depart Station</label>
                                                                        <select class="form-select" required name="depart_station" id="depart_station">
                                                                            <option value="">Choose Station</option>
                                                                            @foreach ($train_station as $station)
                                                                                <option class="form-option" value="{{ $station->id }}"
                                                                                    {{ $item->train_station_depart->id == $station->id ? 'selected' : '' }}>{{ $station->station_code }} |
                                                                                    {{ $station->station_name }}
                                                                                </option>
                                                                            @endforeach
                                                                        </select>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="arrival_station">Arrival Station</label>
                                                                        <select class="form-select" required name="arrival_station" id="arrival_station">
                                                                            <option value="">Choose Station</option>
                                                                            @foreach ($train_station as $station)
                                                                                <option class="form-option" value="{{ $station->id }}"
                                                                                    {{ $item->train_station_arrival->id == $station->id ? 'selected' : '' }}>{{ $station->station_code }} |
                                                                                    {{ $station->station_name }}
                                                                                </option>
                                                                            @endforeach
                                                                        </select>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="train_no">Train No</label>
                                                                        <input required type="text" name="train_no" value="{{ $item->train_no }}" id="train_no" class="form-control"
                                                                            placeholder="Enter train_no" value="{{ old('train_no') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="depart_time">Depart Time</label>
                                                                        <input required type="date" name="depart_time" id="depart_time" value="{{ $item->depart_time }}" class="form-control"
                                                                            placeholder="Enter depart_time" value="{{ old('depart_time') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="arrival_time">Arrival Time</label>
                                                                        <input required type="date" name="arrival_time" id="arrival_time" value="{{ $item->arrival_time }}" class="form-control"
                                                                            placeholder="Enter arrival_time" value="{{ old('arrival_time') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="train_id">Select Train</label>
                                                                        <select required class="form-select" name="train_id" id="train_id">
                                                                            <option value="">Choose Train</option>
                                                                            @foreach ($trains as $train)
                                                                                <option class="form-option" value="{{ $train->id }}" {{ $item->train->id == $train->id ? 'selected' : '' }}>
                                                                                    {{ $train->train_name }}</option>
                                                                            @endforeach
                                                                        </select>
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
                                                <a class="btn btn-sm btn-danger" href="/trains/journey/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
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
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create Train Journey</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/trains/journey/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="depart_station">Depart Station</label>
                                <select class="form-select" required name="depart_station" id="depart_station">
                                    <option value="">Choose Station</option>
                                    @foreach ($train_station as $item)
                                        <option class="form-option" value="{{ $item->id }}">{{ $item->station_code }} | {{ $item->station_name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="arrival_station">Arrival Station</label>
                                <select class="form-select" required name="arrival_station" id="arrival_station">
                                    <option value="">Choose Station</option>
                                    @foreach ($train_station as $item)
                                        <option class="form-option" value="{{ $item->id }}">{{ $item->station_code }} | {{ $item->station_name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="train_no">Train No</label>
                                <input required type="text" name="train_no" id="train_no" class="form-control" placeholder="Enter train_no" value="{{ old('train_no') }}">
                            </div>
                            <div class="mb-3">
                                <label for="depart_time">Depart Time</label>
                                <input required type="date" name="depart_time" id="depart_time" class="form-control" placeholder="Enter depart_time" value="{{ old('depart_time') }}">
                            </div>
                            <div class="mb-3">
                                <label for="arrival_time">Arrival Time</label>
                                <input required type="date" name="arrival_time" id="arrival_time" class="form-control" placeholder="Enter arrival_time" value="{{ old('arrival_time') }}">
                            </div>
                            <div class="mb-3">
                                <label for="train_id">Select Train</label>
                                <select required class="form-select" name="train_id" id="train_id">
                                    <option value="">Choose Train</option>
                                    @foreach ($trains as $item)
                                        <option class="form-option" value="{{ $item->id }}">{{ $item->train_name }}</option>
                                    @endforeach
                                </select>
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
