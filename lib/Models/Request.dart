class RequestModel{
String providerId,  rAddDate, userId,rDescription,requestDate,requestTime,requestId,rProblem,locationId,serviceId,actionDate,publicId;
bool isActive,isComplete,isAccepted,isProviderSeen,isPublic;
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
      this.isPublic,
      this.actionDate,
      this.publicId
      });
}