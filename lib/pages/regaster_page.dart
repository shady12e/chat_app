import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/constans.dart';
import 'package:myapp/helper/show_snakw_bar.dart';
import 'package:myapp/widget/custom_eleveted_buttom.dart';
import 'package:myapp/widget/custom_text_fild.dart';

class RegesterPage extends StatefulWidget {
  RegesterPage({super.key});

  @override
  State<RegesterPage> createState() => _RegesterPageState();
}

class _RegesterPageState extends State<RegesterPage> {
  String? email;

  String? password;

  bool isLouding = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLouding,
      child: Scaffold(
        backgroundColor: KPrimaryAppColor,
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      kLogo,
                    ),
                    const Text(
                      'shady',
                      style: TextStyle(
                        fontFamily: 'Pacifico',
                        fontSize: 45,
                        color: Colors.white,
                      ),
                    ),
                    //'
                    const SizedBox(height: 70),
                    const Row(
                      children: [
                        Text(
                          'Regseter',
                          style: TextStyle(
                            fontSize: 35,
                            fontFamily: Kfont,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomTextFiled(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'you must put your email';
                        }
                      },
                      OnChange: (data) {
                        email = data;
                      },
                      labelName: 'Email',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextFiled(
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'you must put your password';
                        }
                      },
                      OnChange: (data) {
                        password = data;
                      },
                      labelName: 'Password',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      child: CustomElevatedBottoms(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLouding = true;
                              });
                              try {
                                await createAuserWithPassword();
                                ShowSnackBar(context, 'sucess', Colors.green);
                                Navigator.pop(context);
                              } on FirebaseException catch (ex) {
                                if (ex.code == 'weak-password') {
                                  ShowSnackBar(
                                      context, 'weak password', Colors.red);
                                } else if (ex.code == 'email-already-in-use') {
                                  ShowSnackBar(context, 'The email was taken',
                                      Colors.red);
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
                          textOfElevatedBottom: 'REGSTER',
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
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'lOGIN',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    //'
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  
  Future<void> createAuserWithPassword() async {
    UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
