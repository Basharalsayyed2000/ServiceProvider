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


    Future<String> addLocation(AddressModel address) async {
      String locId="";
    await _firestore.collection(KLocationCollection).add({
      KLocationCountry: address.country,
      KLocationPostalCode: address.postalCode,
      KLocationLatitude:address.latitude,
      KLocationlonggitude:address.longgitude,
      KLocationCity:address.city,
      KLocationStreet:address.street
    }).then((value) {
      locId=value.documentID;
    });
    return locId;
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
   
     updateRequest(RequestModel request,String requestId) async {
    await _firestore.collection(KRequestCollection).document(requestId).updateData({
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
      KRequestImageUrl:request.rImageUrl,
      KRequestIsProviderSeen:request.isProviderSeen
    });
  }
   

  Stream<QuerySnapshot> loadRequest(){
     return _firestore.collection(KRequestCollection).snapshots();
  }

   searchByName(String searchField) {
    return Firestore.instance
        .collection(KProviderCollection)
        .where('SearchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
