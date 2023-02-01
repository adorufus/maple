import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/services/database_service.dart';

import '../../services/analytics_service.dart';
import '../../utils/colors.dart';
import 'articles/view/article-detail-screen.dart';
import 'media/views/media-details.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = TextEditingController(text: '');
  List<DocumentSnapshot> documents = [];

  String searchQuery = '';

  @override
  void initState() {
    analytics.setCurrentScreen(screenName: "/dashboard/search-view");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new)),
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      height: 49.h,
                      child: TextFormField(
                        controller: searchController,
                        style: TextStyle(color: Colors.black),
                        onChanged: (data) {
                          searchQuery = data;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                searchController.text = '';
                                searchQuery = '';
                                setState(() {

                                });
                              },
                                child: Icon(Icons.cancel)),
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
                  ),
                ],
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Text('Media', style: TextStyle(color: Colors.black, fontFamily: 'Sequel', fontSize: 24.sp),),
                      ),
                      mediaList(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                        child: Text('Articles', style: TextStyle(color: Colors.black, fontFamily: 'Sequel', fontSize: 24.sp),),
                      ),
                      StreamBuilder(
                        stream: FirebaseDatabase.get(reference: 'articles').snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              'No Data....',
                              style: TextStyle(color: Colors.black),
                            );
                          } else {
                            documents = snapshot.data!.docs;

                            if(searchQuery.isNotEmpty) {
                              documents = documents.where((element){
                                return element.get('title').toString().toLowerCase().contains(searchQuery.toLowerCase());
                              }).toList();

                              return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for(int i = 0; i < documents.length; i++)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context, MaterialPageRoute(builder: (context) =>
                                              ArticleDetailScreen(
                                                data: documents[i],
                                              ),),);
                                        },
                                        child: Container(
                                          height: 195.h,
                                          child: Row(
                                            children: [
                                              i.isOdd
                                                  ? Flexible(
                                                child: Container(
                                                  width: 195.w,
                                                  child: Image.network(
                                                      documents[i]['content_image'],
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                                  : Flexible(
                                                child: Container(
                                                  width: 195.w,
                                                  color: Colors.black,
                                                  padding: EdgeInsets.all(20.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        documents[i]['title'],
                                                        style: TextStyle(
                                                            fontFamily: 'Sequel',
                                                            fontSize: 14.sp,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'Read more',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Sequel',
                                                            fontWeight: FontWeight.w100),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              i.isOdd
                                                  ? Flexible(
                                                child: Container(
                                                  width: 195.w,
                                                  color: Colors.black,
                                                  padding: EdgeInsets.all(20.w),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        documents[i]['title'],
                                                        style: TextStyle(
                                                            fontFamily: 'Sequel',
                                                            fontSize: 14.sp,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        'Read more',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Sequel',
                                                            fontWeight: FontWeight.w100),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                                  : Flexible(
                                                child: Container(
                                                  width: 195.w,
                                                  child: Image.network(
                                                      documents[i]['content_image'],
                                                      fit: BoxFit.cover),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                  ]);
                            }
                            else {
                              return Container(
                                child: Center(
                                  child: Text('Maybe try something like "Leadership"?', style: TextStyle(color: Colors.black, fontSize: 12.sp),),
                                ),
                              );
                            }

                            var data = snapshot.data?.docs;

                            print("ss" + data.toString());

                            return Container();
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget mediaList() {
    return StreamBuilder(
      stream: FirebaseDatabase.get(reference: 'media').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text(
            'No Data....',
            style: TextStyle(color: Colors.black),
          );
        } else {
          documents = snapshot.data!.docs;

          if(searchQuery.isNotEmpty) {
            documents = documents.where((element){
              return element.get('title').toString().toLowerCase().contains(searchQuery.toLowerCase());
            }).toList();

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: documents.map((e){

                  Map<String, dynamic> data = e.data() as Map<String, dynamic>;

                  return GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MediaDetails(
                              title: data['title'],
                              type: data['type'],
                              description: data['description'],
                              typeColor: Color(int.parse(
                                  '0xff' + data['color'])),
                              ytUrl: data['vidID'],
                              mediaId: e.id ,
                            ))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 219.47.h,
                          width: 390.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                data['thumbnails']['standard']['url'],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                              child: Image.asset(
                                'assets/images/play.png',
                                height: 32.h,
                                width: 32.w,
                              )),
                        ),
                        Container(
                          height: 106.h,
                          width: ScreenUtil().screenWidth,
                          color: Color(int.parse('0xff${data['color']}')),
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Sequel',
                                    fontSize: 14.sp,
                                    color: data['type'] == 'Unscene'
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              Expanded(child: SizedBox()),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      color: data['type'] == 'Unscene'
                                          ? Colors.white
                                          : Colors.black),
                                  children: [
                                    TextSpan(
                                        text: data['type'].toString().substring(0, 3).toUpperCase(),
                                        style:
                                        TextStyle(fontFamily: 'Sequel')),
                                    TextSpan(
                                        text: data['type'].toString().substring(3, data['type'].toString().length).toUpperCase(),
                                        style: TextStyle(
                                            fontFamily: 'Bebas',
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }).toList()
            );
          }
          else {
            return Container(
              child: Center(
                child: Text('Maybe try something like "Can!"?', style: TextStyle(color: Colors.black, fontSize: 12.sp),),
              ),
            );
          }

          var data = snapshot.data?.docs;

          print("ss" + data.toString());

          return Container();
        }
      },
    );
  }
}
