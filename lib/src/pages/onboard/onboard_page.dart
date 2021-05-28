import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/pages/login/login_page.dart';
import 'package:vootech_realchat/src/pages/onboard/fragments/step_one.dart';
import 'package:vootech_realchat/src/pages/onboard/fragments/step_three.dart';
import 'package:vootech_realchat/src/pages/onboard/fragments/step_two.dart';
import 'package:vootech_realchat/src/widgets/button/primary_button.dart';
import 'package:vootech_realchat/src/widgets/dots_indicator.dart';

class OnboardPage extends StatefulWidget {
  OnboardPage({Key key}) : super(key: key);

  @override
  _OnboardPageState createState() => new _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final _controller = new PageController();
  List<Widget> _pages = [];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      StepOne(),
      StepTwo(),
      StepThree(),
    ];
    bool isDone = currentPageIndex == _pages.length - 1;
    return Scaffold(
      body: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: new PageView.builder(
              physics: new NeverScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
              onPageChanged: (int index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
            ),
          ),
          new Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: new SafeArea(
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                primary: false,
                actions: <Widget>[
                  TextButton(
                      child: Text(isDone ? "Done" : "Skip", style: TextStyle(color: AppColors.primaryColor)),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                      })
                ],
              ),
            ),
          ),
          new Positioned(
            bottom: 40.0,
            left: 0.0,
            right: 0.0,
            child: new SafeArea(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new DotsIndicator(
                      controller: _controller,
                      itemCount: _pages.length,
                      selectedIndex: currentPageIndex,
                      onPageSelected: (int page) {
                        _controller.animateToPage(page, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                      },
                    ),
                  ),
                  SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: PrimaryButton(
                      onPressed: () {
                        if (isDone) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        } else {
                          _controller.animateToPage(currentPageIndex + 1, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                        }
                      },
                      title: isDone ? "Start" : "Next",
                      height: 54,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
