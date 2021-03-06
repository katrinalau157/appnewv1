import 'package:appnewv1/services/auth.dart';
import 'package:appnewv1/helpers/Constants.dart';
import 'package:flutter/material.dart';
import 'package:appnewv1/screen_B/B_MainPage.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:appnewv1/screen_C/C_Login.dart';
import 'package:appnewv1/helpers/constants_login.dart';
import 'package:appnewv1/helpers/helperfunctions.dart';
import 'package:appnewv1/screen_C/C_profile.dart';
import 'dart:io';
class C_appSetting extends StatefulWidget {
  @override
  _C_appSettingState createState() {
    return _C_appSettingState();
  }
}
String fbIcon;
String username;
class _C_appSettingState extends State<C_appSetting> {
  AuthService authService = new AuthService();
  dynamic _userData;
  bool _visible;
  @override
  void initState() {
    //_checkIfIsLogged();
    getUserInfo();
    getLoggedInState();
    getUserLoggedInFB();
    getUserLoggedInEmail();
    getUserFBIcon();
    super.initState();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    username = Constants.myName;
  }

  bool userIsLoggedIn;
  bool LoggedInwFB;
  bool LoggedInwEmail;



  @override
  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  getUserLoggedInFB() async {
    await HelperFunctions.getUserLoggedInFB().then((value){
      setState(() {
        LoggedInwFB  = value;
      });
    });
  }
  getUserFBIcon() async {
    await HelperFunctions.getUserFBIcon().then((value){
      setState(() {
        fbIcon  = value;
      });
    });
  }
  getUserLoggedInEmail() async {
    await HelperFunctions.getUserLoggedInEmail().then((value){
      setState(() {
        LoggedInwEmail  = value;
      });
    });
  }
  refreshState() {
    // change your state to refresh the screen
  }

//  _checkIfIsLogged() async {
//    final accessToken = await FacebookAuth.instance.isLogged;
//    if (accessToken != null) {
//      FacebookAuth.instance.getUserData().then((userData) {
//        setState(() => _userData = userData);
//      });
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBlueColor,
      body: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0))),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  profile_list(),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                  ),
                  divider_1(),
                  list_smt("店家/公司資料", Icons.business),
                  divider_1(),
                  switch_list("切換成刊登模式 ", Icons.swap_horiz),
                  divider_1(),
                  list_problem("問題回報與申訴 ", Icons.headset_mic),
                  divider_1(),
                  list_smt("合作提案 ", Icons.palette),
                  divider_1(),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  text_grey('   推播設定'),
                  list_smt("系統通知 ", Icons.notifications),
                  divider_1(),
                  list_smt("有新工的時候通知我 ", Icons.chat),
                  divider_1(),
                  list_smt("有人回覆的時候通知我 ", Icons.mail_outline),
                  divider_1(),
                  divider_1(),
                  new Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                  ),
                  text_grey('   其他'),
                  list_smt("好評鼓勵我們  ", Icons.thumb_up),
                  divider_1(),
                  list_smt("相關規範 ", Icons.chrome_reader_mode),
                  divider_1(),
                  btn_login("Logout ", Icons.input),
                ]),
          )),
    );
  }

  Widget profile_list() {
    return (userIsLoggedIn != null && userIsLoggedIn == true)
        ? ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      leading: img_icon_profile(),
      title: Text(username),
      subtitle: Text("My profile"),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () {
//        Navigator.of(context).pushNamed(C_profileTag);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => C_profile()),
        ).then((value) => setState(() => {}));
      },
    )
        : ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30.0),
      leading: img_icon_profile(),
      title: Text("Login"),
      subtitle: Text("My profile"),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () {
        // Navigator.of(context).pushNamed(C_loginTag);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => C_login()),
        ).then((value) => setState(() => {}));
      },
    );
  }

  Widget list_smt(String title, IconData a) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        a,
        color: appGreyColor,
      ),
      title:
      Text(title, style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
      dense: true,
    );
  }

  Widget list_problem(String title, IconData a) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        a,
        color: appGreyColor,
      ),
      title:
      Text(title, style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
      dense: true,
      onTap: (){
        Navigator.of(context).pushNamed(problem_pageTag);
      },
    );
  }

  Widget btn_login(String title, IconData a) {
    return Visibility(
      visible: (userIsLoggedIn != null && userIsLoggedIn == true)
          ? _visible = true
          : _visible = false,
      child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          leading: Icon(
            a,
            color: appGreyColor,
          ),
          title: Text(title,
              style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
          dense: true,
          onTap: () {
            setState(() {
              if ((userIsLoggedIn != null && userIsLoggedIn == true && LoggedInwEmail ==true && LoggedInwFB==false)) {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                AuthService().email_signOut();
                Navigator.pushReplacementNamed(context, C_MainPageTag);
                _visible = false;
              }
           /*   if ((userIsLoggedIn != null && userIsLoggedIn == true && LoggedInwEmail ==false && LoggedInwFB==true)) {
                HelperFunctions.saveUserLoggedInSharedPreference(false);
                AuthService().fb_signOut();
                Navigator.pushReplacementNamed(context, C_MainPageTag);
                _visible = false;
              }*/
            });
          }),
    );
  }

  Widget switch_list(String title, IconData a) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        a,
        color: appGreyColor,
      ),
      title:
      Text(title, style: TextStyle(color: appDeepBlueColor, fontSize: 15)),
      onTap: () {
        gotopage3_B();
        Navigator.pushReplacementNamed(context, B_MainPageTag);
      },
      dense: true,
    );
  }

  Widget img_icon_profile() {
    return CircleAvatar(
      backgroundColor: appBlueColor,
      radius: MediaQuery
          .of(context)
          .size
          .width / 13,
      backgroundImage: (imageFile == null || userIsLoggedIn == false)
          ? AssetImage("assets/images/icons/profile_icon.png")
          : FileImage(File(imageFile.path)),
    );
  }

  Widget divider_1() {
    return Divider(
      height: 1.0,
      thickness: 1,
    );
  }

  Widget text_grey(String txt) {
    return Container(
      width: double.maxFinite,
      //color: Colors.grey[300],
      child: Text(
        txt,
        style: TextStyle(color: appGreyColor),
      ),
    );
  }

  refreshPage() {
    //_checkIfIsLogged();
  }
}