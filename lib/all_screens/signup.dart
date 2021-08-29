import 'package:flutter/material.dart';
import 'package:logindemo/HomePage.dart';
import 'package:logindemo/helper/helper_functions.dart';
import 'package:logindemo/widgets/widget.dart';
import 'package:logindemo/services/auth.dart';

class SignUp extends StatefulWidget {  
  final Function toggle;
  SignUp (this.toggle);  
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   
   bool isLoading =false;
    AuthMethods authMethods= new AuthMethods();
    final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController=new TextEditingController();
  TextEditingController emailTextEditingController=new TextEditingController();
  TextEditingController passwordTextEditingController=new TextEditingController();

  signMeUp() {
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": userNameTextEditingController.text,
        "email": emailTextEditingController.text,
      };
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);
      setState(() {
        isLoading=true;
      });
      authMethods.signUpWithEmailAndPassword(emailTextEditingController.text, 
      passwordTextEditingController.text).then((val){
         print("$val");
      HelperFunctions.saveUserLoggedInSharedPreference(true); 
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context)=>HomePage()         
      ));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading?Container(
        child: Center(child: CircularProgressIndicator()),
      ):SingleChildScrollView(        
        child: Container(
          height: MediaQuery.of(context).size.height-50,
          alignment: Alignment.bottomCenter,
          child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(          
           // mainAxisSize: MainAxisSize.min,
            children: [              
              Form(
                key: formKey,
                child: Column(
                  children: [
                SizedBox(height:150),
                Center(
                  child: Container(
                    child: Image.asset("asset/images/logo.JPG"),
                  ),
                ),
                SizedBox(height:80),                    
                    TextFormField(
                      validator: (val) 
                        {
                        return val.isEmpty || val.length < 2 || val.length>11
                        ? "Please provide a valid username\n (Min 2 characters and max 11 characters)"
                        : null;
                        },
                  controller: userNameTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("usename")          
                ),

                   TextFormField(
                    validator: (val) {
                      return RegExp(
                       r"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$")
                       .hasMatch(val)
                       ? null
                       : "Please provide a valid email-id";
                                    },                  
                  controller: emailTextEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("email")
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
                  ],
                ),
              ),             
            SizedBox(height: 8,),            
            GestureDetector(
              onTap: (){
                signMeUp();
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
                child: Text("Sign Up", style: mediumTextStyle()),
              ),
            ),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [              
                Text("Already have account ", style: mediumTextStyle(),),
                GestureDetector(
                  onTap: (){
                    widget.toggle();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text("SignIn Now", style: TextStyle(color: Colors.white,
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
    );
  }
}