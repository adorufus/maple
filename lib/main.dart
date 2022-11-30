import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/authentication/views/auth-screen.dart';
import 'package:maple/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Maple',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2021.apply(fontSizeFactor: 1.sp)
          ),
          home: child,
        );
      },
      child: const MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () => {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AuthScreen()))
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapleColor.indigo,
      body: Center(
        child: Image.asset('assets/images/logo-maple.png')
      ),
    );
  }
}