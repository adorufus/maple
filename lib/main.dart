import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/authentication/views/auth-screen.dart';
import 'package:maple/features/dashboard/dashboard-screen.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/features/introduction/views/introduction-screen.dart';
import 'package:maple/firebase_options.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DashboardProviders>(create: (_) => DashboardProviders(),)
  ], child: const MyApp(),));
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

    Future.delayed(const Duration(seconds: 3), () async {
      await isFirstTime() ? Navigator.push(context, MaterialPageRoute(builder: (context) => const IntroductionScreen())) : Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
    });
  }

  Future<bool> isFirstTime() async {
    if(await LocalStorageService.check('user')) {
      print(await LocalStorageService.load('user'));
      Map<String, dynamic> data = await LocalStorageService.load('user');

      return data['data']["is_first"] as bool;
    } else {
      await LocalStorageService.save('user', {
        'status': 'success',
        'data': {
          'is_first': true,
          'username': 'guest'
        }
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MapleColor.indigo,
      body: Center(
        child: Image.asset('assets/images/logo-maple.png', width: 251.w, height: 65.26.h,)
      ),
    );
  }
}
