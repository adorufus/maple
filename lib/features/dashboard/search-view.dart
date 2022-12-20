import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/services/database_service.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                height: 49.h,
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: Icon(Icons.cancel),
                      fillColor: Color(0xffF5F5F5),
                      filled: true,
                      contentPadding: EdgeInsets.all(10.0.h),
                      hintText: 'Search anything',
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30.r)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(30.r))),
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Text(
                            'No Data...',
                            style: TextStyle(
                              color: Colors.black
                            ),
                          );
                        } else {
                          var data = snapshot.data?.docs;

                          print("ss" + data.toString());

                          return Column(
                            children: data!.map((e) => Text(e['title'])).toList()
                          );
                        }
                      },
                      stream: FirebaseDatabase.get(reference: 'media')
                          .where('title', isEqualTo: searchController.text)
                          .snapshots(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
