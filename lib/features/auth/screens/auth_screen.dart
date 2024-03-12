import 'package:amazon_clone_app/common/widgets/custom_button.dart';
import 'package:amazon_clone_app/common/widgets/custom_textfield.dart';
import 'package:amazon_clone_app/constants/global_variables.dart';
import 'package:amazon_clone_app/features/auth/services/auth_services.dart';
import 'package:flutter/material.dart';

enum Auth{
  signin, 
  signup,
}

class AuthScreen extends StatefulWidget{
  static const String routeName = '/auth-screen';
  const AuthScreen({Key? key}): super(key : key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>{
  Auth _auth = Auth.signup; 
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthServices authServices = AuthServices();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void signUpUser(){
    authServices.signUpUser(
      context: context, 
      name: nameController.text, 
      email: emailController.text, 
      password: passController.text
    );
  }

  void signInUser(){
    authServices.signInUser(
      context: context, 
      email: emailController.text, 
      password: passController.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Text("Welcome", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600 )),
                ListTile(
                  tileColor: _auth==Auth.signup ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text("Create Account", style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    value: Auth.signup, 
                    groupValue: _auth, 
                    onChanged: (Auth? val){
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ), 
                if(_auth == Auth.signup)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signUpFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: nameController, 
                            hintText: 'Name',
                          ),
                          const SizedBox(height: 11),
                          CustomTextField(
                            controller: emailController, 
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 11),
                          CustomTextField(
                            controller: passController, 
                            hintText: 'Password',
                          ),
                          const SizedBox(height: 11),
                          CustomButton(
                            name: "Sign Up", 
                            callback: (){
                              if(_signUpFormKey.currentState!.validate()){
                                signUpUser();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                ListTile(
                  tileColor: _auth==Auth.signin ? GlobalVariables.backgroundColor : GlobalVariables.greyBackgroundCOlor,
                  title: const Text("Sign-in", style: TextStyle(fontWeight: FontWeight.bold)),
                  leading: Radio(
                    value: Auth.signin,
                    groupValue: _auth,
                    onChanged: (Auth? val){
                      setState(() {
                        _auth = val!;
                      });
                    },
                  ),
                ),
                if(_auth == Auth.signin)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    color: GlobalVariables.backgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController, 
                            hintText: 'Email',
                          ),
                          const SizedBox(height: 11),
                          CustomTextField(
                            controller: passController, 
                            hintText: 'Password',
                          ),
                          const SizedBox(height: 11),
                          CustomButton(
                            name: "Sign In", 
                            callback: (){
                              if(_signInFormKey.currentState!.validate()){
                                signInUser();
                              }
                            }
                          ),
                        ],
                      ),
                    ),
                  ),  

              ],
            ),
          ),
        ),
    );
  }
}