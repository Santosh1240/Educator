import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:language_tool/language_tool.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  String inputText = "There are only humans in the world";

  late var words = inputText.split(' ');

  final Map<String, HighlightedWord> _highlights = {};

  void adder() {
    for (String word in words) {
      _highlights.putIfAbsent(
        word,
        () => HighlightedWord(
          textStyle: GoogleFonts.rajdhani(
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }
  }

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press button to speak';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    adder();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade900,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: AvatarGlow(
            animate: _isListening,
            glowColor: Theme.of(context).primaryColor,
            endRadius: 75.0,
            duration: const Duration(milliseconds: 2000),
            repeatPauseDuration: const Duration(milliseconds: 1),
            repeat: true,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffF5F5F5), width: 0.5),
                  borderRadius: BorderRadius.circular(30)),
              child: FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: _listen,
                child: Icon(
                  _isListening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black, width: 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                        'Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%',
                        style: GoogleFonts.rajdhani(
                          textStyle: TextStyle(
                            color: Color(0xffF5F5F5),
                            //fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          ),
                        )),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                          inputText,
                          style: GoogleFonts.rajdhani(
                            textStyle: TextStyle(
                              color: Color(0xffF5F5F5),
                              //fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          )),
                    ),
                  ),
              ),
              SingleChildScrollView(
                reverse: true,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
                  child: TextHighlight(
                    text: _text,
                    words: _highlights,
                    textStyle: GoogleFonts.rajdhani(
                      textStyle: TextStyle(
                        fontSize: 32.0,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
      if (_speech.isNotListening) {
        print("verify karne ke liye: $_text");
        // galti_nikalne_wala(_text);
      }
    }
  }

  void galti_nikalne_wala(String fullSentence) async {
    var tool = LanguageTool();

    var result = await tool.check(fullSentence);
    markMistakes(result, fullSentence);
    printDetails(result);
  }

  void markMistakes(List<WritingMistake> result, String sentence) {
    var red = '\u001b[31m';
    var reset = '\u001b[0m';

    var addedChars = 0;

    for (var mistake in result) {
      sentence = sentence.replaceRange(
        mistake.offset! + addedChars,
        mistake.offset! + mistake.length! + addedChars,
        red +
            sentence.substring(mistake.offset! + addedChars,
                mistake.offset! + mistake.length! + addedChars) +
            reset,
      );
      addedChars += 9;
    }

    print("ye sentence : " + sentence);
  }

  void printDetails(List<WritingMistake> result) {
    for (var mistake in result) {
      print('''
        Issue: ${mistake.message}
        IssueType: ${mistake.issueDescription}
        positioned at: ${mistake.offset}
        with the lengh of ${mistake.length}.
        Possible corrections: ${mistake.replacements}
    ''');
    }
  }
}
