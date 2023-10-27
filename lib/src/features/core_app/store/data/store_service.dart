// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class StoreService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String userId = '';
//   String ref = 'stores';

//   addNewStoreToFirebase() async {
//     SharedPreferences access = await SharedPreferences.getInstance();
//     userId = access.getString('uid') ?? '';

//     // DocumentReference userDetails =
//     //      _firestore.collection('user').doc(userId);
//     // print(userDetails);
//   }
// }
