import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginpage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String dropdownvalue = 'GDSC';

  // List of items in our dropdown menu
  var items = [
    'GDSC',
    'Eco Club',
    'Item 3',
    'Item 4',
  ];

  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: const Color.fromRGBO(196, 196, 196, 1),
              radius: myWidth * 0.2,
              child: const SizedBox(),
            ),
            SizedBox(
              height: myHeight * 0.02,
            ),
            //login form
            Form(
                child: SizedBox(
              width: myWidth * 0.8,
              child: Column(
                children: [
                  //email field
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: "efficacy789@gmail.com",
                    ),
                  ),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  //name field
                  TextFormField(
                    decoration: const InputDecoration(hintText: "John Doe"),
                  ),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  //intl number field
                  const IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "9077900",
                      hintStyle: TextStyle(color: Color.fromRGBO(5, 53, 75, 1)),
                    ),
                    initialCountryCode: 'IN',
                  ),
                  SizedBox(
                    height: myHeight * 0.02,
                  ),
                  //club menu field
                  DropdownButton(
                    isExpanded: true,
                    dropdownColor: const Color.fromRGBO(237, 249, 255, 1),
                    style: const TextStyle(color: Color.fromRGBO(5, 53, 75, 1)),
                    value: dropdownvalue,
                    items: items.map((String items) {
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
                  SizedBox(
                    height: myHeight * 0.04,
                  ),
                  ElevatedButton(onPressed: () {}, child: const Text("Sign Up")),
                  SizedBox(
                    height: myHeight * 0.01,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Club not in the list?",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(128, 128, 128, 1)),
                      ),
                      Text(
                        "mail us at mail@gdsc",
                        style: TextStyle(
                            fontSize: 12, color: Color.fromRGBO(5, 53, 76, 1)),
                      )
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
