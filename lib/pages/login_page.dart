import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/constants.dart';
import 'package:flutter_bootstrap/firebase/firebase_auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool signup = false;
  bool isInstructor = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  void resetInfo() {
    isInstructor = false;
    usernameController.text = "";
    emailController.text = "";
    passwordController.text = "";
    confirmController.text = "";
  }

  void performLogin() async {
    if (_formKey.currentState!.validate()) {
      if (!signup) {
        bool successful = await FirebaseAuthService.loginWithEmailAndPassword(
            context, emailController.text, passwordController.text);
        if (context.mounted && successful) {
          //TODO
        }
      } else {
        bool successful = await FirebaseAuthService.signupWithEmailAndPassword(
            context,
            usernameController.text,
            emailController.text,
            passwordController.text,
            (isInstructor) ? "Instructor" : " Student");
        if (context.mounted && successful) {
          //TODO
        }
      }
    }
  }

  void switchLoginSignup() {
    setState(() {
      signup = !signup;

      resetInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: null,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            (!signup) ? "Login" : "Sign up",
            style: titleTextStyle,
          ),
          Padding(
            padding: const EdgeInsets.all(globalEdgePadding),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    if (signup)
                      SizedBox(
                        child: TextFormField(
                          controller: usernameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: 'Create a username',
                              border: OutlineInputBorder()),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Username Cannot be empty';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    if (signup) const SizedBox(height: globalMarginPadding),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Enter your email',
                          border: OutlineInputBorder()),
                      validator: (val) {
                        if (val!.isEmpty ||
                            !emailRegex.hasMatch(emailController.text)) {
                          return 'Enter a valid email';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: globalMarginPadding),
                    SizedBox(
                      child: TextFormField(
                        controller: passwordController,
                        obscuringCharacter: '*',
                        obscureText: true,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: 'Enter your password',
                            border: OutlineInputBorder()),
                        validator: (val) {
                          if (val!.isEmpty ||
                              passwordController.text.length < 6) {
                            return 'Password must be 6 characters or longer';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    if (signup) const SizedBox(height: globalMarginPadding),
                    if (signup)
                      SizedBox(
                        child: TextFormField(
                          controller: confirmController,
                          obscuringCharacter: '*',
                          obscureText: true,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.repeat),
                              labelText: 'Confirm your password',
                              border: OutlineInputBorder()),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Enter your password again';
                            } else if (val != passwordController.text) {
                              return 'Must match previous password';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    if ((signup))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Are you a instructor?"),
                          Switch(
                              value: isInstructor,
                              onChanged: (bool value) {
                                setState(() {
                                  isInstructor = !isInstructor;
                                });
                              })
                        ],
                      )
                  ],
                )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  performLogin();
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(
                          globalEdgePadding,
                          globalMarginPadding,
                          globalEdgePadding,
                          globalMarginPadding),
                      decoration: const BoxDecoration(
                        color: tenUIColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                      ),
                      child: Row(
                        children: [
                          Text(
                            (!signup) ? "LOGIN" : "SIGN UP",
                            style: ctaButtonStyle,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(
                            Icons.arrow_right_alt_rounded,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: globalEdgePadding,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: globalEdgePadding,
          ),
          (signup)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    GestureDetector(
                        onTap: () {
                          switchLoginSignup();
                        },
                        child: const Text(
                          "Login Here!",
                          style: TextStyle(color: tenUIColor),
                        ))
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                        onTap: () {
                          switchLoginSignup();
                        },
                        child: const Text(
                          "Signup Here!",
                          style: TextStyle(color: tenUIColor),
                        ))
                  ],
                )
        ],
      ),
    );
  }
}
