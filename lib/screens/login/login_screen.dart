import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappanimation/screens/home/home_screen.dart';
import 'package:flutterappanimation/screens/login/widgets/form_container.dart';
import 'package:flutterappanimation/screens/login/widgets/sign_up_button.dart';
import 'package:flutterappanimation/screens/login/widgets/stagger_animation.dart';

//com essa biblioteca vc pode modificar a dilatação do tempo no app
//exemplo no button de sign
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //tudo ficará 4 vezes mais devagar
    timeDilation = 2;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/screen-2.jpg"), fit: BoxFit.cover)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            //para a anicação funcionar, usando Stack() a animação vai poder cobrir
            //a tela inteira
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 70, bottom: 32),
                      child: Image.asset(
                        "images/nike.webp",
                        width: 150,
                        height: 150,
                        fit: BoxFit.contain,
                      ),
                    ),
                    FormContainer(),
                    SignUpButton()
                  ],
                ),
                StaggerAnimation(controller: _animationController.view)
              ],
            )
          ],
        ),
      ),
    );
  }
}
