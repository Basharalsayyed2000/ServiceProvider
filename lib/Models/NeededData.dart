import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/provider.dart';

class NeededData{
  ProviderModel provider;
  bool isRequestActive,isRequestPublic,forUser;
  String pageType,serviceRequestId;
  RequestModel requestModel;

  NeededData({
    this.provider,
    this.isRequestActive,
    this.pageType,
    this.requestModel,
    this.isRequestPublic,
    this.forUser,
    this.serviceRequestId
  });
}