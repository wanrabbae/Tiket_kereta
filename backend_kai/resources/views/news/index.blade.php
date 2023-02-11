@extends('templating.template')

@section('content')
    <style>
        .upload-area {
            width: 100%;
            height: 200px;
            border: 2px solid lightgray;
            border-radius: 3px;
            margin: 0 auto;
            text-align: center;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: auto;
        }

        .upload-area:hover {
            cursor: pointer;
        }

        .upload-area h1 {
            text-align: center;
            font-weight: normal;
            font-family: sans-serif;
            line-height: 50px;
            color: darkslategray;
        }

        .upload-area img {
            width: 100%;
        }

        #image {
            display: none;
        }

        /* Thumbnail */
        .thumbnail {
            width: 80px;
            height: 80px;
            padding: 2px;
            border: 2px solid lightgray;
            border-radius: 3px;
            float: left;
        }

        .size {
            font-size: 12px;
        }
    </style>
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
                                        <th>Image</th>
                                        <th>Title</th>
                                        <th>Description</th>
                                        <th>Publish</th>
                                        <th>Published At</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody id="body-customer">
                                    <?php $i = 1; ?>
                                    @foreach ($news as $item)
                                        <tr>
                                            <td id="itemid">
                                                {{ $i++ }}
                                            </td>
                                            <td id="item->name">
                                                <img src="{{ url('uploadedimages/' . $item->image) }}" alt="image" width="100">
                                            </td>
                                            <td id="item->email">
                                                {{ $item->title }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->description }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->publish }}
                                            </td>
                                            <td id="item->email">
                                                {{ $item->published_at }}
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
                                                                        <label for="eco_seat_num">Economy Seat Num</label>
                                                                        <input required type="number" value="{{ $item->eco_seat_num }}" name="eco_seat_num" id="eco_seat_num" class="form-control"
                                                                            placeholder="Enter eco_seat_num" value="{{ old('eco_seat_num') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="exec_seat_num">Executive Seat Num</label>
                                                                        <input required type="number" value="{{ $item->exec_seat_num }}" name="exec_seat_num" id="exec_seat_num" class="form-control"
                                                                            placeholder="Enter exec_seat_num" value="{{ old('exec_seat_num') }}">
                                                                    </div>
                                                                    <div class="mb-3">
                                                                        <label for="busines_seat_num">Business Seat Num</label>
                                                                        <input required type="number" value="{{ $item->busines_seat_num }}" name="busines_seat_num" id="busines_seat_num"
                                                                            class="form-control" placeholder="Enter busines_seat_num" value="{{ old('busines_seat_num') }}">
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
                        <h1 class="modal-title fs-2" id="staticBackdropLabel">Create News</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="createNews" method="post">
                        @csrf
                        <div class="modal-body">
                            <div class="mb-3">
                                <input required type="file" name="image" id="image" class="form-control">

                                <!-- Drag and Drop container-->
                                <div class="upload-area" id="uploadfile">
                                    <h4>Drag and Drop image here<br />Or<br />Click to select image</h4>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="title">Title</label>
                                <input required type="text" name="title" id="title" class="form-control" placeholder="Enter station name" value="{{ old('title') }}">
                            </div>
                            <div class="mb-3">
                                <label for="description">Description</label>
                                <textarea required name="description" id="description" class="form-control" cols="30" rows="10"></textarea>
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
            let title;
            let desc;
            let image2;
            // preventing page from redirecting
            $("html").on("dragover", function(e) {
                e.preventDefault();
                e.stopPropagation();
                $("h4").text("Drag here");
            });

            $("html").on("drop", function(e) {
                e.preventDefault();
                e.stopPropagation();
            });

            // Drag enter
            $('.upload-area').on('dragenter', function(e) {
                e.stopPropagation();
                e.preventDefault();
                $("h4").text("Drop");
            });

            // Drag over
            $('.upload-area').on('dragover', function(e) {
                e.stopPropagation();
                e.preventDefault();
                $("h4").text("Drop");
            });

            // Drop
            $('.upload-area').on('drop', function(e) {
                e.stopPropagation();
                e.preventDefault();

                $("h4").text("Upload");

                var file = e.originalEvent.dataTransfer.files;
                var fd = new FormData();

                var image = file[0];
                if (image) {
                    let reader = new FileReader();
                    reader.onload = function(event) {
                        $('#uploadfile').html(`<img src='${event.target.result}' >`)
                    }
                    reader.readAsDataURL(image);
                }
                image2 = image;
            });

            // Open file selector on div click
            $("#uploadfile").click(function() {
                $("#image").click();
            });

            // file selected
            $("#image").change(function() {
                var fd = new FormData();
                var files = $('#image')[0].files[0];

                var image = this.files[0];
                if (image) {
                    let reader = new FileReader();
                    reader.onload = function(event) {
                        $('#uploadfile').html(`<img src='${event.target.result}' >`)
                    }
                    reader.readAsDataURL(image);
                }
                image2 = image;
                // uploadData(fd);
            });

            $('#createNews').submit(function(e) {
                e.preventDefault()
                title = $('#title').val()
                desc = $('#description').val()
                const formData = new FormData();
                formData.append('title', title)
                formData.append('description', description)
                formData.append('image', image2)
                formData.append('_token', '{{ csrf_token() }}')

                $.ajax({
                    url: '/news/add',
                    type: 'post',
                    data: formData,
                    contentType: false,
                    processData: false,
                    dataType: 'json',
                    success: function(response) {
                        window.location.reload()
                    },
                    error: function(request, status, error) {
                        $('#createNews').append(`<p class='text-sm text-danger'>${request.responseText}</p>`)
                    }
                });

            })
            $('#customer-table').DataTable();
        </script>
    </div>
@endsection
