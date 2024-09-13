import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../res/model.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => DetailPageState();
}

class DetailPageState extends State<DetailPage> {
  List<Color> allColors = [
    Colors.red,
    Colors.red.shade500,
    Colors.red.shade50,
    Colors.red.shade200,
    Colors.red.shade600,
    Colors.red.shade300,
    Colors.red.shade100,
    Colors.teal,
    Colors.teal.shade500,
    Colors.teal.shade900,
    Colors.teal.shade600,
    Colors.teal.shade400,
    Colors.orange,
    Colors.orange.shade400,
    Colors.orange.shade100,
    Colors.orange.shade700,
    Colors.orange.shade800,
    Colors.green,
    Colors.green.shade700,
    Colors.green.shade800,
    Colors.green.shade600,
    Colors.green.shade50,
    Colors.green.shade100,
    Colors.purple,
    Colors.purple.shade700,
    Colors.purple.shade900,
    Colors.purple.shade500,
    Colors.white,
    Colors.black,
    Colors.pink.shade900,
    Colors.pink.shade600,
    Colors.pink.shade700,
    Colors.pink.shade100,
    Colors.pink.shade300,
    Colors.cyan,
    Colors.cyan.shade100,
    Colors.cyan.shade800,
    Colors.cyan.shade400,
    Colors.cyan.shade700,
  ];

  bool isFontColore = false;
  bool showImageSelector = false;
  bool isListVisible = false;
  int? fontColorSelectedIndex;
  int backgroundImageSelectedIndex = 0;
  int? backgroundColorSelectedIndex;
  bool showButtons = false;
  Color selectedFontColor = Colors.black;
  Color initialBackgroundColor = Colors.white;
  int initialStackIndex = 0;
  bool showText = true;
  double containerRadius = 0.0;
  double fontSize = 26.0;
  bool isIncrease = false;
  String displayedText = '';
  bool isFontVisibal =false;

  void increaseRadius() {
    setState(() {
      containerRadius += 10;
    });
  }
  void decreaseRadius() {
    setState(() {
      containerRadius -= 10;
    });
  }

  void toggleText() {
    setState(() {
      showText = !showText;
    });
  }

  void increaseFontSize() {
    setState(() {
      fontSize += 1;
    });
  }


  void decreaseFontSize() {
    setState(() {
      fontSize -= 1;
    });
  }

  List<String> fontFamilies = GoogleFonts.asMap().keys.toList();
  late String? selFont = fontFamilies.isNotEmpty ? fontFamilies.first : null;

  TextEditingController textController = TextEditingController();
  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Model args = ModalRoute.of(context)!.settings.arguments as Model;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("${args.name}",
            style: GoogleFonts.ribeye(
            textStyle: TextStyle(fontSize: 20,letterSpacing: 2,color: Colors.pink.shade600),
      )),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                initialStackIndex = 0;
                initialBackgroundColor = Colors.white;
                selectedFontColor = Colors.black;
                fontColorSelectedIndex = null;
                backgroundColorSelectedIndex = null;
                backgroundImageSelectedIndex = 0;
                showText = true;
                containerRadius = 0.0;
                fontSize = 26.0;
              });
            },
          ),
    IconButton(

    icon: Icon(Icons.share),

    onPressed: () async{

        RenderRepaintBoundary boundary = globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        ui.Image image = await boundary.toImage(pixelRatio: 3.0);
        ByteData? byteData = (await image.toByteData(format: ui.ImageByteFormat.png)) as ByteData?;

        if (byteData != null) {
            Uint8List pngBytes = byteData.buffer.asUint8List();

          // save the screenshot
    final Directory? downloadsDir =await getDownloadsDirectory();

    File origFile =File("${downloadsDir!.path}/quote.png");

    origFile.writeAsBytesSync(byteData.buffer.asUint8List());

// Share the screenshot
await Share.shareXFiles([ XFile(origFile.path), ]);

        }
    }
    ),
        ],

      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: RepaintBoundary(
                key: globalKey,
                child: IndexedStack(
                  index: initialStackIndex,
                  children: [
                    // Background image layer
                    Container(
                      height:300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(containerRadius),
                        image: DecorationImage(
                          image: AssetImage(args.allimages![backgroundImageSelectedIndex]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: LoadData(args),
                    ),
                    // Color layer
                    Container(
                      alignment: Alignment.center,
                      height: 300,
                      decoration: BoxDecoration(
                        color: initialBackgroundColor,
                          borderRadius: BorderRadius.circular(containerRadius),
                      ),
                      child: LoadData(args),
                    ),
                  ],
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Text('Editing',
                  style: GoogleFonts.ribeye(
                    textStyle: TextStyle(fontSize: 30,letterSpacing: 5,color: Colors.pink.shade600),),
              ),
            ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              showImageSelector = !showImageSelector;
        
                              if (showImageSelector) {
                                isFontColore = false;
                                isListVisible = false;
                                showButtons = false;
                                isIncrease = false;
                                isFontVisibal =false;
                              }
                            });
                          },
                          icon: Icon(Icons.panorama,color: Colors.black87,size: 35,),
                        ),
                        SizedBox(width: 10,),
        
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFontColore = !isFontColore;
                              if (isFontColore) {
                                showImageSelector = false;
                                isListVisible = false;
                                showButtons = false;
                                isIncrease = false;
                                isFontVisibal =false;
                              }
                            });
                          },
                          icon: Icon(Icons.palette_outlined,color: Colors.black87,size: 35),
                        ),

                        SizedBox(width: 10,),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              isListVisible = !isListVisible;
                              if (isListVisible) {
                                isFontColore = false;
                                showImageSelector = false;
                                showButtons = false;
                                isIncrease = false;
                                isFontVisibal =false;
                              }
                            });
                          },
                          icon: Icon(Icons.camera_outlined,color: Colors.black87,size: 35,),
                        ),
                        SizedBox(width: 10,),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isFontVisibal=!isFontVisibal;
                              if (isFontVisibal) {
                                isFontColore = false;
                                showImageSelector = false;
                                isListVisible = false;
                                showButtons = false;
                                isIncrease = false;
                              }
                            });
                          },
                          icon: Icon(Icons.abc_sharp,color: Colors.black87,size: 39,),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed: toggleText,
                          child: Text(showText ? 'Hide Text' : 'Show Text',style: TextStyle(
                            fontSize:18,color: Colors.black87
                          ),),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed:  (){
                            setState(() {
                              setState(() {
                                showButtons = !showButtons;
                                if (showButtons) {
                                  isFontColore = false;
                                  showImageSelector = false;
                                  isListVisible = false;
                                  isIncrease = false;
                                  isFontVisibal =false;
                                }
                              });
                            });
                          },
                          child: Text('Radius',style: TextStyle(
                              fontSize:18,color: Colors.black87
                          ),),
                        ),
                        SizedBox(width: 10,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          onPressed:  (){
                            setState(() {
                              setState(() {
                                isIncrease = !isIncrease;
                                if (isIncrease) {
                                  isFontColore = false;
                                  showImageSelector = false;
                                  isListVisible = false;
                                  showButtons = false;
                                  isFontVisibal =false;
                                }
                              });
                            });
                          },
                          child: Text('Font Size',style: TextStyle(
                              fontSize:18,color: Colors.black87
                          ),),
                        ),

                        SizedBox(width: 10,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text("Update Text",style: TextStyle(
                              fontSize:18,color: Colors.black87
                          ),),
                          onPressed: (){
                            setState(() {
                              isIncrease = !isIncrease;
                              if (isIncrease) {
                                isFontColore = false;
                                showImageSelector = false;
                                isListVisible = false;
                                showButtons = false;
                                isIncrease = false;
                                isFontVisibal =false;
                              }
                            });
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shadowColor: Colors.white,
                                title: Center(child: Text("Update Text",style: TextStyle(
                                  fontWeight: FontWeight.w800
                                ),)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: textController,
                                      decoration: InputDecoration(
                                        labelText: "Enter new text",
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Update"),
                                    onPressed: () {
                                      setState(() {
                                        displayedText = textController.text;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
        
                          ),
        
        
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // bcolor
                      const SizedBox(height: 10),
                      if (isListVisible)
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: SizedBox(
                            height: 50,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: allColors.length,
                              separatorBuilder: (context, i) => const SizedBox(width: 10),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      backgroundColorSelectedIndex = i;
                                      initialBackgroundColor = allColors[i];
                                      initialStackIndex = 1;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color: allColors[i],
                                      border: (backgroundColorSelectedIndex == i)
                                          ? Border.all(color: Colors.black, width: 2)
                                          : Border.all(color: Colors.transparent),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
        
                      const SizedBox(height: 10),
                      // bc Images
                      if(showImageSelector)
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: SizedBox(
                            height: 120,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: args.allimages?.length ?? 0,
                              separatorBuilder: (context, i) => const SizedBox(width: 10),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      backgroundImageSelectedIndex = i;
                                      initialStackIndex = 0;
                                    });
                                  },
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(args.allimages![i]),
                                        fit: BoxFit.cover,
                                      ),
                                      border: (backgroundImageSelectedIndex == i)
                                          ? Border.all(color: Colors.black, width: 2)
                                          : Border.all(color: Colors.transparent),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
        
                      const SizedBox(height: 10),
                      // font colors
                      if (isFontColore)
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8),
                          child: SizedBox(
                            height: 40,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: allColors.length,
                              separatorBuilder: (context, i) => const SizedBox(width: 10),
                              itemBuilder: (context, i) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedFontColor = allColors[i];
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: allColors[i],
                                      border: Border.all(
                                        color: (selectedFontColor == allColors[i])
                                            ? Colors.black
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(50)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
        
                      const SizedBox(height: 10),
                      //   for redius butten
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
        
                          if (showButtons) ...[
                            SizedBox(width: 20),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white
                              ),
                              onPressed: increaseRadius,
                              child: Icon(Icons.add),
                            ),
                            const SizedBox(width: 10),
                            Text('${containerRadius}',style: TextStyle(
                                fontSize: 15
                            ),),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white
                              ),
                              onPressed: decreaseRadius,
                              child: Icon(Icons.remove),
                            ),
                          ],
                        ],
                      ),
        
                      const SizedBox(height: 10),
                      // font size
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isIncrease )...[
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white
                            ),
                            onPressed: increaseFontSize,
                              child: Icon(Icons.add),
                          ),
                            const SizedBox(width: 10),
                          Text('${fontSize}',style: TextStyle(
                            fontSize: 15
                          ),),
                          const SizedBox(width: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white
                              ),
                            onPressed: decreaseFontSize,
                            child: Icon(Icons.remove),
                          ),
            ],
                        ],
                      ),
        
                      if(isFontVisibal)
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: fontFamilies.map((e) =>
                          (fontFamilies.indexOf(e) <= 20)
                              ? GestureDetector(
                            onTap: () {
                              setState(() {
                                selFont = e;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10, top: 10),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.pink.shade600,
                                borderRadius:
                                BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: Text("ABC",
                                style: GoogleFonts.getFont(e,
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                              : Container())
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
        
              ],
            ),
          ],
        ),
      ),

    );
  }

  Widget LoadData(Model n) {
    return Container(
      height: 300,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 100),
          if (showText)
            Text(
              displayedText != null ? displayedText! : '',
              style:GoogleFonts.getFont(selFont!,textStyle: TextStyle(color:selectedFontColor,fontSize: fontSize)),
              textAlign: TextAlign.center,
            ),
          SizedBox(height: 40,),
          if (showText)
          Text(
            "${n.tital}",
            style:GoogleFonts.getFont(selFont!,textStyle: TextStyle(color:selectedFontColor,fontSize: fontSize)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

}


