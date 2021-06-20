import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel{
String providerId, userId,rDescription,requestDate,requestTime,requestId,rProblem,locationId,serviceId,publicId,commentRating,providerRecommendedTime;
double rating;
Timestamp rAddDate,actionDate;
bool isActive,isComplete,isAccepted,isProviderSeen;
List<String> rImageUrl;
RequestModel(
      {this.rDescription,
      this.requestId,
       this.rAddDate,
      this.rImageUrl,
      this.requestDate,
      this.requestTime,
      this.isComplete,
      this.isAccepted,
      this.isActive,
      this.isProviderSeen,
      this.providerId,
      this.userId,
      this.locationId,
      this.rProblem,
      this.serviceId,
      this.actionDate,
      this.publicId,
      this.commentRating,
      this.rating,
      this.providerRecommendedTime
      });
}