class ProviderModel{
String pName, pAddDate,pImageUrl, pbirthDate, pphoneNumber,pProvideService,pProviderDescription,pEmail,pPassword,pId,locationId;
double rate;
bool isAdmin;
List<String> certificateImages,myFavorateList;
ProviderModel(
      {
      this.pName,
      this.pAddDate,
      this.pImageUrl,
      this.pphoneNumber,
      this.pbirthDate,
      this.isAdmin,
      this.pProvideService,
      this.pProviderDescription,
      this.pEmail,
      this.pPassword,
      this.pId,
      this.locationId,
      this.certificateImages,
      this.myFavorateList,
      this.rate
      });
}