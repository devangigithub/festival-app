import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../res/all_data.dart';
import '../res/model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Model> festivals = allFestivals.map((data) => Model.fromMap(data)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Festival App",
          style: GoogleFonts.ribeye(
        textStyle: TextStyle(
          fontSize: 25,
        letterSpacing: 5,
          color: Colors.pink.shade600),
        ),
      ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: festivals.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, i) {
            final festival = festivals[i];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'detail',
                    arguments: festival,
                  );
                },
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset(
                          festival.thumbnail!,
                          height: double.infinity,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    // Container(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Text(
                    //     festival.name! ,
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(
                    //       color: Colors.black87,
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 18,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
