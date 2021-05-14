import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/provider.dart';

class NeededData{
  ProviderModel provider;
  bool isActive;
  String pageType;
  RequestModel requestModel;

  NeededData({
    this.provider,
    this.isActive,
    this.pageType,
    this.requestModel
  });
}