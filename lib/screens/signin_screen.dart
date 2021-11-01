import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/forgot_password_screen.dart';
import 'package:flutter_firebase_signin/screens/signup_screen.dart';
import 'package:flutter_firebase_signin/screens/user_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  
  final _formKey=GlobalKey<FormState>();

  String email='';
  String password='';

  final emailController=TextEditingController();
  final passwordController=TextEditingController();

 void userSignin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const UserScreen()));

    }on FirebaseAuthException catch(error){
      if(error.code=='user-not-found'){
        // print('No user found for that email');

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.grey,
                content: Text('No user found for that email',
                style: TextStyle(color: Colors.amber),)));
      }
      else if(error.code=='wrong-password'){
       // print('wrong password provided by the user');

        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.grey,
                content: Text('wrong password provided by the user',
                  style: TextStyle(color: Colors.amber),)));
      }
    }
  }
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
          child:ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0,top: 50.0,),
                child: Text('SignIn',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Signin to your account',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),),
              ),
              const SizedBox(height: 50.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: false,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter email';
                    }if(!value.contains('@')){
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    errorStyle: const TextStyle(color: Colors.black)
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  autofocus: false,
                  controller: passwordController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      errorStyle: const TextStyle(color: Colors.black)
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder:(context)=>const ForgotPasswordScreen()));
                    },
                    child: const Text('Forgot Password?'),
                  ),
                ),
              ),
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
                          password=passwordController.text;
                        });
                        userSignin();
                      }
                    },
                    child: const Text('Signin',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),)),
              ),
              const SizedBox(height: 20.0,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey[700]
                        )),
                    TextButton(
                        onPressed: (){
                          Navigator.pushAndRemoveUntil(
                              context, PageRouteBuilder(
                              pageBuilder:(context,a,b)=>const SignupScreen(), transitionDuration: const Duration(seconds: 0) ), (route) => false);
                        },
                        child: const Text('Signup',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            )))
                  ],
                ),
              )

            ],
          )),
    );
  }
}
