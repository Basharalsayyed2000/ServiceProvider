import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  updateListGallery(List gallery, String pid){
    _firestore.collection(KProviderCollection).document(pid).updateData({
      KImageCartificateUrlList: gallery,
    });
  }

  List cache = [];
  Future uploadGalleryImage(Map<bool,List>gallery, List galleryUrl) async {
    if(gallery[false].isNotEmpty)
      for (var img in gallery[false]) {

        if(!cache.contains(img)){
          print(img.path);

          cache.add(img);

          FirebaseStorage storage = FirebaseStorage(storageBucket: 'gs://service-provider-ef677.appspot.com');

          String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();

          StorageReference ref = storage.ref().child('CertificateImage/$imageFileName');

          StorageUploadTask storageUploadTask = ref.putFile(img);
          
          
          StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

          await taskSnapshot.ref.getDownloadURL().then((url) {
            galleryUrl.add(url);
            cache.removeAt(0);
          });
        }

        //_userStore.addGallaryCollection(url, docId);


      }
  }

  addRequest(RequestModel request) {
    _firestore.collection(KRequestCollection).add({
      KRequestProblem: request.rProblem,
      KRequestDescription: request.rDescription,
      KRequestIsCompleted: request.isComplete,
      KRequestIsActive: request.isActive,
      KRequestIsAccepted: request.isAccepted,
      KRequestIsProviderSeen:request.isProviderSeen,
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
      KRequestRating:0,
      KRequestPublicId:"",
      KRequestId:"",
      KReqeustProviderRecommendedTime:"",  
    }).then((value) {
      String publicId= value.documentID.substring(0,3) +request.locationId.substring(0,2)+request.requestTime.substring(14,16);
      _firestore.collection(KRequestCollection).document(value.documentID).updateData({
         KRequestId:value.documentID,
         KRequestPublicId:publicId,
      });
    });
  }

  Stream<QuerySnapshot> loadRequest() {
    return _firestore.collection(KRequestCollection).snapshots();
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


  addRating(String requestId,String ratingComment,int rating) async {
    
    await _firestore
        .collection(KRequestCollection)
        .document(requestId)
        .updateData({
      KRequestRatingComment:ratingComment,
      KRequestRating:rating,
     });

  }

   changeProvider(String pId,String rid) async {
     await _firestore
        .collection(KRequestCollection)
        .document(rid)
        .updateData({
      KRequestProviderId:pId,
      KRequestIsProviderSeen:false,
     });
  }

  
}
