import 'package:agora_video_call/utils/Constants.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'OnboardingData.dart';
import 'package:flutter/cupertino.dart';
import 'package:agora_video_call/DeviceSizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class OnboardingScreen extends StatefulWidget {
  final FlutterSecureStorage _secureStorage;
  OnboardingScreen(this._secureStorage);
  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  List<SliderModel> slides = [];
  int currentIndex = 0;
  int i;
  PageController pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    slides = getSlides();
  }

  // Page Number Indicator Widget
  Widget pageIndexIndicator(bool isCurrentpage) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentpage ? 10.0 : 6.0,
      width: isCurrentpage ? 10.0 : 6.0,
      decoration: BoxDecoration(
          color: isCurrentpage ? Colors.blue : Colors.grey,
          borderRadius: BorderRadius.circular(10.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    DeviceSizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView.builder(
            controller: pageController,
            itemCount: slides.length,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return SliderTile(
                  imageAsset: slides[index].getImagePath(),
                  description: slides[index].getDescription(),
                  explanation: slides[index].getExplanation());
            }),
        bottomSheet: currentIndex != slides.length - 1
            ? Container(
                color: Colors.white,
                alignment: Alignment.topCenter,
                height: DeviceSizeConfig.screenHeight * 0.07,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[ // Next and Skip buttons
                    ElevatedButton(
                      onPressed: () {
                        pageController.animateToPage(slides.length,
                            duration: Duration(milliseconds: 800),
                            curve: Curves.linear);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        'Skip',
                        style:
                            GoogleFonts.lato(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        for (i = 0; i < slides.length; i++)
                          currentIndex == i
                              ? pageIndexIndicator(true)
                              : pageIndexIndicator(false),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pageController.animateToPage(currentIndex + 1,
                            duration: Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue,
                        ),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                color: Colors.white,
                alignment: Alignment.topCenter,
                height: DeviceSizeConfig.screenHeight * 0.15,
                width: DeviceSizeConfig.screenWidth,
                child: ButtonTheme(
                  minWidth: 40,
                  child: ElevatedButton(
                    child: Text('Get started Now!'),
                    onPressed: () async {
                      await widget._secureStorage
                          .write(key: ONBOARDING, value: 'true');
                      Navigator.pushReplacementNamed(context, AUTH_ROUTE);
                    },
                  ),
                ),
              ));
  }
}

// Class to create each page of Onboarding
class SliderTile extends StatelessWidget {
  String imageAsset, description, explanation;
  SliderTile({this.imageAsset, this.description, this.explanation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: FittedBox(
                child: Image.asset(
                  imageAsset,
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                ),
                fit: BoxFit.fill),
          ),
          Text(
            description,
            style: GoogleFonts.lato(
                fontSize: 26, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          Text(explanation,
              style: GoogleFonts.lato(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
