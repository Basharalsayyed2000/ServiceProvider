class Provider{
String pName, pImageUrl, pAddDate, pbirthDate, pphoneNumber,pProvideService,pProviderDescription;
bool isAdmin;
List<String> pAddress;
Provider(
      {this.pName,
      this.pAddDate,
      this.pImageUrl,
      this.pphoneNumber,
      this.pbirthDate,
      this.isAdmin,
      this.pAddress,
      this.pProvideService,
      this.pProviderDescription
      });
}