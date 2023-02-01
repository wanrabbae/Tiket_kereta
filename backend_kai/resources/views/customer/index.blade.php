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
                                        <th>No KTP</th>
                                        <th>Nama</th>
                                        <th>Email</th>
                                        <th>City</th>
                                        <th>Country</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    @foreach ($customers as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $item->id }}
                                            </td>
                                            <td id="item->name">
                                                {{ $item->name }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->email }}
                                            </td>
                                            <td id="item->city">
                                                {{ $item->city }}
                                            </td>
                                            <td id="item->country">
                                                {{ $item->country }}
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
                                                                <h1 class="modal-title fs-2" id="staticBackdropLabel">Edit Customer</h1>
                                                                <button type="button" id="closeModal" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                            </div>
                                                            <form action="/customers/update/{{ $item->id }}" method="post">
                                                                @csrf
                                                                <div class="modal-body">
                                                                    <div class="mb-3">
                                                                        <label for="id">Nik</label>
                                                                        <input type="number" name="id" id="idEdit" class="form-control" placeholder="Enter nik" value="{{ $item->id }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="name">Name</label>
                                                                        <input type="text" name="name" id="nameEdit" class="form-control" placeholder="Enter name" value="{{ $item->name }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="email">Email</label>
                                                                        <input type="email" name="email" id="emailEdit" class="form-control" placeholder="Enter email" value="{{ $item->email }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="city">City</label>
                                                                        <input type="text" name="city" id="cityEdit" class="form-control" placeholder="Enter city" value="{{ $item->city }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="country">Country</label>
                                                                        <input type="text" name="country" id="countryEdit" class="form-control" placeholder="Enter country"
                                                                            value="{{ $item->country }}">
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
                                                <a class="btn btn-sm btn-danger" href="/customers/delete/{{ $item->id }}" onclick="return confirm('Are you sure ?')">Delete</a>
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
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create New Customer</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="/customers/add" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="id">Nik</label>
                                <input required type="number" name="id" id="id" class="form-control" placeholder="Enter nik" value="{{ old('id') }}">
                            </div>
                            <div class="mb-3">
                                <label for="name">Name</label>
                                <input required type="text" name="name" id="name" class="form-control" placeholder="Enter name" value="{{ old('name') }}">
                            </div>
                            <div class="mb-3">
                                <label for="email">Email</label>
                                <input required type="email" name="email" id="email" class="form-control" placeholder="Enter email" value="{{ old('email') }}">
                            </div>
                            <div class="mb-3">
                                <label for="city">City</label>
                                <input required type="text" name="city" id="city" class="form-control" placeholder="Enter city" value="{{ old('city') }}">
                            </div>
                            <div class="mb-3">
                                <label for="country">Country</label>
                                <input required type="text" name="country" id="country" class="form-control" placeholder="Enter country" value="{{ old('country') }}">
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
