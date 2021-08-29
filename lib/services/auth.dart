import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:logindemo/modal/user.dart';


class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  UseR _userFromFirebaseUser(FirebaseUser user ){
    return user!=null? UseR(userId: user.uid):null;
  }

Future signInWithEmailAndPassword(String email, String password)
async{
    try{
     AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=result.user;
     return _userFromFirebaseUser(firebaseUser);
    }
    catch(e)
    {
        print(e.toString());
    }
  }

Future signUpWithEmailAndPassword(String email, String password)
async{
    try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser firebaseUser=result.user;
     return _userFromFirebaseUser(firebaseUser);
    }
    catch(e)
    {
        print(e.toString());
    }
  }

Future resetPass(String email) async{
  try{
   return await _auth.sendPasswordResetEmail(email: email);
  }
  catch(e){
   print(e.toString());
  }
}

Future signOut() async{
  try{
   return await _auth.signOut();
  }
  catch(e)
  {
    print(e.toString());
  }
}
}