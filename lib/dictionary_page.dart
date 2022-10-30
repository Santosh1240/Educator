import 'package:ali_ka_sathi/Model/model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import './Services/service.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({Key? key}) : super(key: key);

  @override
  _DictionaryPageState createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  TextEditingController controller = TextEditingController();

  AudioPlayer? audioPlayer;

  @override
  void initState() {
    super.initState();
    setState(() {
      audioPlayer = AudioPlayer();
    });
  }

  void playAudio(String music) {
    audioPlayer!.stop();
    audioPlayer!.play(music);
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 35, 0, 15),
                      child: Text("Don't know what something means?", style: GoogleFonts.signika(color: Colors.white, fontSize: 45, fontWeight: FontWeight.bold),),
                    ),
                    Container(
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
                              controller: controller,
                              decoration: InputDecoration(
                                  hintText: 'Search here...' ,
                                  hintStyle: GoogleFonts.rajdhani(color: Colors.white38, fontWeight: FontWeight.bold, fontSize: 30),
                                  border: UnderlineInputBorder()
                                //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              ),
                              cursorColor: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                setState(() {});
                              }
                            },
                            icon: const Icon(Icons.search, color: Colors.white,),
                          )
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ///FutureBuilder
                    controller.text.isEmpty
                        ? Image.asset("assets/last.jpeg", width: 300, fit: BoxFit.cover,)
                        : FutureBuilder(
                      future: DictionaryService()
                          .getMeaning(word: controller.text),
                      builder: (context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        print("Data $snapshot");
                        if (snapshot.hasData) {
                          return Expanded(
                            child: ListView(
                              children: List.generate(snapshot.data!.length,
                                      (index) {
                                    final data = snapshot.data![index];
                                    return Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: ListTile(
                                              title: Text(data.word!, style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25, color: Colors.white)),),
                                              subtitle: Text(
                                                  data.phonetics![index].text!, style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25, color: Colors.white)),),
                                              trailing: IconButton(
                                                  onPressed: () {
                                                    final path = data
                                                        .phonetics![index]
                                                        .audio;

                                                    playAudio("https:$path");
                                                  },
                                                  icon: Icon(
                                                      Icons.audiotrack, color: Colors.white,)),
                                            ),
                                          ),
                                          Text("Definition : ", style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold)),),
                                          Container(
                                            child: ListTile(
                                              title: Text(data
                                                  .meanings![index]
                                                  .definitions![index]
                                                  .definition!, style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25, color: Colors.white)),),
                                              subtitle: Text(data
                                                  .meanings![index]
                                                  .partOfSpeech!, style: GoogleFonts.rajdhani(textStyle: TextStyle(fontSize: 25, color: Colors.white)),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                    )
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
