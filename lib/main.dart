import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: FlexColorScheme.light(
              colors: FlexColor.schemes[FlexScheme.material]!.light)
          .toTheme,
      home: const MyHomePage(title: 'Xorva'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  DateTime? datePicked;
  final emailController = TextEditingController();
  final postalAddressController = TextEditingController();
  final suburbController = TextEditingController();
  final stateController = TextEditingController();
  final postCodeController = TextEditingController();
  final schoolController = TextEditingController();
  final phoneController = TextEditingController();

  bool isEmailCompliant(String email) {
//! This function returns a boolean variable (true or false) bassed on if the email meets all the specified conditions

    //* Checks if email is empty
    if (email.isEmpty) {
      return false;
    }

//* Checks if email contains an @
    bool hasAt = email.contains(RegExp(r'[@]'));

//* Checks if email contains a .
    bool hasDot = email.contains(RegExp(
        r'''^[a-z0-9!#$%&''*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&''*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$'''));

//! This function will return true if all conditions are met, otherwise false is returned
    return hasAt & hasDot;
  }

  bool isNameCompliant(String name) {
//! This function returns a boolean variable (true or false) bassed on if the name meets all the specified conditions

    //* Checks if name is empty
    if (name.isEmpty) {
      return false;
    }

//* Checks if name does not contain a number
    bool doesNotHaveDigits = !name.contains(RegExp(r'[0-9]'));

//* Checks if name does not contain a special character
    bool doesNotHaveSpecialCharacters =
        !name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveDigits & doesNotHaveSpecialCharacters;
  }

  bool isAddressCompliant(String address) {
//! This function returns a boolean variable (true or false) bassed on if the address meets all the specified conditions

    //* Checks if address is empty
    if (address.isEmpty) {
      return false;
    }

//* Checks if address does not contain a special character
    bool doesNotHaveSpecialCharacters =
        !address.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveSpecialCharacters;
  }

  bool isSuburbCompliant(String suburb) {
//! This function returns a boolean variable (true or false) bassed on if the suburb meets all the specified conditions

    //* Checks if suburb is empty
    if (suburb.isEmpty) {
      return false;
    }

//* Checks if suburb does not contain a special character
    bool doesNotHaveSpecialCharacters =
        !suburb.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));

    //* Checks if suburb does not contain a number
    bool doesNotHaveDigits = !suburb.contains(RegExp(r'[0-9]'));

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveSpecialCharacters && doesNotHaveDigits;
  }

  bool isStateCompliant(String state) {
//! This function returns a boolean variable (true or false) bassed on if the state meets all the specified conditions

    //* Checks if state is empty
    if (state.isEmpty) {
      return false;
    }

//* Checks if state does not contain a special character
    bool doesNotHaveSpecialCharacters =
        !state.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));

    //* Checks if state does not contain a number
    bool doesNotHaveDigits = !state.contains(RegExp(r'[0-9]'));

//* Checks if state is a valid Australian State
    bool isValidState = (state.toLowerCase() == 'new south wales' ||
        state.toLowerCase() == 'queensland' ||
        state.toLowerCase() == 'south australia' ||
        state.toLowerCase() == 'tasmania' ||
        state.toLowerCase() == 'victoria' ||
        state.toLowerCase() == 'western australia' ||
        state.toLowerCase() == 'australian capital territory' ||
        state.toLowerCase() == 'northern territory' ||
        state.toLowerCase() == 'new south wales' ||
        state.toLowerCase() == 'qld' ||
        state.toLowerCase() == 'sa' ||
        state.toLowerCase() == 'tas' ||
        state.toLowerCase() == 'vic' ||
        state.toLowerCase() == 'wa' ||
        state.toLowerCase() == 'act' ||
        state.toLowerCase() == 'nt' ||
        state.toLowerCase() == 'nsw');

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveSpecialCharacters && doesNotHaveDigits && isValidState;
  }

  bool isPostCodeCompliant(String postCode, [int length = 4]) {
//! This function returns a boolean variable (true or false) bassed on if the state meets all the specified conditions

    //* Checks if state is empty
    if (postCode.isEmpty) {
      return false;
    }

//* Checks if postCode (does not) contain a capital letter
    bool doesNotHaveUppercase = !postCode.contains(RegExp(r'[A-Z]'));
//* Checks if password contains a number
    bool hasDigits = postCode.contains(RegExp(r'[0-9]'));
//* Checks if postCode (does not) contain a lowercase letter
    bool doesNotHaveLowercase = !postCode.contains(RegExp(r'[a-z]'));
//* Checks if postCode (does not) contain a special character
    bool doesNotHavehasSpecialCharacters =
        !postCode.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));
//* Checks if length is long enough (checking the passwords length against the required length)
    bool hasLength = postCode.length == length;

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveUppercase &&
        doesNotHaveLowercase &&
        hasDigits &&
        doesNotHavehasSpecialCharacters &&
        hasLength;
  }

  bool isSchoolCompliant(
    String school,
  ) {
//! This function returns a boolean variable (true or false) bassed on if the state meets all the specified conditions

    //* Checks if state is empty
    if (school.isEmpty) {
      return false;
    }

//* Checks if school (does not) contain a number
    bool doesNotHaveDigits = !school.contains(RegExp(r'[0-9]'));

//* Checks if school (does not) contain a special character
    bool doesNotHavehasSpecialCharacters =
        !school.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]+-'));

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveDigits && doesNotHavehasSpecialCharacters;
  }

  bool isPhoneCompliant(
    String phone,
  ) {
//! This function returns a boolean variable (true or false) bassed on if the state meets all the specified conditions

    //* Checks if state is empty
    if (phone.isEmpty) {
      return false;
    }

//* Checks if phone contains a number
    bool hasDigits = phone.contains(RegExp(r'[0-9]'));

//* Checks if phone (does not) contain a special character
    bool doesNotHavehasSpecialCharacters =
        !phone.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

//* Checks if phone (does not) contain a lowercase letter
    bool doesNotHaveLowercase = !phone.contains(RegExp(r'[a-z]'));

    //* Checks if phon (does not) contain a lowercase letter
    bool doesNotHaveUppercase = !phone.contains(RegExp(r'[A-Z]'));

//* Checks that phone is correct length

    bool isMinLength = phone.length >= 10;
    bool isMaxLength = phone.length <= 11;

//! This function will return true if all conditions are met, otherwise false is returned
    return hasDigits &&
        doesNotHavehasSpecialCharacters &&
        doesNotHaveLowercase &&
        doesNotHaveUppercase &&
        isMinLength &&
        isMaxLength;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.search),
                tooltip: 'Search',
              ),
              const SizedBox(
                width: 5,
              ),
              MediaQuery.of(context).size.width > 800
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Search',
                          )),
                    )
                  : Container(),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  tooltip: 'Font Enlarger',
                  onPressed: () => {},
                  icon: const Icon(Icons.text_increase)),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.public),
                tooltip: 'Change region',
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.menu),
                tooltip: 'Menu',
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.settings),
                tooltip: 'Settings ',
              ),
            ],
            title: GestureDetector(
                onTap: () => {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewObject()))
                    },
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(children: [
                      Image.asset(
                        './XorvaLogo.jpg',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Xorva')
                    ]),
                  ),
                ))),
        body: FooterView(
            footer: Footer(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Flexible(
                        flex: 0,
                        child: Text('Xorva.com©'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('All rights reserved'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Who we are'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Contact us'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Privacy Policy'),
                      ),
                    ],
                  )),
            ),
            children: [
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.1),
                  child: Center(
                      // Center is a layout widget. It takes a single child and positions it
                      // in the middle of the parent.
                      child: Column(
                    // Column is also a layout widget. It takes a list of children and
                    // arranges them vertically. By default, it sizes itself to fit its
                    // children horizontally, and tries to be as tall as its parent.
                    //
                    // Invoke "debug painting" (press "p" in the console, choose the
                    // "Toggle Debug Paint" action from the Flutter Inspector in Android
                    // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                    // to see the wireframe for each widget.
                    //
                    // Column has various properties to control how it sizes itself and
                    // how it positions its children. Here we use mainAxisAlignment to
                    // center the children vertically; the main axis here is the vertical
                    // axis because Columns are vertical (the cross axis would be
                    // horizontal).
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 64.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: firstNameController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your first name'),
                                validator: (value) {
                                  bool valid = isNameCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please enter a valid first name (no special characters, no numbers)';
                                  }

                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: lastNameController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your last name'),
                                validator: (value) {
                                  bool valid = isNameCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please enter a valid last name (no special characters, no numbers)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: postalAddressController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your postal address'),
                                validator: (value) {
                                  bool valid = isAddressCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure that your address is valid (no special characters)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: suburbController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your suburb'),
                                validator: (value) {
                                  bool valid = isSuburbCompliant(value ?? '');
                                  //! make it suburb
                                  if (!valid) {
                                    return 'Please ensure that your suburb is valid (no special characters, no numbers)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: stateController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your state'),
                                validator: (value) {
                                  bool valid = isStateCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure that your State is valid (no special characters, no numbers, and is a valid Australian state/territory)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: postCodeController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your post code'),
                                validator: (value) {
                                  bool valid = isPostCodeCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure that your address is valid (no special characters, no letters, a length of 4)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: schoolController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your school'),
                                validator: (value) {
                                  bool valid = isSchoolCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure that your address is valid (no special characters, no numbers)';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: phoneController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your phone number'),
                                validator: (value) {
                                  bool valid = isPhoneCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure that your address is valid (no special characters, no characters, a length of 10 or 11. (Do not include a +))';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                controller: emailController,
                                decoration: const InputDecoration(
                                    hintText: 'Enter your email address'),
                                validator: (value) {
                                  bool valid = isEmailCompliant(value ?? '');
                                  if (!valid) {
                                    return 'Please ensure your email contains an @ and has a valid ending and is lowercase';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              InputDatePickerFormField(
                                fieldLabelText:
                                    'Age dd/mm/yyyy (must be above 18)',
                                initialDate: DateTime.utc(
                                    DateTime.now().year - 18,
                                    DateTime.now().month,
                                    DateTime.now().day),
                                lastDate: DateTime.utc(DateTime.now().year - 18,
                                    DateTime.now().month, DateTime.now().day),
                                firstDate: DateTime(1900),
                                fieldHintText: 'Enter your date of birth',
                                onDateSaved: (value) {
                                  setState(() {
                                    FormData.dob = value;
                                  });
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {
                                          //! This function is called when the form is submitted

                                          //* form value is set to the form's key's state.
                                          final form = _formKey.currentState;

                                          //* checks if the form is correctly validated. (if _formKey.currentState!.validate() is true, the code below will execute, otherwise nothing will)
                                          if (_formKey.currentState!
                                              .validate()) {
                                            //* form is saved
                                            form?.save();
                                            //* Sets all values to the values of the input
                                            setState(() {
                                              FormData.fname =
                                                  firstNameController.text;
                                              FormData.lname =
                                                  lastNameController.text;
                                              FormData.email =
                                                  emailController.text;
                                              FormData.postal =
                                                  postalAddressController.text;
                                              FormData.suburb =
                                                  suburbController.text;
                                              FormData.state = stateController
                                                  .text
                                                  .toUpperCase();
                                              FormData.postCode =
                                                  postCodeController.text;
                                              FormData.school =
                                                  schoolController.text;
                                              FormData.phone =
                                                  phoneController.text;
                                            });
                                            //! It is worth noting, that because date of birth was inputted in a separate form element, it was set in a different function. Form data was, then edited and saved onSave of said form element.

                                            //* Method of class that outputs variable to console.
                                            FormData.printVariables();

                                            //* Opens up a new page
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const ViewObject()));
                                          }
                                        },
                                        child: const Text('Create Account')),
                                    // Padding( //!Login button was removed here
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 10),
                                    //   child: ElevatedButton(
                                    //     onPressed: () => {},
                                    //     child: const Text('Login'),
                                    //   ),
                                    // )
                                  ])
                            ],
                          )),
                      // Padding( //! removed button
                      //   padding: const EdgeInsets.symmetric(vertical: 10),
                      //   child: ElevatedButton(
                      //       onPressed: () => {
                      //             Navigator.push(
                      //                 context,
                      //                 MaterialPageRoute(
                      //                     builder: (context) =>
                      //                         const ViewObject()))
                      //           },
                      //       child: const Text('View Stored Data')),
                      // ),
                    ],
                  )),
                ),
              )
            ]));
  }
}

class ViewObject extends StatelessWidget {
  const ViewObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.search),
                tooltip: 'Search',
              ),
              const SizedBox(
                width: 5,
              ),
              MediaQuery.of(context).size.width > 800
                  ? SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                      child: TextFormField(
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            hintText: 'Search',
                          )),
                    )
                  : Container(),
              const SizedBox(
                width: 5,
              ),
              IconButton(
                  tooltip: 'Font Enlarger',
                  onPressed: () => {},
                  icon: const Icon(Icons.text_increase)),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.public),
                tooltip: 'Change region',
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.menu),
                tooltip: 'Menu',
              ),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(Icons.settings),
                tooltip: 'Settings ',
              ),
            ],
            title: GestureDetector(
                onTap: () => {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewObject()))
                    },
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Row(children: [
                      Image.asset(
                        './XorvaLogo.jpg',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text('Xorva')
                    ]),
                  ),
                ))),
        body: FooterView(
            footer: Footer(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Flexible(
                        flex: 0,
                        child: Text('Xorva.com©'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('All rights reserved'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Who we are'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Contact us'),
                      ),
                      Flexible(
                        flex: 0,
                        child: Text('Privacy Policy'),
                      ),
                    ],
                  )),
            ),
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        'Stored Data:',
                        style: TextStyle(
                          fontSize: 64.0,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          'First Name Entered: ${FormData.fname}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Last Name Entered: ${FormData.lname}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Postal Entered: ${FormData.postal}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Suburb Entered: ${FormData.suburb}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'State Entered: ${FormData.state}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Post Code Entered: ${FormData.postCode}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'School Entered: ${FormData.school}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Phone Number Entered: ${FormData.phone}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Email Address Entered: ${FormData.email}',
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Date of Birth Entered: ${FormData.dob != null ? DateFormat("yyyy-MM-dd").format(FormData.dob ?? DateTime.now()) : 'not stored (submit via creat account button!)'}',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]));
  }
}

class FormData {
  static String? fname = 'not stored (submit via creat account button!)';
  static String? lname = 'not stored (submit via creat account button!)';
  static DateTime? dob;
  static String? email = 'not stored (submit via creat account button!)';
  static String? postal = 'not stored (submit via creat account button!)';
  static String? suburb = 'not stored (submit via creat account button!)';
  static String? state = 'not stored (submit via creat account button!)';
  static String? postCode = 'not stored (submit via creat account button!)';
  static String? school = 'not stored (submit via creat account button!)';
  static String? phone = 'not stored (submit via creat account button!)';

  static printVariables() {
    print(
        'firstname: $fname, lastname: $lname, dob: $dob, email: $email, postal: $postal');
  }
}
