import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jt_app_basic_structure/data/providers/daily_data_provider.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_profile_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_stats_provider.dart';
import 'package:jt_app_basic_structure/widgets/main/app_persistent_layout.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:util_and_style_cores/structure/app_state_widget.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  initializeApp();
}

Future<void> initializeApp() async {
  final prefs = await SharedPreferences.getInstance();
  // await dotenv.load();
  runApp(MyApp(sharedPreferences: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserProfileProvider>(
          create: (context) => UserProfileProvider(),
        ),
        ChangeNotifierProvider<UserStatsProvider>(
          create: (context) => UserStatsProvider(),
        ),
        ChangeNotifierProvider<DailyDataProvider>(
          create: (context) => DailyDataProvider(),
        ),
        ChangeNotifierProvider<UiControlProvider>(
          create: (context) => UiControlProvider(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hero\'s Clock',
        home: AppStateWidget(
          // onAppLifecycleStateChange: (state) {
          //   switch (state) {
          //     case AppLifecycleState.paused ||
          //           AppLifecycleState.detached ||
          //           AppLifecycleState.inactive:
          //       // do something to save.
          //       break;
          //     case AppLifecycleState.resumed:
          //       // do something to check back the progress.
          //       break;

          //     default:
          //   }
          // },
          child: AppPersistentLayout(),
        ),
      ),
    );
  }
}
