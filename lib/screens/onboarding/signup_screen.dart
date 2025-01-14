import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Auth/authenticator.dart';
import 'package:recipe_app/screens/onboarding/login_screen.dart';
import 'package:recipe_app/screens/onboarding/welcome_screen.dart';
import 'package:recipe_app/screens/widgets/custom_buton.dart';
import 'package:recipe_app/screens/widgets/custom_textField.dart';
import 'package:recipe_app/validator.dart';

class SignupScreen extends StatefulWidget {
   const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
   final TextEditingController _passwordController = TextEditingController();
   final TextEditingController _nameController = TextEditingController();
   GlobalKey<FormState> formKey = GlobalKey<FormState>();

   AuthenticatorService _authenticatorService = AuthenticatorService();

   bool isLoading = false;
   bool obscureText = true;
  bool _isLoading = false;

  void signUpWithGoogle()async{
    setState(() {
      _isLoading = true;
    });
    try{
      final googleUser = await _authenticatorService.googleAuth();
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


  Future<void> _signup()async{
    if(formKey.currentState!.validate()){
      setState(() {
        isLoading = true;
      });

      try{
        UserCredential? userCredential = await _authenticatorService.createUser(
            userEmail: _emailController.text,
            userPassword: _passwordController.text);
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
          isLoading = false;
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
            Form(
              key: formKey,
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
                  const Text('Create an account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold
                  ),),
                  const Text('Create your account. it takes less than a minute. Enter your details.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),),
                  const SizedBox(height: 16,),
                  CustomTextfield(
                    icon: const Icon(Icons.person),
                      label: 'Name',
                      textInputType: TextInputType.name,
                    controller: _nameController,
                    obscureText: false,
                    validate: (value){
                     return Validator.nameValidator(value);
                    },
                  ),
                  const SizedBox(height: 16,),
                  CustomTextfield(
                    icon: const Icon(Icons.email),
                    label: 'Email',
                    textInputType: TextInputType.emailAddress,
                    controller: _emailController,
                    obscureText: false,
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
                    return  Validator.passwordValidator(value);
                    },
                  ),
                  const SizedBox(height: 26,),
              ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                      ),
                      minimumSize: Size(MediaQuery.of(context).size.width*0.9, 50)
                  ),
                  child:isLoading? const CircularProgressIndicator(
                    color: Colors.white,
                  ) : const Text('Create an Account', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700
                  ),
                  )
              ),
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Divider(color: Colors.grey, )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text('OR', style: TextStyle(color: Colors.grey),),
                      ),
                      Expanded(
                          child: Divider(color: Colors.grey, )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                      onPressed: signUpWithGoogle,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16, ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),

                      ),

                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.network('https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png',
                          height: 45,
                          width: 45,),
                          SizedBox(width: 35,),
                          _isLoading? CircularProgressIndicator(
                            color: Colors.white,
                          )
                              :Text('Signup With Google', style: TextStyle(
                            fontSize: 16
                          ),)
                        ],
                      )),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Joined us before?', style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                      ),),
                      TextButton(
                          onPressed: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  const LoginScreen()
                                ));
                          },
                          child: const Text('Login', style: TextStyle(
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
          ),)
      ),
    );
  }
}
