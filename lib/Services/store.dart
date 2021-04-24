import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/MyTools/Constant.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addservice(Service service) {
    _firestore.collection(KServicesCollection).add({
      KServiceName: service.sName,
      KServiceDesc: service.sDesc,
      KServiceAddDate: service.sAddDate,
      KServicesImageUrl: service.sImageUrl,
      KServicesStatus:service.status,
    });
  }
  Stream<QuerySnapshot> loadService(){
     return _firestore.collection(KServicesCollection).snapshots();
  }
}
