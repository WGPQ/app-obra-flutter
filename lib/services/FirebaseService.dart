import 'package:app_obra_flutter/model/obra.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ObraService {
  final Firestore _db = Firestore.instance;
  ValueNotifier<List<Obra>> obras = ValueNotifier(null);

  getAll() async {
    final snapshot = await _db.collection('tblObra').getDocuments();
    obras.value = snapshot.documents.map((item) => Obra.formMap(item)).toList();
  }
}
