import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'vehicle_model.dart';

class VehicleService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? get user => FirebaseAuth.instance.currentUser;

  CollectionReference get _col =>
      db.collection("usuarios").doc(user!.uid).collection("veiculos");

  Future<String> create(Vehicle v) async {
    DocumentReference doc = await _col.add(v.toMap());
    return doc.id;
  }

  Stream<List<Vehicle>> list() {
    return _col.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vehicle.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future update(Vehicle v) async {
    await _col.doc(v.id).update(v.toMap());
  }

  Future delete(String id) async {
    await _col.doc(id).delete();
  }
}

