import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_record/model/symplemodel/dayModel.dart';
import 'package:weight_record/objects/record.dart';

final firestoreDataModelProvider =
    StateNotifierProvider<DataModelState, Datamodel>((ref) => DataModelState());

class DataModel {
  DataModel({required this.newHeight});

  String newHeight;
}

class DataModelState extends StateNotifier<DataModel> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Map<DateTime, double> gotDateAndWeight = {};
  final _dayModel = DayModel();
  QueryDocumentSnapshot? lastVisible;
  bool hintTheBottom = false;

  DataModelState() : super(DataModel(newHeight: ''));

  Future<List<Record>> getDateAndWeight() async {
    final _email = auth.currentUser!.email;
    List<Record> recordList = [];

    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('date');

    QuerySnapshot _collection = await _collectionRef.get();

    if (_collection.docs.isEmpty) {
      print('first get nothing');
      hintTheBottom = true;
      return recordList;
    }
    lastVisible = _collection.docs[_collection.docs.length - 1];
    recordList = _collection.docs.map((doc) => Record(doc)).toList();
    return recordList;
  }

  Future<String> maxWeight() async {
    String _weight;
    List<dynamic> _weigthList = [];
    final _email = auth.currentUser!.email;
    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('weight');

    final _collection = await _collectionRef.get();
    _weigthList = _collection.docs.map((e) => e.data()['weight']).toList();

    _weight = _weigthList[0];
    return _weight;
  }

  Future<void> getHeightData() async {
    final _email = auth.currentUser!.email;
    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('date');

    final _doc = await _collectionRef.get();
    final _data = _doc.docs.map((e) => e.data()['height']).toList();
    state = DataModel(newHeight: _data[0]);
  }
}
