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
                                        <th>Class</th>
                                        <th>Train No</th>
                                        <th>Fare</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($train_fares as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->class }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->train_no }}
                                            </td>
                                            <td id="item->email">
                                                Rp. {{ number_format($item->fare, 2, ',', '.') }}
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
                                                                <h1 class="modal-title fs-2" id="staticBackdropLabel">Edit Train Fare</h1>
                                                                <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="/trains/fare/update/{{ $item->id }}" method="post">
                                                                @csrf
                                                                <div class="modal-body">
                                                                    <div class="mb-3">
                                                                        <label for="class">Class</label>
                                                                        <select name="class" id="class" class="form-select">
                                                                            <option class="form-option" value="ECONOMY" {{ $item->class == 'ECONOMY' ? 'selected' : '' }}>ECONOMY</option>
                                                                            <option class="form-option" value="BUSINESS" {{ $item->class == 'BUSINESS' ? 'selected' : '' }}>BUSINESS</option>
                                                                            <option class="form-option" value="EXECUTIVE" {{ $item->class == 'EXECUTIVE' ? 'selected' : '' }}>EXECUTIVE</option>
                                                                        </select>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="exampleDataList" class="form-label">Choose Train No</label>
                                                                        <input required class="form-control" list="datalistOptions" value="{{ $item->train_no }}" id="exampleDataList" name="train_no"
                                                                            placeholder="Type to search...">
                                                                        <datalist id="datalistOptions">
                                                                            <option value="TRAIN001">
                                                                            <option value="TRAIN002">
                                                                            <option value="TRAIN003">
                                                                            <option value="TRAIN004">
                                                                            <option value="TRAIN005">
                                                                        </datalist>
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="fare">Fare</label>
                                                                        <input required type="number" name="fare" id="fare" class="form-control" placeholder="Enter fare"
                                                                            value="{{ $item->fare }}">
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
                                                <a class="btn btn-sm btn-danger" href="/trains/fare/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
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
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create New Fare</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/trains/fare/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="class">Class</label>
                                <select name="class" id="class" class="form-select">
                                    <option class="form-option" value="ECONOMY">ECONOMY</option>
                                    <option class="form-option" value="BUSINESS">BUSINESS</option>
                                    <option class="form-option" value="EXECUTIVE">EXECUTIVE</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="exampleDataList" class="form-label">Train No</label>
                                <input required class="form-control" id="exampleDataList" name="train_no" placeholder="Train No">
                            </div>
                            <div class="mb-3">
                                <label for="fare">Fare</label>
                                <input required type="number" name="fare" id="fare" class="form-control" placeholder="Enter fare" value="{{ old('fare') }}">
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
