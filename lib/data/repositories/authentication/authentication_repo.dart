// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
// import 'package:furniture_store/features/authentication/screens/login/login_screen.dart';
// import 'package:furniture_store/features/authentication/screens/sign_up/verify_sign_up_email.dart';
// import 'package:furniture_store/features/home/screens/home_screen.dart';
// import 'package:furniture_store/features/onboarding/screens/onboarding_screen.dart';
// import 'package:furniture_store/utils/exceptions/firebase_auth_exceptions.dart';
// import 'package:furniture_store/utils/exceptions/firebase_exceptions.dart';
// import 'package:furniture_store/utils/exceptions/format_exceptions.dart';
// import 'package:furniture_store/utils/exceptions/platform_exceptions.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthenticatorRepo extends GetxController {
//   static AuthenticatorRepo get instance => Get.find();

//   final deviceStorage = GetStorage();
//   final _auth = FirebaseAuth.instance;

//   @override
//   void onReady() {
//     FlutterNativeSplash.remove();
//     screenRedirect();
//   }

//   screenRedirect() async {
//     final user = _auth.currentUser;
//     if (user != null) {
//       if (user.emailVerified) {
//         Get.offAll(
//           () => const NavMenu(),
//           duration: const Duration(milliseconds: 300),
//           transition: Transition.fade,
//         );
//       } else {
//         Get.offAll(
//           () => VerifySignUpEmail(
//             email: _auth.currentUser?.email,
//           ),
//           duration: const Duration(milliseconds: 300),
//           transition: Transition.fade,
//         );
//       }
//     } else {
//       deviceStorage.writeIfNull('isFirstTime', true);
//       deviceStorage.read('isFirstTime') != true
//           ? Get.offAll(
//               () => const LoginSignUpScreen(),
//               duration: const Duration(milliseconds: 300),
//               transition: Transition.fade,
//             )
//           : Get.offAll(
//               () => const OnBoardingScreen(),
//               duration: const Duration(milliseconds: 300),
//               transition: Transition.fade,
//             );
//     }
//   }

//   /// Email login
//   Future<UserCredential> loginWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       return await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }
//   }

//   /// Email registeration
//   Future<UserCredential> registerWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       return await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }
//   }

//   Future<void> sendEmailVerification() async {
//     try {
//       await _auth.currentUser?.sendEmailVerification();
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }
//   }

//   Future<void> sendPasswordResetEmail(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }   } on PlatformException catch (e) {
//  
//   }

//   Future<UserCredential> signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await userAccount?.authentication;

//       final cred = GoogleAuthProvider.credential(
//           accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

//       return await _auth.signInWithCredential(cred);
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await GoogleSignIn().signOut();
//       await FirebaseAuth.instance.signOut();
//       Get.offAll(
//         () => const LoginSignUpScreen(),
//         duration: const Duration(milliseconds: 300),
//         transition: Transition.upToDown,
//       );
//     } on FirebaseAuthException catch (e) {
//       throw TFirebaseAuthException(e.code).message;
//     } on FirebaseException catch (e) {
//       throw TFirebaseException(e.code).message;
//     } on FormatException catch (_) {
//       throw const TFormatException();
//     } on PlatformException catch (e) {
//       throw TPlatformException(e.code).message;
//     } catch (e) {
//       throw 'Something went wrong, Please try again';
//     }
//   }
// }
