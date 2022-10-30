import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class Question {
  String question;
  bool correctAnswer;

  Question(this.question, this.correctAnswer);
}

class _QuizPageState extends State<QuizPage> {
  final tickIcon = Icon(Icons.check, color: Colors.green);
  final crossIcon = Icon(Icons.clear, color: Colors.red);
  int count = 0;
  List<Icon> iconsList = [];

  final List<Question> questionsList = [
    Question('Carbon-dioxide gas is needed for photosynthesis', true),
    Question('The waste by-product of photosynthesis is oxygen ', true),
    Question('Chlorine is laughing gas', false),
    Question('Law of gravity was developed by Einstein', false),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF333333),
        body: _body(),
      ),
    );
  }

  _body() {
    ///
    /// Column1
    ///
    return Column(
      // Divide the the vertical space between the children
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      // Stretch the children horizontally to the screen size
      // as we need to stretch the buttons
      crossAxisAlignment: CrossAxisAlignment.stretch,

      children: <Widget>[
        Center(

            ///
            /// Text Widget with some padding
            ///
            child: Padding(
          padding: const EdgeInsets.only(top: 110, left: 20, right: 20),
          child: Text(
            questionsList[count].question,
            style: GoogleFonts.rajdhani(
                textStyle: TextStyle(fontSize: 25, color: Colors.white)),
          ),
        )),

        ///
        /// Column2
        ///
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ///
            /// True Button
            ///
            TextButton(
              style: TextButton.styleFrom(
                  foregroundColor: Colors.green, backgroundColor: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('True',
                    style: GoogleFonts.rajdhani(
                        textStyle:
                            TextStyle(color: Colors.black, fontSize: 25,fontWeight:FontWeight.w800))),
              ),
              //color: Colors.green,
              onPressed: () {
                _checkAnswer(true);
              },
            ),

            ///
            /// To give some space between buttons
            ///
            SizedBox(height: 8),

            ///
            /// False Button
            ///
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
                backgroundColor: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'False',
                    style: GoogleFonts.rajdhani(
                        textStyle:
                        TextStyle(color: Colors.black, fontSize: 25,fontWeight:FontWeight.w800)),
                ),
              ),
              //color: Colors.red,
              onPressed: () {
                _checkAnswer(false);
              },
            ),

            ///
            /// Row for Tick-Cross Icons to align them horizontally.
            ///
            Row(children: iconsList)
          ],
        ),
      ],
    );
  }

  _checkAnswer(selectedAnswer) {
    if (selectedAnswer == questionsList[count].correctAnswer) {
      //Correct answer

      setState(() {
        iconsList.add(tickIcon);

        // Check if don't cross list size limit which will result in error
        if (count < questionsList.length - 1) count++;
      });
    } else {
      //Incorrect answer
      setState(() {
        iconsList.add(crossIcon);

        // Check if don't cross list size limit which will result in error
        if (count < questionsList.length - 1) count++;
      });
    }
  }
}
