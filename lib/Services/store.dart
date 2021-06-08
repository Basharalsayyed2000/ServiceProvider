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
      KServicesStatus: service.status,
    });
  }

  Stream<QuerySnapshot> loadService() {
    return _firestore.collection(KServicesCollection).snapshots();
  }

  Future<String> addLocation(AddressModel address) async {
    String locId = "";
    await _firestore.collection(KLocationCollection).add({
      KLocationCountry: address.country,
      KLocationLatitude: address.latitude,
      KLocationlonggitude: address.longgitude,
      KLocationCity: address.city,
      KLocationStreet: address.street
    }).then((value) {
      locId = value.documentID;
    });
    return locId;
  }

  addRequest(RequestModel request) {
    _firestore.collection(KRequestCollection).add({
      KRequestProblem: request.rProblem,
      KRequestDescription: request.rDescription,
      KRequestIsCompleted: request.isComplete,
      KRequestIsActive: request.isActive,
      KRequestIsAccepted: request.isAccepted,
      KRequestIsProviderSeen:request.isProviderSeen,
      KRequestIsPublic:request.isPublic,
      KRequestUserId: request.userId,
      KRequestProviderId: request.providerId,
      KRequestServiceId:request.serviceId,
      KRequestTime: request.requestTime,
      KRequestDate: request.requestDate,
      KRequestAddDate: request.rAddDate,
      KRequestImageUrl: request.rImageUrl,
      KRequestLocationId :request.locationId,
      KRequestActionDate:request.actionDate,
      KRequestRatingComment:"",
      KRequestRating:"",
      KRequestRejectedProvider:[],
      KRequestPublicId:"",
      KRequestId:""  
    }).then((value) {
      String publicId= value.documentID.substring(0,3) +request.rAddDate.substring(0,2)+request.requestTime.substring(14,16);
      _firestore.collection(KRequestCollection).document(value.documentID).updateData({
         KRequestId:value.documentID,
         KRequestPublicId:publicId,
      });
    });
  }

  Stream<QuerySnapshot> loadRequest() {
    return _firestore.collection(KRequestCollection).snapshots();
  }

  searchByName(String searchField) {
    return Firestore.instance
        .collection(KProviderCollection)
        .where('SearchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

  acceptJob(String requestId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsAccepted: true,
      KRequestIsProviderSeen: true,
    });
  }

  rejectJob(String requestId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsAccepted: false,
      KRequestIsProviderSeen: true,
    });
  }

   cancleJob(String requestId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsActive:false
    });
  }
  
  activateJob(String requestId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsActive:true
    });
  }

  endJob(String requestId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsCompleted: true,
    });
  }

  acceptPublicJob(String requestId, String providerId) async {
 
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
     // KRequestIsAccepted: true,
      KRequestIsProviderSeen: true,    
      KRequestProviderId:providerId,
     });

  }

  acceptPublicJobEnable(String requestId, String providerId) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestIsAccepted: true,
      KRequestIsProviderSeen: true,    
      KRequestProviderId:providerId,
      KRequestIsPublic:false
     });

  }
  addRating(String requestId,String ratingComment,int rating) async {
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestRatingComment:ratingComment,
      KRequestRating:rating,
     });

  }
}
