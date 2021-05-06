import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/MyTools/Constant.dart';

class Store {
  final Firestore _firestore = Firestore.instance;

  addservice(ServiceModel service) {
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



    Future<String> addLocation(AddressModel _address) async{
       String id="";
     await _firestore.collection(KLocationCollection).add({
      KLocationCountry: _address.country,
      KLocationPostalCode: _address.postalCode,
      KLocationCity: _address.city,
      KLocationStreet: _address.street,
      KLocationLatitude: _address.latitude,
      KLocationlonggitude: _address.longgitude,
    }).then((value) {
     id=value.documentID;
    });
    return id;
  }

  addRequest(RequestModel request) {
    _firestore.collection(KRequestCollection).add({
      KRequestProblem: request.rProblem,
      KRequestDescription: request.rDescription,
      KRequestIsCompleted: request.isComplete,
      KRequestIsActive: request.isActive,
      KRequestIsAccepted:request.isAccepted,
      KRequestUserId: request.userId,
      KRequestProviderId: request.providerId,
      KRequestTime: request.requestTime,
      KRequestDate: request.requestDate,
      KRequestAddDate:request.rAddDate,
      KRequestImageUrl:request.rImageUrl
    });
  }

  Stream<QuerySnapshot> loadRequest(){
     return _firestore.collection(KRequestCollection).snapshots();
  }
}
