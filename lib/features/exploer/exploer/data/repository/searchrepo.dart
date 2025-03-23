import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../register/data/models/UserModel.dart';

class SearchRepo {
  final FirebaseFirestore firestore;

  SearchRepo({required this.firestore});

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final querySnapshotUsername = await firestore
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: query +'\uf8ff') // Adjust query range for case-insensitive search
          .get();

      final querySnapshotEmail = await firestore
          .collection('users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: query + '\uf8ff') // Same adjustment for email
          .get();

      final allUsers = <UserModel>[];

      // Map the username results
      querySnapshotUsername.docs.forEach((doc) {
        allUsers.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Map the email results
      querySnapshotEmail.docs.forEach((doc) {
        allUsers.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Remove duplicates (if any user appears in both username and email results)
      final uniqueUsers = allUsers.toSet().toList();

      if (uniqueUsers.isEmpty) {
        throw Exception("No users found");
      }

      return uniqueUsers;
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }




}

