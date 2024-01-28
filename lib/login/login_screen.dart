import 'package:wed_app/login/components/center_next_button.dart';
import 'package:wed_app/login/components/splash_view.dart';
import 'package:wed_app/login/components/top_back_skip_view.dart';
import 'package:wed_app/login/components/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:wed_app/login/pages/login_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  bool multiple = true;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    return true;
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(_animationController?.value);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wedding/wedplan2.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ClipRect(
          child: Stack(
            children: [
              SplashView(
                animationController: _animationController!,
              ),
              WelcomeView(
                animationController: _animationController!,
              ),
              TopBackSkipView(
                onBackClick: _onBackClick,
                onSkipClick: _onSkipClick,
                animationController: _animationController!,
              ),
              CenterNextButton(
                animationController: _animationController!,
                onNextClick: _onNextClick,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _animationController?.animateTo(0.0);
    }
  }

  void _onNextClick() {
    if (_animationController!.value >= 0 &&
        _animationController!.value <= 0.2) {
      // _animationController?.animateTo(0.8);
      _signUpClick();
    } else if (_animationController!.value > 0.6 &&
        _animationController!.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }
}
