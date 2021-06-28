import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  Future<QuerySnapshot> searchByname(String searchField) {
    return FirebaseFirestore.instance
        .collection("downFiles")
        .where("SearchFeild",
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
