import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Services/store.dart';

import 'PasswordVerificationDialog.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final String id;
  final String prefix;
  final bool multiline;
  final bool isUser;
  final bool isusername;
  final bool isPassword;
  final bool edit;

  @override
  ProfileTextField(
      {@required this.controller,
      this.multiline,
      this.isUser,
      this.id,
      this.prefix,
      this.isusername,
      this.edit,
      this.isPassword});

  @override
  State<StatefulWidget> createState() {
    return _ProfileTextField(
        controller: controller,
        multiline: (multiline == null) ? false : multiline,
        isUser: isUser,
        id: id,
        prefix: prefix,
        isusername: (isusername == null) ? false : isusername,
        edit: (this.edit == null) ? false : this.edit,
        isPassword: (this.isPassword == null) ? false : this.isPassword);
  }
}

class _ProfileTextField extends State<ProfileTextField> {
  FocusNode focusNode;
  bool _edit = false;

  final Store _store = Store();

  final TextEditingController controller;
  final String id;
  final String prefix;
  final bool multiline;
  final bool isUser;
  final bool isusername;
  final bool isPassword;
  final bool edit;

  @override
  _ProfileTextField(
      {@required this.controller,
      this.multiline,
      this.isUser,
      this.id,
      this.prefix,
      this.isusername,
      this.edit,
      this.isPassword});

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: edit
            ? SizedBox(
                width: (isusername == false)
                    ? null
                    : (!_edit)
                        ? (controller.text.characters.length * 10.5 + 100)
                        : (controller.text.characters.length * 10.5 + 100) *
                            1.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!isUser)
                      Expanded(
                          flex: 1,
                          child: Icon(
                            Icons.verified,
                            color: KprimaryColorDark,
                          )),
                    (isusername == false)
                        ? Expanded(
                            child: textField(),
                          )
                        : Expanded(
                            flex: 60,
                            child: textFieldF(FontWeight.bold, 20),
                          ),
                    (!_edit)
                        ? IconButton(
                            iconSize: (isusername == false) ? 24 : 18,
                            icon: Icon(Icons.edit),
                            splashColor: KprimaryColorDark,
                            onPressed: () {
                              setState(() {
                                if (!isPassword) {
                                  if (isusername) _edit = !_edit;
                                  FocusScope.of(context)
                                      .requestFocus(focusNode);
                                }
                              });

                              // ignore: unnecessary_statements
                              (isPassword)
                                  ? DialogHelper.exit(context, false)
                                  : (!isusername)
                                      ? DialogHelper.exit(context, true)
                                      // ignore: unnecessary_statements
                                      : null;
                            },
                          )
                        : TextButton(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: (isusername == false)
                                      ? KsecondaryColor
                                      : KprimaryColorDark,
                                  fontWeight: (isusername == false)
                                      ? FontWeight.normal
                                      : FontWeight.bold),
                            ),
                            onPressed: () {
                              (isUser)
                                  ? _store.updateUserName(
                                      controller.text.toString(), id)
                                  : _store.updateProviderName(
                                      controller.text.toString(), id);

                              setState(() {
                                _edit = !_edit;
                              });
                            },
                          ),
                  ],
                ),
              )
            : textField());
  }

  Widget textField() {
    return textFieldF(FontWeight.w500, 17);
  }

  Widget textFieldF(FontWeight fontWeight, double fontSize) {
    return TextFormField(
      cursorColor: KsecondaryColor,
      enabled: _edit,
      controller: controller,
      obscureText: isPassword,
      focusNode: focusNode,
      maxLines: multiline ? 3 : 1,
      minLines: multiline ? 3 : 1,
      style: TextStyle(
          color: KprimaryColorDark, fontSize: fontSize, fontWeight: fontWeight),
      decoration: InputDecoration(
        prefix: Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            (isusername == false) ? "$prefix:" : "",
            style: TextStyle(
              color: KprimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(bottom: 3),
      ),
    );
  }
}
