import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  //refensi dari database firebase
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection('groups');

  // Saving  userdata
  Future savingUserData(String fullName, String email) async {
    return await userCollection.doc(uid).set({
      'fullName': fullName,
      'email': email,
      'groups': [],
      'profilePic': "",
      'uid': uid,
    });
  }

  // menggambil user data
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  //Getingg user Groups
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  //Creting a group
  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
    });
    //Update to members
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(["${id}_$userName"]),
      "groupId": groupDocumentReference.id,
    });

    DocumentReference userDocumetRefernce = userCollection.doc(uid);
    return await userDocumetRefernce.update({
      "groups":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }
}
