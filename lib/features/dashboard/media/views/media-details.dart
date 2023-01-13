import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:maple/widgets/maple-scaffold.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../services/database_service.dart';
import '../../providers/dashboard-providers.dart';

class MediaDetails extends StatefulWidget {
  final String type;
  final String ytUrl;
  final Color typeColor;
  final String title;
  final String description;
  final String mediaId;

  const MediaDetails(
      {Key? key,
      required this.type,
      required this.ytUrl,
      required this.typeColor,
      required this.title,
      required this.description,
      required this.mediaId})
      : super(key: key);

  @override
  State<MediaDetails> createState() => _MediaDetailsState();
}

class _MediaDetailsState extends State<MediaDetails> {
  YoutubePlayerController? playerController;
  String currentLoggedIn = '';

  @override
  void initState() {
    playerController = YoutubePlayerController(
        initialVideoId: widget.ytUrl,
        flags:
            YoutubePlayerFlags(autoPlay: true,  controlsVisibleAtStart: false));

    LocalStorageService.load('user').then((value) {
      currentLoggedIn = value['data']['username'];

      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    playerController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MapleScaffold(
        isUsingAppbar: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/close-button.png',
            height: 36.h,
            width: 36.w,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {

              await Clipboard.setData(ClipboardData(text: 'https://youtube.com/${widget.ytUrl}'));
              Flushbar(
                flushbarPosition: FlushbarPosition.TOP,
                duration: Duration(
                  seconds: 3
                ),
                message: "Link Copied!",
              ).show(context);
            },
            icon: Icon(Icons.link)
          ),
          IconButton(
            onPressed: () async {
              await FlutterShare.share(
                  title: widget.title,
                  text: 'Check Out This Video',
                  linkUrl: 'https://youtube.com/${widget.ytUrl}');
            },
            icon: Image.asset(
              'assets/images/share-button.png',
              height: 36.h,
              width: 36.w,
            ),
          )
        ],
        appBarBackgroundColor: Colors.black,
        centerTitle: true,
        backgroundColor: Colors.black,
        title: widget.type,
        body: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: ListView(
            children: [
              YoutubePlayer(
                controller: playerController!,
                showVideoProgressIndicator: true,
                progressColors: ProgressBarColors(
                    playedColor: MapleColor.indigo,
                    handleColor: MapleColor.indigo),
                bottomActions: [
                  const SizedBox(width: 14.0),
                  CurrentPosition(),
                  const SizedBox(width: 8.0),
                  ProgressBar(
                    isExpanded: true,
                    colors: ProgressBarColors(
                        playedColor: MapleColor.indigo,
                        handleColor: MapleColor.indigo),
                  ),
                  RemainingDuration(),
                  FullScreenButton(),
                ],
              ),
              Container(
                color: widget.typeColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sequel',
                          fontSize: 20.sp),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      widget.description,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Sequel',
                          fontWeight: FontWeight.w100,
                          fontSize: 14.sp),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: FutureBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          future: FirebaseDatabase.documentSnapshot(
                              collection: 'media', itemId: widget.mediaId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Icon(
                                Icons.favorite_outlined,
                                color: MapleColor.black,
                                size: 32.w,
                              );
                            } else {
                              if (snapshot.hasData) {
                                Map<String, dynamic>? data =
                                    snapshot.data?.data();

                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (!data
                                            .containsKey('people_who_likes')) {
                                          FirebaseDatabase.put(
                                              reference: 'media',
                                              doc: widget.mediaId,
                                              data: {
                                                'people_who_likes': [
                                                  currentLoggedIn
                                                ]
                                              });

                                          setState(() {});
                                        } else if (!data['people_who_likes']
                                            .contains(currentLoggedIn)) {
                                          FirebaseDatabase.put(
                                              reference: 'media',
                                              doc: widget.mediaId,
                                              data: {
                                                'people_who_likes': [
                                                  currentLoggedIn
                                                ]
                                              });

                                          setState(() {});
                                        } else {
                                          FirebaseDatabase.put(
                                              reference: 'media',
                                              doc: widget.mediaId,
                                              data: {
                                                'people_who_likes':
                                                    FieldValue.arrayRemove(
                                                        [currentLoggedIn])
                                              });

                                          setState(() {});
                                        }
                                      },
                                      child: Icon(
                                        Icons.favorite_outlined,
                                        color: !data!
                                                .containsKey('people_who_likes')
                                            ? Colors.black
                                            : !(data['people_who_likes']
                                                        as List)
                                                    .contains(currentLoggedIn)
                                                ? Colors.black
                                                : MapleColor.indigo,
                                        size: 32.w,
                                      ),
                                    ),
                                    // !data.containsKey('people_who_likes')
                                    //     ? Container()
                                    //     : !(data['people_who_likes']
                                    //                 as List<dynamic>)
                                    //             .contains(currentLoggedIn)
                                    //         ? Container()
                                    //         : Text(data['people_who_likes']
                                    //                 .length
                                    //                 .toString() ??
                                    //             '')
                                  ],
                                );
                              } else {
                                return Icon(
                                    Icons.favorite_outlined,
                                    color: MapleColor.black,
                                    size: 32.w,
                                );
                              }
                            }
                          }),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w),
                child: Text(
                  'Related video',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontFamily: 'Sequel'),
                ),
              ),
              SizedBox(
                height: 23.h,
              ),
              FutureBuilder<QuerySnapshot>(
                  future: FirebaseDatabase.get(reference: 'media')
                      .where(
                        'type',
                        isEqualTo: widget.type,
                      )
                      .where('title', isNotEqualTo: widget.title)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      String type = widget.type;
                      List splittedType = [
                        type.substring(0, 3),
                        type.substring(3, type.length)
                      ];

                      if (snapshot.hasData) {
                        var data = snapshot.data;
                        print(data!.docs);
                        print('test');
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < data.docs.length; i++)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MediaDetails(
                                                title: data.docs[i]['title'],
                                                type: data.docs[i]['type'],
                                                description: data.docs[i]
                                                    ['description'],
                                                typeColor: Color(int.parse(
                                                    '0xff' +
                                                        data.docs[i]['color'])),
                                                ytUrl: data.docs[i]['vidID'],
                                                mediaId: data.docs[i].id,
                                              )));
                                },
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
                                            data.docs[i]['thumbnails']
                                                ['standard']['url'],
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
                                      color: widget.typeColor,
                                      padding: EdgeInsets.all(20.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.docs[i]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Sequel',
                                                fontSize: 14.sp,
                                                color: context
                                                            .watch<
                                                                DashboardProviders>()
                                                            .selectedType ==
                                                        'Unscene'
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                          Expanded(child: SizedBox()),
                                          RichText(
                                            text: TextSpan(
                                              style: TextStyle(
                                                  color: context
                                                              .watch<
                                                                  DashboardProviders>()
                                                              .selectedType ==
                                                          'Unscene'
                                                      ? Colors.white
                                                      : Colors.black),
                                              children: [
                                                TextSpan(
                                                    text: splittedType[0],
                                                    style: TextStyle(
                                                        fontFamily: 'Sequel')),
                                                TextSpan(
                                                    text: splittedType[1],
                                                    style: TextStyle(
                                                        fontFamily: 'Bebas',
                                                        fontWeight:
                                                            FontWeight.bold))
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                          ],
                        );
                      } else {
                        return Text('No Data Yet :(');
                      }
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Something went wrong on our side :(');
                    } else {
                      print(snapshot.error);
                      return Container();
                    }
                  })
            ],
          ),
        ));
  }
}
