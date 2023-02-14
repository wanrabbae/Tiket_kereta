<?php

namespace App\Http\Controllers;

use App\Models\News;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Storage;

class NewsCtrl extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validate = $request->validate([
            "image" => "required|image",
            "title" => "required|max:100|unique:news",
            "description" => "required",
        ]);

        $imageName = time() . '.' . $request->image->getClientOriginalExtension();
        $request->image->move(public_path('/uploadedimages'), $imageName);

        $validate["image"] = $imageName;

        if (News::create($validate)) {
            return redirect()->back()->with("success", "Success create new news!");
        }

        return redirect()->back()->withErrors(["msg" => "Error cant create the news"]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $data = News::find($id);
        if ($data) {
            if (News::destroy($id)) {
                File::delete(public_path('uploadedimages/' . $data->image));
                return redirect()->back()->with("success", "Success delete new news!");
            } else {
                return redirect()->back()->withErrors(["msg" => "Error cant delete the news"]);
            }
        }
        return redirect()->back()->withErrors(["msg" => "Error cant delete the news"]);
    }

    public function publish($id)
    {
        if (News::where('id', $id)->update(['publish' => 1])) {
            return redirect()->back()->with("success", "Success published news!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant published news"]);
    }
    public function unpublish($id)
    {
        if (News::where('id', $id)->update(['publish' => 0])) {
            return redirect()->back()->with("success", "Success unpublished news!");
        }

        return redirect()->back()->withErrors(["msg", "Error cant unpublished news"]);
    }

    // REST API
    public function getNews(Request $request)
    {
        $data = News::orderBy('id', 'DESC')->get();
        foreach ($data as $key) {
            if ($key["image"] != null || $key["image"]) {
                $key["image"] = $request->getSchemeAndHttpHost() . '/' . 'uploadedimages/' . $key["image"];
            }
        }
        return response()->json($data);
    }
    public function getSingleNews(Request $request, $id)
    {
        $data = News::find($id);

        $data["image"] = $request->getSchemeAndHttpHost() . '/' . 'uploadedimages/' . $data["image"];

        return response()->json($data);
    }
}
