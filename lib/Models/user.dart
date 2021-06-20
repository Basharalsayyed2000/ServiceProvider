class UserModel{
  String uName, uImageUrl, uAddDate,uEmail,uPassword,uId,ucountry;
  bool isAdmin,showOnlyProviderInMyCountry;
  List<String> favorateProvider;
  UserModel(
      {this.uName,
      this.uAddDate,
      this.uImageUrl,
      this.isAdmin,
      this.uEmail,
      this.uPassword,
      this.uId,
      this.favorateProvider,
      this.showOnlyProviderInMyCountry,
      this.ucountry
      }
      );
}
