import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:jt_app_basic_structure/data/providers/daily_data_provider.dart';
import 'package:jt_app_basic_structure/data/providers/ui/ui_control_provider.dart';
import 'package:jt_app_basic_structure/data/providers/user_setting_provider.dart';
import 'package:jt_app_basic_structure/widgets/main/app_persistent_layout.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        ChangeNotifierProvider<UserSettingProvider>(
          create: (context) => UserSettingProvider(),
        ),
        ChangeNotifierProvider<DailyDataProvider>(
          create: (context) => DailyDataProvider(),
        ),
        ChangeNotifierProvider<UiControlProvider>(
          create: (context) => UiControlProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Demo',
        home: ScrollConfiguration(
          behavior: CustomScrollBehavior(),
          child: const _AppStateWidget(),
        ),
      ),
    );
  }
}

class _AppStateWidget extends StatefulWidget {
  const _AppStateWidget({super.key});

  @override
  State<_AppStateWidget> createState() => _AppStateWidgetState();
}

class _AppStateWidgetState extends State<_AppStateWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused ||
            AppLifecycleState.detached ||
            AppLifecycleState.inactive:
        // do something to save.
        break;
      case AppLifecycleState.resumed:
        // do something to check back the progress.
        break;

      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppPersistentLayout();
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }
}
