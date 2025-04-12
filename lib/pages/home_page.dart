import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:circle_progress_bar/circle_progress_bar.dart';
import 'package:file_manager/data/recent_files_json.dart';
import 'package:file_manager/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(context), // ✅ Pass context here
    );
  }
}

// ✅ Accept BuildContext here
Widget getBody(BuildContext context) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          getStorageBox(),
          SizedBox(height: 30),
          getRecentFiles(context), // ✅ Pass context here
        ],
      ),
    ),
  );
}

Widget getStorageBox() {
  return Container(
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      color: primary,
      borderRadius: BorderRadius.circular(22),
    ),
    child: Stack(
      children: [
        Positioned(
          bottom: -40,
          right: -30,
          child: Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          ),
        ),
        Positioned(
          bottom: -10,
          left: -50,
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
          ),
        ),
        Container(
          width: double.infinity,
          height: 120,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircleProgressBar(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    value: 0.68,
                    child: Center(
                      child: AnimatedCount(
                        style: TextStyle(color: Colors.white),
                        count: 0.68,
                        unit: "%",
                        duration: Duration(microseconds: 500),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "10.8 Gb of 15 Gb used",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(
                            "Buy Storage",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget getRecentFiles(BuildContext context) {
  var size = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Files",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 18),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              children: List.generate(recentFilesJson.length, (index) {
            var fileType = "assets/icons/image.svg";
            if (recentFilesJson[index]['type'] == 'image') {
              fileType = "assets/icons/image.svg";
            } else if (recentFilesJson[index]['type'] == 'video') {
              fileType = "assets/icons/video.svg";
            }
            return Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Container(
                width: size.width * 0.6,
                height: 160,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(22),
                    image: DecorationImage(
                        image: NetworkImage(recentFilesJson[index]['img']),
                        fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BlurryContainer(
                        blur: 5,
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22)),
                        child: Container(
                          width: size.width * 0.6,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      fileType,
                                      color: Colors.white,
                                      width: 15,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      recentFilesJson[index]['file_name'],
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.8)),
                                    )

                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            );
          })),
        ),
      ],
    ),
  );
}
