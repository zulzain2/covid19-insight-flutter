import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:covid19_info_flutter/page/home_page.dart';
import 'package:covid19_info_flutter/provider/theme_provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:desktop_window/desktop_window.dart';
import './provider/diseases_sh_provider.dart';
import 'dart:io' show Platform;

Future main() async {
  Size size;

  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Future<Size> getWindowSize() async {
    Size size = await DesktopWindow.getWindowSize();
    await DesktopWindow.setFullScreen(true);
    return size;
  }

  runApp(MyApp());

if(Platform.isFuchsia || Platform.isLinux || Platform.isWindows){
 doWhenWindowReady(() {
    getWindowSize();
    final win = appWindow;
    // final initialSize = Size(1280, 730);
    win.minSize = Size(1280, 730);
    // win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Custom window with Flutter";
    win.show();
  });
}
 
}

class MyApp extends StatelessWidget {
  static const String title = 'COVID-19 INSIGHT';

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
           ChangeNotifierProvider(
            create: (context) => DiseasesShProvider(),
          ),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: title,
              themeMode: themeProvider.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              home: HomePage(),
            );
          },
        ),
      );
}
