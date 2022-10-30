import 'package:ali_ka_sathi/dictionary_page.dart';
import 'package:ali_ka_sathi/quiz_page.dart';
import 'package:ali_ka_sathi/speech.dart';
import 'package:ali_ka_sathi/video_calling.dart';
import 'package:ali_ka_sathi/writing_skills.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:backdrop/backdrop.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'backlayer.dart';

Future<void> main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(GetMaterialApp(
    home: LoginScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      signIn(data.name, data.password);
      return null;
    });
  }

  signIn(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email,
              password: password)
          .then((userCredential) {
        print(userCredential.user?.displayName);
        // Get.to(MyApp());
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return "Exception";
    }
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      return "This feature hasn't been developed yet";
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Login',
      onLogin: _authUser,
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Intermediate(),
        ));
      },
      onRecoverPassword: _recoverPassword,
      theme: LoginTheme(
        primaryColor: Colors.grey.shade900,
        accentColor: Colors.white,
        errorColor: Colors.deepOrange,
        pageColorDark: Colors.grey.shade400,
      ),
    );
  }
}

class Intermediate extends StatelessWidget {
  const Intermediate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 45, 0, 90),
            child: Text("Ali Ka Saathi", style: GoogleFonts.cinzel(color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network("http://clipart-library.com/image_gallery/188664.gif", height: 130,),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(MyApp());
                        },
                        icon: Icon(Icons.keyboard_arrow_right_sharp),
                        label: Text("English", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25)),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170, 50),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network("http://clipart-library.com/img1/1570515.jpg", width: 150,),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(QuizPage());
                        },
                        icon: Icon(Icons.keyboard_arrow_right_sharp),
                        label: Text("Science", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25)),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170, 50),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 150, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network("http://clipart-library.com/new_gallery/206-2066537_mathematics-calculation-variable-equation-computer-algebra-clip-art.png", width: 150,),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(QuizPage());
                        },
                        icon: Icon(Icons.keyboard_arrow_right_sharp),
                        label: Text("Maths", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25)),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170, 50),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 150, 0, 0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network("https://www.worklife.news/wp-content/uploads/sites/6/2022/05/collaboration-technology-ivy.jpeg", height: 125, width: 100,),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(BestService());
                        },
                        icon: Icon(Icons.keyboard_arrow_right_sharp),
                        label: Text("Interact", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25)),),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(170, 50),
                          primary: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}



class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var pages = [WritingSkill(), DictionaryPage(), SpeechScreen()];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backLayer: BackLayer(),
      //backLayerBackgroundColor: Colors.orange[500],

      body: pages[_index], //pages[_pageIndex].page,
     // frontLayerBackgroundColor: Colors.black,

      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.grey.shade700,
        backgroundColor: Colors.grey.shade900,
        items: <Widget>[
          Icon(Icons.abc, size: 30),
          Icon(Icons.book, size: 30),
          Icon(Icons.read_more, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _index = index;
          });
          //Handle button tap
        },
      ),
    );
  }
}
