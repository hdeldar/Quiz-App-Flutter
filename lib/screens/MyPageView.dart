import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/constants.dart';
import 'package:quiz_app/controllers/question_controller.dart';
import 'package:quiz_app/screens/quiz/components/progress_bar.dart';
import 'package:quiz_app/screens/quiz/components/question_card.dart';
//import 'package:flutter/widgets.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({
    Key key,
  }) : super(key: key);
  // const MyPageView({super.key});

  @override
  State<MyPageView> createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    QuestionController _questionController = Get.put(QuestionController());
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Container(
              color: Colors.red,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: ProgressBar(),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                      child: Obx(
                            () => Text.rich(
                          TextSpan(
                            text:
                            "Question ${_questionController.questionNumber.value}",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(color: kSecondaryColor),
                            children: [
                              TextSpan(
                                text: "/${_questionController.questions.length}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: kSecondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Divider(thickness: 1.5),
                    //SizedBox(height: kDefaultPadding),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              0,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        child: const Text('Previous'),
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        // Block swipe to next qn
                        physics: NeverScrollableScrollPhysics(),
                        controller: _questionController.pageController,
                        onPageChanged: _questionController.updateTheQnNum,
                        itemCount: _questionController.questions.length,
                        itemBuilder: (context, index) => SingleChildScrollView(child:QuestionCard(
                            question: _questionController.questions[index]),)
                      ),

                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}