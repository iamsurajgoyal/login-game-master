import 'package:flutter/material.dart';
import 'package:logindemo/HomePage.dart';
import 'package:logindemo/helper/helper_functions.dart';
import 'package:logindemo/services/auth.dart';
import 'package:logindemo/widgets/widget.dart';
class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn (this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final formKey = GlobalKey<FormState>();
  AuthMethods authMethods=new AuthMethods();
  TextEditingController userEmailTextEditingController=new TextEditingController();
  TextEditingController passwordTextEditingController=new TextEditingController(); 
  bool isLoading =false;

  signIn()
  {       
    if(formKey.currentState.validate())
    {
      HelperFunctions.saveUserEmailSharedPreference(userEmailTextEditingController.text);   
       setState(() {
         isLoading=true;
       });
      authMethods.signInWithEmailAndPassword
      (userEmailTextEditingController.text, passwordTextEditingController.text).then((val){
               if (val!=null)
               {        
                HelperFunctions.saveUserLoggedInSharedPreference(true);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
               }
               else 
               {
                 return  Container (child: Text("User not found",),);
               }
      });

    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading==true?Container(child: Center(child: CircularProgressIndicator()),):SingleChildScrollView(        
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(          
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height:150),
                Center(
                  child: Container(
                    child: Image.asset("asset/images/logo.JPG"),
                  ),
                ),
                SizedBox(height:80),
                TextFormField(
                      validator: (val) {
                        return RegExp(
                                    r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
                                .hasMatch(val)
                            ? null
                            : "Please provide a valid email-id";
                      },              
                      controller: userEmailTextEditingController,                       
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("email"),
                            
                ),
                TextFormField(
                  obscureText: true,
                    validator: (val) {
                    return val.length <3 || val.length>11
                    ? "Please provide a 3 to ll length character password"
                    : null;
                    },   
                    controller: passwordTextEditingController,               
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("password")
                ), 
              SizedBox(height: 8,),
              Container(
                alignment: Alignment.centerRight,
                child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8 ),
                child: Text("Forgot Password?", style: simpleTextStyle(),),
              ),          
              ),
              SizedBox(height: 8,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0Xff007EF4),
                        const Color(0Xff2A75BC)
                      ]
                    ),
                   borderRadius:BorderRadius.circular(30),   
                  ),            
                  child: Text("Sign In", style: mediumTextStyle()),
                ),
              ),
              SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [              
                  Text("Don't have account ", style: mediumTextStyle(),),
                  GestureDetector(
                    onTap: (){
                         widget.toggle();
                    },           
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical:8),
                      child: Text("Register Now", style: TextStyle(color: Colors.white,
                       fontSize: 17,  decoration: TextDecoration.underline
                        )),
                    ),
                  )
                ],
              ) ,
              SizedBox(height: 50,),        
              ],
            ),
          ),
        ),
        ),
      )
    );
  }
}