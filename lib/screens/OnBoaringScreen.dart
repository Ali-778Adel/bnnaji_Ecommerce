import 'package:bnnaji/Layout/OnBoarding.dart';
import 'package:bnnaji/Shared/SheredPref.dart';
import 'file:///C:/Users/admin/AndroidStudioProjects/bnnaji/lib/screens/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoaringModel {
  String image;
  String text;
  OnBoaringModel({@required this.image, @required this.text});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnBoardingScreen();
  }
}

class _OnBoardingScreen extends State<OnBoardingScreen> {
  PageController pageController = PageController();
  bool islastScreen = false;

  void onsubmit() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) {
      return false;
    });
  }

  List<OnBoaringModel> screens = [
    OnBoaringModel(
        image: 'assests/images/first.jpeg',
        text: 'Choose your favourite proucts'),
    OnBoaringModel(
        image: 'assests/images/second.jpeg',
        text: 'Oreder it'),
    OnBoaringModel(
        image: 'assests/images/last.jpeg',
        text: 'Be next to the door '),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 800,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  physics: BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return itemBuilder(context, screens[index]);
                  },
                  onPageChanged: (index) {
                    if (index == screens.length - 1) {
                      setState(() {
                        print('LAST');
                        islastScreen = true;
                      });
                    } else {
                      setState(() {
                        print(index);
                        islastScreen = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        SharedPref_Helper.setDataToSharePref(key: 'onBoarding', value: true).then((value) {
                         print(value);
                          print ('yes');
                        }).catchError((error ){
                          print ('error${error.toString()}');
                        });
                        onsubmit();

                      },
                      child: Text(
                        'skip',
                        style: (Theme.of(context).textTheme.headline6).copyWith(
                            color: Colors.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      )),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: screens.length,
                    effect: ExpandingDotsEffect(
                        spacing: 8.0,
                        radius: 4.0,
                        dotWidth: 10.0,
                        dotHeight: 8.0,
                        paintStyle: PaintingStyle.fill,
                        strokeWidth: 1.5,
                        dotColor: Colors.grey,
                        activeDotColor: Colors.indigo),
                    onDotClicked: (index) {
                      setState(() {
                        pageController.animateToPage(index,
                            duration: Duration(milliseconds: 1050),
                            curve: Curves.easeOutBack);
                      });
                    },
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            if (islastScreen) {
                              setState(() {
                                onsubmit();
                              });
                            } else {
                              setState(() {
                                pageController.nextPage(
                                    duration: Duration(milliseconds: 1050),
                                    curve: Curves.easeOutBack);
                              });
                            }
                          },
                          child: Text(
                            'next',
                            style: (Theme.of(context).textTheme.headline6)
                                .copyWith(
                                    color: Colors.blue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300),
                          )),
                      IconButton(
                          onPressed: () {
                            if (islastScreen) {
                              setState(() {
                                onsubmit();
                              });
                            } else {
                              setState(() {
                                pageController.nextPage(
                                    duration: Duration(milliseconds: 1050),
                                    curve: Curves.easeOutBack);
                              });
                            }
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue,
                          ))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget itemBuilder(BuildContext context, OnBoaringModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Image(
        image: AssetImage(model.image),
      ),
      SizedBox(
        height: 30,
      ),
      Text(
        model.text,
        style: (Theme.of(context).textTheme.headline6).copyWith(
            color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w300),
      )
    ],
  );
}
