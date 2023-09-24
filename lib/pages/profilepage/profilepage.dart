import 'package:flutter/material.dart';
import 'package:efficacy_admin/configs/configurations/extensions/extensions.dart';
import 'package:efficacy_admin/configs/configs.dart';



class ProfilePage extends StatefulWidget {
  static const String routeName = '/profilepage';
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {

  final _profileKey = GlobalKey<FormState>();

  String dropdownvalue = 'B.Tech';

  var degree = [
    'B.Tech',
    'M.Tech',
    'Item 3',
    'Item 4',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    //size constants
    double textFieldheight = height * 0.05;
    double labelgap = height * 0.004;
    double gap = height * 0.02;
    double formWidth = width * 0.85;
    double margin = width * 0.08;
    double textfieldmargin = width * 0.03;
    double fontsize = height * 0.025;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        margin: EdgeInsets.only(right: margin, left: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Account Details",
              style: TextStyle(fontSize: fontsize * 1.6, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: formWidth,
              child: Form(
                key: _profileKey,
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Name",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 67, 67)),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 221, 216, 216),
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: textfieldmargin),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    initialValue: "John Doe",
                                    enabled: false,
                                  ),
                                ),
                              ].separate(labelgap),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Phone no.",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 67, 67)),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 221, 216, 216),
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: textfieldmargin),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    initialValue: "9087542361",
                                    enabled: false,
                                  ),
                                ),
                              ].separate(labelgap),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Scholar id",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: textfieldmargin),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    initialValue: "201432",
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ].separate(labelgap),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Branch",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: textfieldmargin),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    initialValue: "ECE",
                                  ),
                                ),
                              ].separate(labelgap),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Degree",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(
                                            top: 0, bottom: 0, left: textfieldmargin),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                    isExpanded: true,
                                    dropdownColor:
                                        const Color.fromRGBO(237, 249, 255, 1),
                                    style: TextStyle(
                                        fontSize: fontsize*0.85,
                                        color: Colors.black87),
                                    value: dropdownvalue,
                                    items: degree.map((String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Text(items),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        dropdownvalue = newValue!;
                                      });
                                    },
                                  ),
                                )
                              ].separate(labelgap),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Club",
                                    style: TextStyle(fontSize: fontsize, color: dark, fontWeight: FontWeight.w500)),
                                Container(
                                  height: textFieldheight,
                                  child: TextFormField(
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 69, 67, 67)),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 221, 216, 216),
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: textfieldmargin),
                                      border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                            width: 0,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    enabled: false,
                                    initialValue: "GDSC",
                                  ),
                                ),
                              ].separate(labelgap),
                            ),
                          ),
                        ].separate(gap)),
                  ),
                ),
              ),
            ),
          ].separate(gap),
        ),
      ),
    );
  }
}
