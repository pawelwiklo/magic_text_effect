import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final Shader linearGradient = LinearGradient(
    colors: <Color>[Color(0xffDA44bb), Color(0xff8921aa)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 40.0, 40.0));

  late AnimationController controller;
  late Animation firstColorAnim;
  late Animation secondColorAnim;
  late Animation thirdColorAnim;
  late Animation fourthColorAnim;
  late Animation positionAnimation;
  late Color firstColor;
  late Color secondColor;
  late Color thirdColor;
  late Color fourthColor;

  late double divider;

  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    firstColorAnim =
        ColorTween(begin: Colors.purple.shade400, end: Colors.purple.shade900)
            .animate(controller);
    secondColorAnim = ColorTween(
            begin: Colors.deepPurple.shade900, end: Colors.deepPurple.shade400)
        .animate(controller);

    positionAnimation = Tween(
      begin: 1.0,
      end: 350.0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    firstColorAnim.addListener(() {
      setState(() {
        firstColor = firstColorAnim.value;
        secondColor = secondColorAnim.value;
        thirdColor = firstColorAnim.value;
        fourthColor = secondColorAnim.value;
      });
      if (controller.isCompleted) {
        controller.reverse();
      }
      if (controller.isDismissed) {
        controller.forward();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: Container(
            child: ShaderMask(
              blendMode: BlendMode.srcIn,
              shaderCallback: (bounds) => LinearGradient(colors: [
                //try other colors!
                firstColor,
                secondColor,
                // thirdColor,
                // fourthColor,
                // secondColor
              ]).createShader(
                Rect.fromLTWH(0, 0, bounds.width, bounds.height),
              ),
              child: Text('Magicccc', style: TextStyle(fontSize: 80)),
            ),
          ),
        ),
      ),
    );
  }
}
