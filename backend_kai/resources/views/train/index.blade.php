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
                                        <th>Train Name</th>
                                        <th>Train No</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($trains as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->train_name }}
                                            </td>
                                            <td>
                                                {{ $item->train_no }}
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
                                                            <div class="modal-body">
                                                                <form action="/trains/update/{{ $item->id }}" method="post">
                                                                    @csrf
                                                                    <div class="mb-3">
                                                                        <label for="train_name">Train Name</label>
                                                                        <input required type="text" value="{{ $item->train_name }}" name="train_name" id="train_name" class="form-control"
                                                                            placeholder="Enter station name" value="{{ old('train_name') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="train_no">Train No</label>
                                                                        <input required class="form-control" list="datalistOptions" value="{{ $item->train_no }}" id="exampleDataList" name="train_no"
                                                                            placeholder="Enter train no...">
                                                                        <datalist id="datalistOptions">
                                                                            @foreach ($train_fares as $fare)
                                                                                <option value="{{ $fare->train_no }}">
                                                                            @endforeach
                                                                        </datalist>
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
                                                <a href="/trains/{{ $item->id }}/wagon" class="btn btn-sm btn-info">Train Car</a>
                                                |
                                                <a class="btn btn-sm btn-danger" href="/trains/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
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
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create New Train</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/trains/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="train_name">Train Name</label>
                                <input required type="text" name="train_name" id="train_name" class="form-control" placeholder="Enter station name" value="{{ old('train_name') }}">
                            </div>
                            <div class="mb-3">
                                <label for="train_no">Train No</label>
                                <input required class="form-control" list="datalistOptions2" value="{{ old('train_no') }}" id="exampleDataList" name="train_no" placeholder="Enter train no...">
                                <datalist id="datalistOptions2">
                                    @foreach ($train_fares as $fare)
                                        <option value="{{ $fare->train_no }}">
                                    @endforeach
                                </datalist>
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
            $('#customer-table').DataTable({
                scrollX: true
            });
        </script>
    </div>
@endsection
