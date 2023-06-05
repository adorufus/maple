import 'dart:ui';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:maple/features/authentication/views/auth-screen.dart';
import 'package:maple/features/dashboard/activty/view/quiz-activity.dart';
import 'package:maple/features/dashboard/dashboard-screen.dart';
import 'package:maple/features/dashboard/providers/dashboard-providers.dart';
import 'package:maple/features/introduction/views/introduction-screen.dart';
import 'package:maple/firebase_options.dart';
import 'package:maple/services/analytics_service.dart';
import 'package:maple/services/local_storage_service.dart';
import 'package:maple/utils/colors.dart';
import 'package:provider/provider.dart';

const shouldError = false;
const localTestCrashlytics = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DashboardProviders>(create: (_) => DashboardProviders(),)
  ], child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

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
            textTheme: Typography.englishLike2021.apply(fontSizeFactor: 1.sp, bodyColor: Colors.black, decorationColor: Colors.black)
          ),
          navigatorObservers: [observer],
          home: child,
        );
      },
      child: const QuizActivity(
        wrongRightList: ["test", "test", "Test"],
        results: [],
      )
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late Future<void> _initializeFlutterFireFuture;

  Future<void> _testAsyncErrorOnInit() async {
    Future<void>.delayed(const Duration(seconds: 2), () {
      final List<int> list = <int>[];
      print(list[100]);
    });
  }

  // Define an async function to initialize FlutterFire
  Future<void> _initializeFlutterFire() async {
    if (localTestCrashlytics) {
      // Force enable crashlytics collection enabled if we're testing it.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    } else {
      // Else only enable it in non-debug builds.
      // You could additionally extend this to allow users to opt-in.
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
    }

    if (shouldError) {
      await _testAsyncErrorOnInit();
    }
  }

  @override
  void initState() {
    super.initState();

    _initializeFlutterFireFuture = _initializeFlutterFire();

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
