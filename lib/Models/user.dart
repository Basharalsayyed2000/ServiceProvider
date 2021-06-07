class UserModel{
  String uName, uImageUrl, uAddDate,uEmail,uPassword,uId;
  bool isAdmin,enableAcceptPublicRequest;
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
      this.enableAcceptPublicRequest
      }
      );
}
