class RequestModel{
String providerId,  rAddDate, userId,rDescription,requestDate,requestTime,requestId,rProblem,locationId;
bool isActive,isComplete,isAccepted,isProviderSeen;
List<String> rImageUrl;
RequestModel(
      {this.rDescription,
      this.providerId,
      this.userId,
      this.rAddDate,
      this.requestDate,
      this.requestTime,
      this.isAccepted,
      this.isActive,
      this.isComplete,
      this.locationId,
      this.rImageUrl,
      this.requestId,
      this.rProblem,
      this.isProviderSeen
      });
}