import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/constans.dart';
import 'package:myapp/helper/show_snakw_bar.dart';
import 'package:myapp/widget/custom_eleveted_buttom.dart';
import 'package:myapp/widget/custom_text_fild.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? email;

  String? password;

  bool isLouding = false;

  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLouding,
      child: Scaffold(
        backgroundColor: KPrimaryAppColor,
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 1,
                ),
                Image.asset(
                  kLogo,
                ),
                const Text(
                  'shady',
                  style: TextStyle(
                    fontFamily: Kfont,
                    fontSize: 45,
                    color: Colors.white,
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
                const Row(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'Pacifico',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                CustomTextFiled(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'you must put your email';
                      }
                    },
                    OnChange: (data) {
                      // email
                      email = data;
                    },
                    labelName: 'Email'),
                SizedBox(
                  height: 20,
                ),
                CustomTextFiled(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'you must put your password';
                      }
                    },
                    OnChange: (data) {
                      // password
                      password = data;
                    },
                    labelName: 'Password'),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: CustomElevatedBottoms(
                      onTap: () async {
                        if (formkey.currentState!.validate()) {
                          setState(() {
                            isLouding = true;
                          });
                          try {
                            await signAuserWithPassword();
                            ShowSnackBar(context, 'sucess', Colors.green);
                            Navigator.pushNamed(context, 'ChatPage' ,  arguments: email);
                          } on FirebaseAuthException catch (ex) {
                            if (ex.code == 'wrong-password') {
                              ShowSnackBar(
                                  context, 'woungPassword', Colors.red);
                            } else if (ex.code == 'user-not-found') {
                              ShowSnackBar(context,
                                  'must be sure not your mail', Colors.red);
                            }
                          } catch (ex) {
                            ShowSnackBar(
                                context, 'There was an error', Colors.red);
                          }
                          setState(() {
                            isLouding = false;
                          });
                        }
                      },
                      textOfElevatedBottom: 'Login',
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'you don\'t have an account?',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'RegesterPage');
                      },
                      child: const Text(
                        'REGISTER HERE',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  Future<void> signAuserWithPassword() async {
    var auth = FirebaseAuth.instance;
    UserCredential user =await auth.signInWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
