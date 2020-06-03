import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qap_ocorrencias/interfaces/objeto_base_interface.dart';


class ObjetoBase implements IObjetoBaseInterface {
  String id;
  bool isActive = true;
  Timestamp criadoEm;
  Timestamp atualizadoEm;

  ObjetoBase();

  @override
  ObjetoBase.fromMap(DocumentSnapshot document) {
    id = document.documentID;
    isActive = document.data['isActive'];
    criadoEm = document.data['createdAt'];
    atualizadoEm = document.data['updateAt'];
  }

  @override
  void disableDocument() => isActive = false;

  @override
  String documentId() => id;

  @override
  void enableDocument() => isActive = true;

  @override
  void setCreateTime() => criadoEm = Timestamp.now();

  @override
  void setUpdateTime() => atualizadoEm = Timestamp.now();

  @override
  Map toMap() {
    var map = <String, dynamic>{};
    map['isActive'] = isActive;
    map['createdAt'] = criadoEm;
    map['updateAt'] = atualizadoEm;
    return map;
  }
}
