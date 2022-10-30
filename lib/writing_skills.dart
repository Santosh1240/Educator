import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:language_tool/language_tool.dart';

class WritingSkill extends StatefulWidget{

  @override
  State<WritingSkill> createState() => _WritingSkillState();
}

class _WritingSkillState extends State<WritingSkill> {
  TextEditingController mycontroller = TextEditingController();

 List sentence_full = ["null"];
 bool isCardVisible = false;

  Future<List> galti_nikalne_wala(String fullSentence) async{
    var tool = LanguageTool();
    var result = await tool.check(fullSentence);

    return printDetails(result);
  }

  markMistakes(List<WritingMistake> result, String sentence) {
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

    return sentence;
  }

  printDetails(List<WritingMistake> result) {
    for (var mistake in result) {
      print('''
        Issue: ${mistake.message}
        IssueType: ${mistake.issueDescription}
        positioned at: ${mistake.offset}
        with the length of ${mistake.length}.
        Possible corrections: ${mistake.replacements}
    ''');

      return ['''
        Issue: ${mistake.message}
        IssueType: ${mistake.issueDescription}
        positioned at: ${mistake.offset}
        with the length of ${mistake.length}.
        Possible corrections: ${mistake.replacements}
    '''];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 35, 0, 15),
                child: Text("Test your writing skills here...", style: GoogleFonts.signika(color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          style: TextStyle(color: Colors.white),
                          controller: mycontroller,
                          decoration: InputDecoration(
                            hintText: 'Begin typing...' ,
                            hintStyle: GoogleFonts.rajdhani(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 30),
                            border: UnderlineInputBorder()
                            //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      SizedBox(height: 30,),
      ElevatedButton.icon(
          onPressed: () {
            print("length of object is ${mycontroller.text.length}");
            setState(() {
              galti_nikalne_wala(mycontroller.text).then((value){
                sentence_full = value;
              });
              isCardVisible = true;
            });
          },
          icon: Icon(Icons.send),
          label: Text("Evaluate", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25)),),

          style: ElevatedButton.styleFrom(
            fixedSize: Size(170, 50),
            primary: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25)),
          ),
      ),
              SizedBox(height: 30,),
              isCardVisible ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    shadowColor: Colors.white30,
                    color: Colors.grey.shade700,
                    elevation: 20,
                    child: Container(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(sentence_full[0], style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ),
                  ),
                ),
              ): Image.asset("assets/write.png",height: 300,),
            ],
          ),
        ),
      ),
    );
  }
}
