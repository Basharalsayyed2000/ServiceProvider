class UserModel{
  String uName, uImageUrl, uAddDate, ubirthDate, uphoneNumber,uEmail,uPassword,uId;
  bool isAdmin;
  List<String> favorateProvider;
  UserModel(
      {this.uName,
      this.uAddDate,
      this.uImageUrl,
      this.uphoneNumber,
      this.ubirthDate,
      this.isAdmin,
      this.uEmail,
      this.uPassword,
      this.uId,
      this.favorateProvider
      }
      );
}
