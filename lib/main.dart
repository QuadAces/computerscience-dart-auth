import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
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

  bool isPasswordCompliant(String password, [int minLength = 6]) {
//! This function returns a boolean variable (true or false) bassed on if the password meets all the specified conditions

    //* Checks if password is empty
    if (password.isEmpty) {
      return false;
    }
//* Checks if password contains a capital letter
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
//* Checks if password contains a number
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
//* Checks if password contains a lowercase letter
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
//* Checks if password contains a special character
    bool hasSpecialCharacters =
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
//* Checks if password is long enough (checking the passwords length against the minimum required length
    bool hasMinLength = password.length > minLength;

//! This function will return true if all conditions are met, otherwise false is returned
    return hasDigits &
        hasUppercase &
        hasLowercase &
        hasSpecialCharacters &
        hasMinLength;
  }

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
        !name.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

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
        !address.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

//! This function will return true if all conditions are met, otherwise false is returned
    return doesNotHaveSpecialCharacters;
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
            IconButton(onPressed: () => {}, icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () => {}, icon: const Icon(Icons.text_increase)),
            IconButton(onPressed: () => {}, icon: const Icon(Icons.public)),
            IconButton(onPressed: () => {}, icon: const Icon(Icons.settings)),
          ],
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
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
                      fontSize: 64.0,
                    ),
                  ),
                ),
                Form(
                    // autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: firstNameController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
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
                              border: OutlineInputBorder(),
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
                        InputDatePickerFormField(
                          fieldLabelText: 'Age (must be above 18)',
                          initialDate: DateTime.utc(DateTime.now().year - 18,
                              DateTime.now().month, DateTime.now().day),
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
                        TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter your email address'),
                          validator: (value) {
                            bool valid = isEmailCompliant(value ?? '');
                            if (!valid) {
                              return 'Please ensure your email contains an @ and has a valid ending';
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
                              border: OutlineInputBorder(),
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    //! This function is called when the form is submitted

                                    //* form value is set to the form's key's state.
                                    final form = _formKey.currentState;

                                    //* checks if the form is correctly validated. (if _formKey.currentState!.validate() is true, the code below will execute, otherwise nothing will)
                                    if (_formKey.currentState!.validate()) {
                                      //* form is saved
                                      form?.save();
                                      //* Sets firstname, lastname, email, and postal to the values of the input
                                      setState(() {
                                        FormData.fname =
                                            firstNameController.text;
                                        FormData.lname =
                                            lastNameController.text;
                                        FormData.email = emailController.text;
                                        FormData.postal =
                                            postalAddressController.text;
                                      });
                                      //! It is worth noting, that because date of birth was inputted in a separate form element, it was set in a different function. Form data was, then edited and saved onSave of said form element.

                                      //* Method of class that outputs variable to console.
                                      FormData.printVariables();
                                    }
                                  },
                                  child: const Text('Create Account')),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  onPressed: () => {},
                                  child: const Text('Login'),
                                ),
                              )
                            ])
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ViewObject()))
                          },
                      child: const Text('View Stored Data')),
                )
              ],
            ),
          ),
        )));
  }
}

class ViewObject extends StatelessWidget {
  const ViewObject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Signup',
              style: TextStyle(
                fontSize: 64.0,
              ),
            ),
          ),
          Text(
              'firstname: ${FormData.fname}, lastname: ${FormData.lname}, dob: ${FormData.dob != null ? DateFormat("yyyy-MM-dd").format(FormData.dob ?? DateTime.now()) : 'not stored (submit via creat account button!)'}, email: ${FormData.email}, postal: ${FormData.postal}')
        ],
      ),
    );
  }
}

class FormData {
  static String? fname = 'not stored (submit via creat account button!)';
  static String? lname = 'not stored (submit via creat account button!)';
  static DateTime? dob;
  static String? email = 'not stored (submit via creat account button!)';
  static String? postal = 'not stored (submit via creat account button!)';
  static printVariables() {
    print(
        'firstname: $fname, lastname: $lname, dob: $dob, email: $email, postal: $postal');
  }
}
