import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_helper.dart';

class DatabaseService {
  static const name = "DatabaseService";
  static const tbl_user = "tbl_user";
  static const tbl_load = "tbl_load";
  static const tbl_states = "tbl_states";
  static const tbl_truck_model = "tbl_truck_model";
  static const tbl_user_vechils = "tbl_user_vechils";
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> createUser(Map<String, dynamic> user) async {
    return _db.collection(tbl_user).add(user).then((value) {
      _db.collection(tbl_user).doc(value.id).update({"id": value.id});
      return value;
    });
  }

  Future<dynamic> createLoad(Map<String, dynamic> load) async {
    return _db.collection(tbl_load).add(load).then((value) {
      _db.collection(tbl_load).doc(value.id).update({"id": value.id});
      return value;
    });
  }

  Future<dynamic> addVechil(Map<String, dynamic> load) async {
    return _db.collection(tbl_user_vechils).add(load).then((value) {
      _db
          .collection(tbl_user_vechils)
          .doc(value.id)
          .update({"id": value.id, "verified": false});
      return value;
    });
  }

  Future<QuerySnapshot> isMobileExist(String mobile) async {
    return _db
        .collection(tbl_user)
        .where("mobile_nummber", isEqualTo: mobile)
        .get();
  }

  Future<QuerySnapshot> getListwithWhere(
      String tblName, String whereField, String whereValue) async {
    return _db
        .collection(tblName)
        .where(whereField, isEqualTo: whereValue)
        .get();
  }

  Future<void> deleteLoad(String recordId , bool delete) async {
//         .setData(toMap(item), merge: true);

    _db.collection(tbl_load).doc(recordId).update({"deleted": delete});
  }

  Future<QuerySnapshot> getStatesList() async {
    return _db.collection(tbl_states).get();
  }

  Future<QuerySnapshot> getTruckModels() async {
    return _db.collection(tbl_truck_model).get();
  }

  Future<QuerySnapshot> getAccountDetails(String mobile) async {
    return _db
        .collection(tbl_user)
        .where("mobile_nummber", isEqualTo: mobile)
        .get();
  }

  Future<dynamic> getSingleRecord(String collection, String id) async {
    var snap = await _db.collection(collection).doc(id).get();
    appLog(name, "getSingleRecord($collection,$id)", snap.data().toString());
    return snap;
  }
}

// class DatabaseService<T> {
//   final String collection;
  // final FirebaseFirestore _db = FirebaseFirestore.instance;
//   final T Function(String, Map<String, dynamic>) fromDS;
//   final Map<String, dynamic> Function(T) toMap;
//   DatabaseService(this.collection, {this.fromDS, this.toMap});
//   Future<T> getSingle(String id) async {
//     var snap = await _db.collection(collection).document(id).get();
//     if (!snap.exists) return null;
//     return fromDS(snap.documentID, snap.data);
//   }

//   Stream<T> streamSingle(String id) {
//     return _db
//         .collection(collection)
//         .document(id)
//         .snapshots()
//         .map((snap) => fromDS(snap.documentID, snap.data));
//   }

//   Stream<List<T>> streamList() {
//     var ref = _db.collection(collection);
//     return ref.snapshots().map((list) =>
//         list.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//   }

//   Future<List<T>> getQueryList(
//       {List<OrderBy> orderBy,
//       List<QueryArgs> args,
//       int limit,
//       dynamic startAfter}) async {
//     CollectionReference collref = _db.collection(collection);
//     Query ref;
//     if (args != null) {
//       for (QueryArgs arg in args) {
//         if (ref == null)
//           ref = collref.where(arg.key, isEqualTo: arg.value);
//         else
//           ref = ref.where(arg.key, isEqualTo: arg.value);
//       }
//     }
//     if (orderBy != null) {
//       orderBy.forEach((order) {
//         if (ref == null)
//           ref = collref.orderBy(order.field, descending: order.descending);
//         else
//           ref = ref.orderBy(order.field, descending: order.descending);
//       });
//     }
//     if (limit != null) {
//       if (ref == null)
//         ref = collref.limit(limit);
//       else
//         ref = ref.limit(limit);
//     }
//     if (startAfter != null && orderBy != null) {
//       ref = ref.startAfter([startAfter]);
//     }
//     QuerySnapshot query;
//     if (ref != null)
//       query = await ref.getDocuments();
//     else
//       query = await collref.getDocuments();

//     return query.documents
//         .map((doc) => fromDS(doc.documentID, doc.data))
//         .toList();
//   }

//   Stream<List<T>> streamQueryList(
//       {List<OrderBy> orderBy, List<QueryArgs> args}) {
//     CollectionReference collref = _db.collection(collection);
//     Query ref;
//     if (orderBy != null) {
//       orderBy.forEach((order) {
//         if (ref == null)
//           ref = collref.orderBy(order.field, descending: order.descending);
//         else
//           ref = ref.orderBy(order.field, descending: order.descending);
//       });
//     }
//     if (args != null) {
//       for (QueryArgs arg in args) {
//         if (ref == null)
//           ref = collref.where(arg.key, isEqualTo: arg.value);
//         else
//           ref = ref.where(arg.key, isEqualTo: arg.value);
//       }
//     }
//     if (ref != null)
//       return ref.snapshots().map((snap) => snap.documents
//           .map((doc) => fromDS(doc.documentID, doc.data))
//           .toList());
//     else
//       return collref.snapshots().map((snap) => snap.documents
//           .map((doc) => fromDS(doc.documentID, doc.data))
//           .toList());
//   }

//   Future<List<T>> getListFromTo(String field, DateTime from, DateTime to,
//       {List<QueryArgs> args = const []}) async {
//     var ref = _db.collection(collection).orderBy(field);
//     for (QueryArgs arg in args) {
//       ref = ref.where(arg.key, isEqualTo: arg.value);
//     }
//     QuerySnapshot query = await ref.startAt([from]).endAt([to]).getDocuments();
//     return query.documents
//         .map((doc) => fromDS(doc.documentID, doc.data))
//         .toList();
//   }

//   Stream<List<T>> streamListFromTo(String field, DateTime from, DateTime to,
//       {List<QueryArgs> args = const []}) {
//     var ref = _db.collection(collection).orderBy(field, descending: true);
//     for (QueryArgs arg in args) {
//       ref = ref.where(arg.key, isEqualTo: arg.value);
//     }
//     var query = ref.startAfter([to]).endAt([from]).snapshots();
//     return query.map((snap) =>
//         snap.documents.map((doc) => fromDS(doc.documentID, doc.data)).toList());
//   }

//   Future<dynamic> createItem(T item, {String id}) {
//     if (id != null) {
//       return _db.collection(collection).document(id).setData(toMap(item));
//     } else {
//       return _db.collection(collection).add(toMap(item));
//     }
//   }

//   Future<void> updateItem(T item) {
//     return _db
//         .collection(collection)
//         .document(item.id)
//         .setData(toMap(item), merge: true);
//   }

//   Future<void> removeItem(String id) {
//     return _db.collection(collection).document(id).delete();
//   }
// }

// class QueryArgs {
//   final String key;
//   final dynamic value;
//   QueryArgs(this.key, this.value);
// }

// class OrderBy {
//   final String field;
//   final bool descending;
//   OrderBy(this.field, {this.descending = false});
// }
