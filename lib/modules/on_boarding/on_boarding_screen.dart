import 'package:flutter/material.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../shared/styles/colors.dart';



class OnBoardingScreen extends StatefulWidget {
  static String routName = 'onboardingScreen';
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}
class OnBordingModel {
  final String image;
  final String title;
  final String body;

  OnBordingModel({
    required this.image,
    required this.title,
    required this.body
  });
}
class _OnBoardingScreenState extends State<OnBoardingScreen> {


  List<OnBordingModel> bording = [
    OnBordingModel(
      image: 'assets/images/onbording.png',
      title: 'Screen Title_1',
      body: 'Screen body_1',
    ),
    OnBordingModel(
      image: 'assets/images/onbording.png',
      title: 'Screen Title_2',
      body: 'Screen body_2',
    ),
    OnBordingModel(
      image: 'assets/images/onbording.png',
      title: 'Screen Title_3',
      body: 'Screen body_3',
    ),
  ];


  bool isLast = false;
  var onbordController = PageController();

  Widget buildBordingItem(OnBordingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image.asset(model.image)),
          SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              onPressed: (){
                CacheHelper.saveData(key: 'onBoarding', value: true);
                navigatAndRemove(context, LoginScreen.routName);
              },
              text: 'skip'
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (index) {
                  if(index == bording.length -1){
                    setState(() {
                      isLast = true;
                      print('Last');
                    });
                  }else{
                    setState(() {
                      isLast = false;
                      print('not last');
                    });
                  }
                },
                controller: onbordController,
                itemBuilder: (context, index) => buildBordingItem(bording[index]),
                itemCount: bording.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onbordController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4.0,
                    spacing: 5,
                  ),
                  count: bording.length,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if(isLast){
                      CacheHelper.saveData(key: 'onBoarding', value: true);
                      navigatAndRemove(context, LoginScreen.routName);
                    }else {
                      onbordController.nextPage(
                          duration: Duration(milliseconds: 750,),
                          curve: Curves.fastLinearToSlowEaseIn
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
