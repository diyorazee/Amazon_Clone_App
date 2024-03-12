import 'dart:convert';

import 'package:amazon_clone_app/constants/error_handling.dart';
import 'package:amazon_clone_app/constants/global_variables.dart';
import 'package:amazon_clone_app/constants/show_snackbar.dart';
import 'package:amazon_clone_app/features/home/home_screen.dart';
import 'package:amazon_clone_app/models/user.dart';
import 'package:amazon_clone_app/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {

  //function Sign-up user
  void signUpUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    try{
      User user = User(
        id: '', 
        name: name, 
        email: email, 
        password: password, 
        address: '', 
        type: '', 
        token: ''
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'), 
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (!context.mounted) throw Exception();
      
      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess:(){
          showSnackBar(context, 'Account created!, login using same credentials!');
        }, 
      );

    } catch(e){
      showSnackBar(context, e.toString());
    }
  }

  //function to sign-in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  })async{
    try{

      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'), 
        body: jsonEncode({
          'email': email, 
          'password': password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );

      if (!context.mounted) throw Exception();

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: ()async{
          //intialized the providers with response from server 
          Provider.of<UserProvider>(context,listen: false).setUser(res.body);
        
          //intialized the SharedPreferences
          SharedPreferences pref = await SharedPreferences.getInstance();          
          await pref.setString('token', jsonDecode(res.body)['token']);

          if (!context.mounted) throw Exception();
          
          //intialized the providers with response from server 
          Provider.of<UserProvider>(context,listen: false).setUser(res.body);

          Navigator.pushNamedAndRemoveUntil(context,  HomeScreen.routeName, (route) => false);
        }
      );

    } catch(e){
      showSnackBar(context, e.toString());
    }
  }

}

