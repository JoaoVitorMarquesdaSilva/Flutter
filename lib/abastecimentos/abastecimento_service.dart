import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'abastecimento_model.dart';

class AbastecimentoService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  User? get user => FirebaseAuth.instance.currentUser;

  CollectionReference _col(String veiculoId) {
    return db
        .collection("usuarios")
        .doc(user!.uid)
        .collection("veiculos")
        .doc(veiculoId)
        .collection("abastecimentos");
  }

  Future<String> create(Abastecimento a) async {
    DocumentReference doc = await _col(a.veiculoId).add(a.toMap());
    return doc.id;
  }

  Stream<List<Abastecimento>> list(String veiculoId) {
    return _col(veiculoId).snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return Abastecimento.fromMap(
            doc.id,
            doc.data() as Map<String, dynamic>,
          );
        }).toList();
      },
    );
  }

  Future update(Abastecimento a) async {
    await _col(a.veiculoId).doc(a.id).update(a.toMap());
  }

  Future delete(String veiculoId, String id) async {
    await _col(veiculoId).doc(id).delete();
  }
}
