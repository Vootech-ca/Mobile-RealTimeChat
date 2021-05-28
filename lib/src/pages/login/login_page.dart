import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vootech_realchat/core/app_assets.dart';
import 'package:vootech_realchat/core/app_colors.dart';
import 'package:vootech_realchat/src/bloc/blocs/login_bloc.dart';
import 'package:vootech_realchat/src/bloc/events/login_event.dart';
import 'package:vootech_realchat/src/bloc/states/login_state.dart';
import 'package:vootech_realchat/src/di/get_it_service_locator.dart';
import 'package:vootech_realchat/src/pages/home/home_page.dart';
import 'package:vootech_realchat/src/utils/local_storage_service.dart';
import 'package:vootech_realchat/src/widgets/busy_indicator.dart';
import 'package:vootech_realchat/src/widgets/button/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _loginFormKey = GlobalKey<FormState>();
  var _txtUserNameController = TextEditingController();
  var _txtPasswordController = TextEditingController();
  LoginBloc _loginBloc;
  LocalStorageService _storageService;
  bool _isBusy = false;

  @override
  void initState() {
    _loginBloc = getIt<LoginBloc>();
    super.initState();
    _fetchInitData();
  }

  _fetchInitData() async {
    try {
      _storageService = await LocalStorageService.getInstance();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _loginBloc.close();
    _txtUserNameController.dispose();
    _txtPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      key: _scaffoldKey,
      child: Scaffold(
        body: BlocListener(
          bloc: _loginBloc,
          listener: (BuildContext context, LoginState state) {
            setState(() {
              _isBusy = state is LoginLoading;
            });

            if (state is LoginSuccess) {
              _storageService.accessToken = state.result.token;
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
            }

            if(state is LoginError){
              Fluttertoast.showToast(msg: "Error occurred", backgroundColor: Colors.white, textColor: AppColors.errorColor);
            }
          },
          child: Form(
            key: _loginFormKey,
            child: BlocBuilder(
              bloc: _loginBloc,
              builder: (BuildContext context, LoginState state) {
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height / 4,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(AppAssets.loginIcon),
                      ),
                      Text("Welcome", textAlign: TextAlign.center, style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                      SizedBox(height: 32),
                      Text("Sing in to continue", textAlign: TextAlign.center, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.hintFontColor)),
                      SizedBox(height: 90),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextFormField(
                          controller: _txtUserNameController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(Icons.perm_identity, color: AppColors.primaryColor),
                            counterText: "",
                            border: const OutlineInputBorder(borderSide: const BorderSide(color: AppColors.hintFontColor, width: 1.0), borderRadius: BorderRadius.all(Radius.circular(20.0))),
                            labelText: 'UserName/Email',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: TextFormField(
                          controller: _txtPasswordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outlined, color: AppColors.primaryColor),
                            contentPadding: EdgeInsets.all(8),
                            counterText: "",
                            border: const OutlineInputBorder(
                              borderSide: const BorderSide(color: AppColors.hintFontColor, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                            ),
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Username is required";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: PrimaryButton(
                          title: "Sign in",
                          height: 48,
                          child: _isBusy ? BusyIndicator() : null,
                          onPressed: () {
                            if (_loginFormKey.currentState.validate() && !_isBusy) {
                              var username = _txtUserNameController.text;
                              var password = _txtPasswordController.text;
                              _loginBloc.add(Login(username, password));
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                        child: Center(
                          child: RichText(
                            text: TextSpan(children: <TextSpan>[TextSpan(text: 'Forgot Password?', style: TextStyle(color: AppColors.errorColor, fontSize: 14))]),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
