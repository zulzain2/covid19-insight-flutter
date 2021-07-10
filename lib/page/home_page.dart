import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:covid19_info_flutter/main.dart';
import 'package:covid19_info_flutter/widget/change_theme_button_widget.dart';
import 'package:covid19_info_flutter/widget/covid_card_widget.dart';
import 'package:covid19_info_flutter/widget/covid_card2_widget.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import '../provider/diseases_sh_provider.dart' show DiseasesShProvider;
import '../widget/window_appbar_widget.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/zocial_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

AppBar appBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    leading: IconButton(
      icon: const Icon(FontAwesome.info),
      tooltip: 'Info',
      iconSize: 16,
      color: Theme.of(context).primaryColor,
      onPressed: () {},
    ),
    title: Center(
        child: Text(
      MyApp.title,
      style: TextStyle(
          fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
    )),
    actions: [
      ChangeThemeButtonWidget(),
    ],
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<DiseasesShProvider>(context).fetchAndSet().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final diseaseData = Provider.of<DiseasesShProvider>(context);
    final disease = diseaseData.diseaseSh;

    return Scaffold(
      appBar: kIsWeb
          ? appBar(context)
          : ((Platform.isAndroid || Platform.isIOS)
              ? appBar(context)
              : PreferredSize(
                  preferredSize: Size.fromHeight(0.0),
                  child: Container(),
                )),
      body: SafeArea(
        child: Stack(children: <Widget>[
               kIsWeb ? SizedBox(height: 0) : (Platform.isFuchsia || Platform.isLinux || Platform.isWindows
                    ? WindowAppbarWidget()
                    : SizedBox(height: 0)),
                _isLoading ? Center(
                child: CircularProgressIndicator(color: Colors.blue,),
              ) : Container(
                  padding: kIsWeb
                      ? const EdgeInsets.only(
                          left: 15, right: 15, top: 11, bottom: 20)
                      : ((Platform.isAndroid || Platform.isIOS)
                          ? const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 20)
                          : const EdgeInsets.only(
                              left: 15, right: 15, top: 45, bottom: 20)),
                  child: ListView(children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Current status of the COVID-19 pandemic in ${disease["today"]!.country} (population ${disease["today"]!.population}).',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).disabledColor),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CovidCardWidget("case"),
                            CovidCardWidget("death"),
                            CovidCardWidget("recover"),
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: CovidCardWidget("case")),
                            Expanded(child: CovidCardWidget("death")),
                            Expanded(child: CovidCardWidget("recover")),
                          ],
                        );
                      }
                    }),
                    LayoutBuilder(builder: (context, constraints) {
                      if (constraints.maxWidth < 768) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CovidCard2Widget("vaccine"),
                            CovidCard2Widget("test"),
                          ],
                        );
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child: CovidCard2Widget("vaccine")),
                            Expanded(child: CovidCard2Widget("test")),
                          ],
                        );
                      }
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 50,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Get on other platform"),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: const Icon(Icons.android_outlined),
                                tooltip: 'Android',
                                color: Colors.lightGreen,
                                onPressed: () {},
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: const Icon(Zocial.macstore),
                                tooltip: 'Apple',
                                color: Colors.lightBlueAccent,
                                onPressed: () {},
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: const Icon(Icons.language_outlined),
                                tooltip: 'Web',
                                onPressed: () {},
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: SvgPicture.asset(
                                  'assets/logo/linux.svg',
                                ),
                                tooltip: 'Linux',
                                color: Colors.lightBlueAccent,
                                onPressed: () {}, //do something,
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: const Icon(FontAwesome.windows),
                                tooltip: 'Windows',
                                color: Colors.lightBlueAccent,
                                onPressed: () {},
                              ),
                            ),
                            Center(
                              child: IconButton(
                                iconSize: 32.0,
                                icon: const Icon(FontAwesome.apple),
                                tooltip: 'MacOS',
                                color: Colors.grey.shade400,
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ]),
      ),
    );
  }
}
