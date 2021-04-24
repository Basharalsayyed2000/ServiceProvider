class Provider{
String pName, pImageUrl, pAddDate, pbirthDate, pphoneNumber,pProvideService,pProviderDescription,pEmail,pPassword,pId;
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
      this.pProviderDescription,
      this.pEmail,
      this.pPassword,
      this.pId
      });
}