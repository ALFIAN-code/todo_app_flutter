import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/assets/style/style.dart';
import 'package:todo_app/component/restart_widget.dart';
// import 'package:todo_app/pages/homepage.dart';

class LightDarkToggle extends StatefulWidget {
  const LightDarkToggle({
    super.key,
  });
  // final void Function()? changeTheme;

  @override
  State<LightDarkToggle> createState() => _LightDarkToggleState();
}

class _LightDarkToggleState extends State<LightDarkToggle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // 0 = dark
  // 1 = dark to light
  // 2 = light
  // 3 = light to dark
  // var themeData = Hive.box('themeData');
  int state = Hive.box('themeData').get('state');

  // void getState() async {
  //   int getState = await themeData.get('state');
  //   state = getState;
  //   print(state);
  // }

  void changeState(int state) async {
    await Hive.box('themeData').put('state', state);
    if (mounted) {
      setState(() {
        this.state = state;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hive.box('themeData').put('state', 0);

    return SizedBox(
      height: 39,
      width: 60,
      child: GestureDetector(
        onTap: () {
          if (state == 0) {
            changeState(1);
          }
          if (state == 2) {
            changeState(3);
          }
          setState(() {
            // RestartWidget.restartApp(context);
          });
        },
        child: FlareActor('lib/assets/animation/light_dark_toggle.flr',
            animation: (state == 0)
                ? 'night_idle'
                : (state == 1)
                    ? 'switch_day'
                    : (state == 2)
                        ? 'day_idle'
                        : 'switch_night', callback: (animationName) {
          if (animationName == 'switch_day') {
            changeState(2);
            // print('ini adalah state' + state.toString());
          }
          if (animationName == 'switch_night') {
            changeState(0);
            // print('ini adalah state' + state.toString());
          }
          AppColor.switchTheme();
          RestartWidget.restartApp(context);
        }),
      ),
    );
  }
}
