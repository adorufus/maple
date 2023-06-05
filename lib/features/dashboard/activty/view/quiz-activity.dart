import 'package:flutter/material.dart';

import 'options.dart';

class QuizActivity extends StatefulWidget {
  final List? results;
  final List? wrongRightList;
  const QuizActivity({Key? key, this.results, this.wrongRightList}) : super(key: key);

  @override
  State<QuizActivity> createState() => _QuizActivityState();
}

class _QuizActivityState extends State<QuizActivity> {

  List<String> _userAnswerList = [];
  List<String> correctanswerlist = [];
  int currentPagePosition = 0;
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Center(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: widget.results?.length,
                  pageSnapping: true,
                  onPageChanged: (position) {
                    currentPagePosition = position;
                  },
                  itemBuilder: (context, index) {
                    String userAnswer = _userAnswerList[index];
                    int checkedOptionPosition =
                    widget.wrongRightList?[index].indexOf(userAnswer);

                    return Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Question ${index + 1}',
                              style: TextStyle(
                                  color: Colors.yellow[800]),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Options(
                              index: index,
                              wrongRightList: widget.wrongRightList!,
                              selectedPosition: checkedOptionPosition,
                              // onOptionsSelected: (selectedOption) {
                              //   print("selected item is $selectedOption");
                              //   _userAnswerList[currentPagePosition] =
                              //       selectedOption;
                              //   print(_userAnswerList.toList().toString());
                              // },
                            ),
                            SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            'Previous',
                            style: TextStyle(

                                fontSize: 15,
                                color: Colors.yellow[800]),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            primary: Colors.yellow[800],
                          ),
                          onPressed: () {

                          },
                          child: Text(
                            'Next',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.blueGrey[800]),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          primary: Colors.blueGrey[800],
                          fixedSize:
                          Size(MediaQuery.of(context).size.width * 0.7, 50)),
                      onPressed: () {

                      },
                      child: Text(
                        'SUBMIT',
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
