import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_signin/screens/signin_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final uid=FirebaseAuth.instance.currentUser!.uid;
  final email=FirebaseAuth.instance.currentUser!.email;
  final creationTime=FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user=FirebaseAuth.instance.currentUser;

 void verifyEmail() async{
    if(user!=null || user!.emailVerified){
      await user!.sendEmailVerification();
    //  print('Verification Email has been sent ');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification Email has been sent',
        style: TextStyle(
          color: Colors.amber,
        ),),
        backgroundColor: Colors.black26,)
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text('User ID',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),),
            Text(uid,
              style: const TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w300
              ),),
            const SizedBox(height: 30.0,),
            Text('Email: $email',
              style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
              ),),

            user!.emailVerified?const Text('Verified',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 18.0,
            ),):

            TextButton(
              onPressed: (){
                verifyEmail();
              },
              child: const Text(
                'Verify Email',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.blueAccent
                ),),
            ),
            const SizedBox(height: 20.0,),
            const Text('Created',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),),
            Text(
              creationTime.toString(),
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300
              ),),
            const SizedBox(height: 20.0,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  padding:  const EdgeInsets.symmetric(horizontal: 30.0,vertical: 12.0),
                ),
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const SigninScreen()), (route) => false);
                },
                child: const Text('Logout',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),))
          ],
        ),
      ),
    );
  }
}
