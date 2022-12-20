import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/services/database_service.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

import '../../dashboard/providers/dashboard-providers.dart';

class EditProfile extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfile({Key? key, required this.userData}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  void didChangeDependencies() {
    fullNameController.text = context.watch<DashboardProviders>().fullName;
    usernameController.text = context.watch<DashboardProviders>().username;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'EDIT PROFILE',
          style: TextStyle(fontFamily: 'Sequel', fontSize: 24.sp),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            'assets/images/back-button.png',
            color: Colors.white,
            width: 32.w,
            height: 32.h,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              isLoading = true;
              setState(() {});

              await FirebaseDatabase.put(
                  reference: 'users',
                  doc: widget.userData['user_id'],
                  data: {
                    'full_name': fullNameController.text,
                    'username': usernameController.text
                  });

              var usDat = await LocalStorageService.load('user');

              usDat['data']['username'] = usernameController.text;
              usDat['data']['full_name'] = fullNameController.text;

              context.read<DashboardProviders>().setUsername(usernameController.text);
              context.read<DashboardProviders>().setFullName(fullNameController.text);

              await LocalStorageService.save('user', usDat);

              isLoading = false;

              setState(() {});

              Flushbar(
                backgroundColor: MapleColor.green,
                message: 'Profile Updated',
                messageColor: Colors.black,
                flushbarPosition: FlushbarPosition.TOP,
                duration: Duration(seconds: 3),
              ).show(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Sequel',
                  fontWeight: FontWeight.w100,
                  fontSize: 14.sp),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  controller: fullNameController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sequel',
                      fontSize: 34.sp),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontFamily: 'Sequel',
                        fontSize: 34.sp),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                TextFormField(
                  controller: usernameController,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Sequel',
                      fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: '@username',
                    hintStyle: TextStyle(
                        color: Colors.white.withOpacity(.5),
                        fontFamily: 'Sequel',
                        fontSize: 14.sp),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Container(
                  color: Colors.white.withOpacity(.6),
                  height: ScreenUtil().screenHeight,
                  width: ScreenUtil().screenWidth,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
