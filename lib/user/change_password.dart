import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/signin_screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();

  String newPassword = '';
  final newPasswordController = TextEditingController();

  final currentUser=FirebaseAuth.instance.currentUser;

 void changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const SigninScreen()));

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black26,
              content: Text('Your password has been changed.. Login again !')));
    }catch(error){
     // print(error);
    }
  }
  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Enter New Password',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  autofocus: false,
                  controller: newPasswordController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    errorStyle: const TextStyle(
                      color: Colors.black26,
                    )
                  ),
                ),
              ),
              const SizedBox(height: 30.0,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  padding:  const EdgeInsets.symmetric(horizontal: 30.0,vertical: 12.0),
                ),
                  onPressed: (){
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        newPassword=newPasswordController.text;
                      });
                      changePassword();
                    }
                  },
                  child: const Text('Change Password',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0
                      )))
            ],
          )),
    );
  }
}
