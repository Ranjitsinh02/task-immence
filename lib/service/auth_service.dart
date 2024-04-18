import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practical_task/model/user_model.dart';
import 'package:practical_task/service/sharepreference_service.dart';
import 'package:practical_task/utils/app_strings.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> loginUser(String emailId, String password) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
        email: emailId,
        password: password,
      );

      SharedPreferencesService.saveData(AppStrings.userId, response.user?.uid);
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(response.user?.uid)
          .get();

      print("userSnapshot:::${userSnapshot.exists}");

      return userSnapshot.exists;
    } catch (e) {
      print(e);
    }
    return false;
  }

  /// create user
  Future<bool> signUpUser(
    String name,
    String email,
    String phoneNumber,
    String password,
    bool isRemember,
  ) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Add user data to Firestore
        SharedPreferencesService.saveData(AppStrings.userId, userCredential.user!.uid);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          "id":userCredential.user!.uid,
          "name": name,
          "email": email,
          "phone_number": phoneNumber,
          "password": password,
          "isRemember": isRemember
          // Add other user data fields as needed
        });
        return true;
      }

    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<List<UserModel>> fetchUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<UserModel> userList = [];
      querySnapshot.docs.forEach((doc) {

        UserModel datamodel =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);
        userList.add(datamodel);
      });
      return userList;
    } catch (e) {
      print("Error fetching users: $e");
    }
    return [];
  }

  Future<UserModel> fetchUserDetails() async {
    final userId = SharedPreferencesService.getData(AppStrings.userId);

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      UserModel userModel = UserModel.fromJson(userSnapshot as Map<String, dynamic>);

      return userModel;
    } catch (e) {
      print("Error fetching users: $e");
    }
    return UserModel();
  }

  ///signOutUser
  Future<void> signOutUser() async {
    final User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
      SharedPreferencesService.clearData();
    }
  }
}
