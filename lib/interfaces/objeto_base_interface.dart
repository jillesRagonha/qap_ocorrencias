import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IObjetoBaseInterface{

  String documentId();
  Map toMap();
  IObjetoBaseInterface();
  IObjetoBaseInterface.fromMap(DocumentSnapshot documentSnapshot);
  void disableDocument();
  void enableDocument();
  void setCreateTime();
  void setUpdateTime();
}