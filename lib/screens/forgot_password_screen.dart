import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/signin_screen.dart';
import 'package:flutter_firebase_signin/screens/signup_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _formKey=GlobalKey<FormState>();

  String email='';
  final emailController=TextEditingController();

  resetPassword() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    // print('email sent');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.blueGrey,
            content: Text('Password reset email has been sent !',
            style: TextStyle(
              color: Colors.white,
            ),))
      );
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const SigninScreen()));
    } on FirebaseAuthException catch(error){
      if(error.code=='user-not-found'){
      //  print('no user found for that email');

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.grey,
                content: Text('no user found for that email',
                style: TextStyle(
                  color: Colors.redAccent,
                ),))
        );
      }
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Reset Password'),
      ),
      body: Form(
            key: _formKey,
            child: ListView(
              children: [
                const SizedBox(height: 120.0,),
                const Align(
                  alignment: Alignment.center,
                  child: Text('Reset link will be sent to your email ID !',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.indigo
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    autofocus: false,
                    controller: emailController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please enter email';
                      }
                      else if(!value.contains('@')){
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                        color: Colors.black26,
                      )
                    ),
                  ),
                ),
                const SizedBox(height: 30.0,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.0))),
                        padding: const EdgeInsets.all(13.0),
                      ),
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email=emailController.text;
                          });
                          resetPassword();
                        }
                      },
                      child: const Text('Send email',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0
                          ))),
                ),
                // TextButton(
                //     onPressed: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SigninScreen()));
                //     },
                //     child: Text('Signin')),
                const SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account signup?",
                        style: TextStyle(
                            color: Colors.grey[700]
                        )),
                    TextButton(
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context,a,b)=>const SignupScreen(),
                        transitionDuration: const Duration(seconds: 0)), (route) => false);
                      },
                      child: const Text('Signup',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          )),
                    )
                  ],
                )

              ],
            ),),

    );
  }
}
