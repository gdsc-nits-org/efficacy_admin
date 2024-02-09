import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';


class Developer {
  final String name;
  final String image;
  final String github;
  final String linkedin;

  Developer(
      {required this.name,
      required this.image,
      required this.github,
      required this.linkedin});
}

class DeveloperGridView extends StatefulWidget {
  const DeveloperGridView({super.key});

  @override
  DeveloperGridViewState createState() => DeveloperGridViewState();
}

class DeveloperGridViewState extends State<DeveloperGridView> {
  late List<Developer> developers;
  late List<bool> iconVisibility;

  @override
  void initState() {
    super.initState();
    loadDevelopers();
  }

  Future<void> loadDevelopers() async {
    String jsonString = await rootBundle.loadString('assets/developers.json');
    List<dynamic> jsonList = jsonDecode(jsonString);
    setState(() {
      developers = jsonList
          .map((e) => Developer(
                name: e['name'],
                image: e['image'],
                github: e['github'],
                linkedin: e['linkedin'],
              ))
          .toList();
      iconVisibility = List<bool>.filled(developers.length, false);
    });
  }

  @override
  Widget build(BuildContext context) {
    double cardImageSize = MediaQuery.of(context).size.width * 0.4;
    double iconSize = MediaQuery.of(context).size.width * 0.05;
    double cardSpacing = MediaQuery.of(context).size.width * 0.025;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developers'),
      ),
      body: GridView.builder(
        itemCount: developers.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: cardSpacing,
          mainAxisSpacing: cardSpacing,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                iconVisibility[index] = !iconVisibility[index];
              });
            },
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: cardImageSize,
                        height: cardImageSize,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(developers[index].image),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        width: cardImageSize,
                        height: cardImageSize,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(developers[index].name),
                  const SizedBox(height: 10),
                  if (iconVisibility[index]) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            FontAwesomeIcons.github,
                            size: iconSize,
                          ),
                          onPressed: () {
                            launch(developers[index].github);
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons.linkedin),
                          onPressed: () {
                            launch(developers[index].linkedin);
                          },
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
