import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey=GlobalKey<FormState>();

  String email='';
  String password='';
  String confirmPassword='';

  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final confirmPasswordController=TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  registration() async{
    if(password==confirmPassword){
      try{
      //  UserCredential userCredential=
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
       // print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blueGrey,
              content: Text('Registered Successfully. please signin',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),))
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SigninScreen()));
      }on FirebaseAuthException catch(error){
        if(error.code=='weak-password'){
         // print('password is too weak');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                backgroundColor: Colors.grey,
                content: Text('password is too weak',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16.0
                ),))
          );
        }
        else if(error.code=='email-already-in-use'){
         // print('Account is already exist');
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.grey,
                  content: Text('Account is already exist',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.0
                    ),))
          );

        }

      }
  }
    else {
    //  print('password and confirm password does not match');

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              backgroundColor: Colors.grey,
              content: Text('password and confirm password does not match',
                style: TextStyle(
                    color: Colors.redAccent,
                  fontSize: 16.0
                ),))
      );

    }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: _formKey,
          child:ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0,top: 50.0),
                child: Text('SignUp !',
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text('Create your account',
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
                child: TextFormField(
                  autofocus: false,
                  controller: confirmPasswordController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please confirm password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      errorStyle: const TextStyle(color: Colors.black)
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
                         confirmPassword=confirmPasswordController.text;
                       });
                       registration();
                     }
                    },
                    child: const Text('Signup',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0
                        ))),
              ),
              const SizedBox(height:20.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",
                        style: TextStyle(
                            color: Colors.grey[700]
                        )),
                    TextButton(
                        onPressed: (){
                     Navigator.pushReplacement(
                         context, PageRouteBuilder(
                         pageBuilder:(context,animation1,animation2)=>const SigninScreen(),
                     transitionDuration: const Duration(seconds: 0)));
                        },
                        child: const Text('Signin',
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),))
                  ],
                ),
              )

            ],
          )),
    );
  }
}
