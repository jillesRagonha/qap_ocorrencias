import 'package:cloud_firestore/cloud_firestore.dart';
import '../../interfaces/objeto_base_interface.dart';

abstract class IFirebaseRepositoryBaseInterface<Objeto extends IObjetoBaseInterface> {

  Future<String> add(Objeto model);

  Future<void> update(Objeto model);

  Future<void> disable(Objeto model);

  Future<void> enable(Objeto model);

  Future<void> delete(String documentId);

  Future<Objeto> getById(String documentId);

  Future<List<Objeto>> getAll();

  CollectionReference filter();

  List<Objeto> fromSnapshotToModelList(List<DocumentSnapshot> documentList);
}
