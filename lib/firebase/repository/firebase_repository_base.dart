
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qap_ocorrencias/firebase/interface/firebase_repository_base_interface.dart';
import 'package:qap_ocorrencias/models/objeto_base.dart';

class FirebaseRepositoyBase<Objeto extends ObjetoBase>
    implements IFirebaseRepositoryBaseInterface<Objeto> {

      
  final Objeto Function(DocumentSnapshot document) fromMap;

  String collection;

  CollectionReference collectionReference;

  FirebaseRepositoyBase({this.fromMap, this.collection}) {
    collection ?? "${Objeto.toString().toLowerCase()}s";
    collectionReference = Firestore.instance.collection(collection);
  }


  @override
  Future<String> add(Objeto model) async {
    model.setCreateTime();
    model.setUpdateTime();
    var collection = collectionReference;
    var document = await collection.add(model.toMap());
    return document.documentID;
  }

  @override
  Future<void> update(Objeto model) async {
    model.setUpdateTime();
    var collection = collectionReference;
    await collection.document(model.documentId()).updateData(model.toMap());
  }

  @override
  Future<void> disable(Objeto model) async {
    model.disableDocument();
    update(model);
  }

  @override
  Future<void> enable(Objeto model) async {
    model.enableDocument();
    update(model);
  }

  @override
  Future<void> delete(String documentId) async {
    var collection = collectionReference;
    await collection.document(documentId).delete();
  }

  @override
  Future<Objeto> getById(String documentId) async {
    var collection = collectionReference;
    var snapshot = await collection.document(documentId).get();
    return fromMap(snapshot);
  }

  @override
  Future<List<Objeto>> getAll() async {
    var collection = collectionReference;
    List<Objeto> list = [];
    var querySnapshot = await collection.getDocuments();
    await querySnapshot.documents.forEach((element) {
      list.add(fromMap(element));
    });

    return await list;
  }

  @override
  CollectionReference filter() {
    return collectionReference;
  }

  @override
  List<Objeto> fromSnapshotToModelList(List<DocumentSnapshot> documentList) {
    List<Objeto> list = [];
    documentList.forEach((element) {
      list.add(fromMap(element));
    });
    return list;
  }
}