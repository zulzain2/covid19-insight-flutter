import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:covid19_info_flutter/main.dart';
import 'package:covid19_info_flutter/widget/change_theme_button_widget.dart';

class WindowButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final buttonColors = WindowButtonColors(
      iconNormal: Theme.of(context).primaryColor,
      mouseOver: Colors.black45,
      mouseDown: Colors.black45,
      iconMouseOver: Theme.of(context).primaryColor,
      iconMouseDown: Theme.of(context).primaryColor,
    );

    final closeButtonColors = WindowButtonColors(
        mouseOver: Color(0xFFD32F2F),
        mouseDown: Color(0xFFB71C1C),
        iconNormal: Theme.of(context).primaryColor,
        iconMouseOver: Colors.white);

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        MaximizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: closeButtonColors),
      ],
    );
  }
}

class WindowAppbarWidget extends StatelessWidget {
  const WindowAppbarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: WindowTitleBarBox(
          child: Row(children: [
        Expanded(
            child: MoveWindow(
                child: Row(children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 200.0),
              child: Center(
                child: Text(
                  MyApp.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ]))),
        ChangeThemeButtonWidget(),
        WindowButtons()
      ])),
    );
  }
}
