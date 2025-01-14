import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart.';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:recipe_app/controllers/user_controller.dart';
import 'package:recipe_app/screens/onboarding/signup_screen.dart';
import 'package:recipe_app/screens/onboarding/welcome_screen.dart';
import 'package:recipe_app/screens/widgets/custom_textField.dart';
import 'package:recipe_app/validator.dart';

import '../../Auth/authenticator.dart';
import '../bottom_nav_screens/homeView_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  final AuthenticatorService authService = AuthenticatorService();


  bool obscureText = true;
   bool _isLoading = false;

   void signInWithGoogle()async{
     setState(() {
       _isLoading = true;
     });
     try{
       final googleUser = await authService.googleAuth();
       if(googleUser != null){
         print('Signed in as ${googleUser.displayName}');
         Navigator.pushReplacement(context,
             MaterialPageRoute(
                 builder: (context) =>  const WelcomeScreen()
             ));
       }
     } on FirebaseAuthException{
       rethrow;
     } catch(e){
       if(mounted){
         ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(content: Text('Failed to signin user')));
       }

     }
     finally{
       setState(() {
         _isLoading = false;
       });
     }

   }

    Future<void> _loginUser()async{
      if(_globalKey.currentState!.validate()){
        setState(() {
          _isLoading = true;
        });

        try{
          UserCredential? userCredential = await authService.loginUser(
              email: _emailController.text,
              password: _passwordController.text);

          if(userCredential != null){
            Navigator.pushReplacement(context,
                MaterialPageRoute(
                    builder: (context) =>  const WelcomeScreen()
                ));
          }
      } on FirebaseAuthException{
          rethrow;
        }catch(e){
          if(mounted){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to create user')));
          }
        }
        finally {
          setState(() {
            _isLoading = false;
          });
        }
        }
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
            child: ListView(
              children: [ Form(
                key: _globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20,),
                    Container(
                        padding: const EdgeInsets.all(12),
                        height: 45,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle
                        ),
                        child: const Icon(Icons.star_border_sharp,color: Colors.white,)
                    ),
                    const SizedBox(height: 30,),
                    const Text('Welcome Back', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                    ),),
                    const SizedBox(height: 8,),
                    const Text('We are happy to see you here again, enter your email and password',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),),
                    const SizedBox(height: 16,),
                    CustomTextfield(
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                        controller: _emailController,
                      obscureText: false,
                      icon: const Icon(Icons.email),
                      validate: (value){
                          return Validator.emailValidator(value);
                      },
                    ),
                    const SizedBox(height: 16,),
                    CustomTextfield(
                        label: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                      obscureText: obscureText,
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              obscureText = !obscureText;
                            });
                          }, icon: obscureText? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                      ),
                      validate: (value){
                          return Validator.passwordValidator(value);
                      },
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Forgot Password?', style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          color: Colors.green.shade500
                        ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 36,),
                    ElevatedButton(
                        onPressed: _loginUser,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)
                            ),
                            minimumSize: Size(MediaQuery.of(context).size.width*0.9, 50)
                        ),
                        child:_isLoading? const CircularProgressIndicator(
                          color: Colors.white,
                        ) : const Text('Login', style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700
                        ),
                        )
                    ),
                    const SizedBox(height: 26,),

                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Divider(color: Colors.grey, )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('OR', style: TextStyle(color: Colors.grey),),
                        ),
                        Expanded(child: Divider(color: Colors.grey, )),
                      ],
                    ),
                    const SizedBox(height: 8,),
                    ElevatedButton(
                        onPressed: signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.network('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                            height: 45,
                            width: 45,),
                            const SizedBox(width: 35,),
                            const Text('Login With Google', style: TextStyle(
                              fontSize: 17
                            ),)
                          ],
                        )),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('New to Foodie?', style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          fontWeight: FontWeight.w700
                        ),),
                        TextButton(
                            onPressed: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>  const SignupScreen()
                                  ));
                            },
                            child: const Text('Register', style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w500
                            ),))
                      ],
                    )
                  ],
                ),
              ),
            ]
            ),
          )
      ),
    );
  }
}
