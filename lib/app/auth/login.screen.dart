part of '../../app.dart';

class LoginScreen extends StatelessWidget {
  static final routeName = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final route = Provider.of<RouteFunction>(context, listen: false);
    final routeParams = route.getParams(context);
    final state = Provider.of<LoginController>(context);
    final dispatch = Provider.of<LoginController>(context, listen: false);
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          Container(
            color: primaryColor,
          ),
          SafeArea(
            child: Container(color: secondaryColor),
          ),
          ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(defaultMargin * 2.5),
                    child: Image.asset("assets/images/login.png"),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding:
                        EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
                    width: SizeConfig.screenWidth,
                    child: TextField(
                      onSubmitted: (value) {},
                      style: textFontFS.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w400),
                      onChanged: (value) =>
                          dispatch.setEmailController(value),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelText: "Input Email / Nomor telepon",
                         labelStyle: textFontFS.copyWith(color: primaryColor),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input Email / Nomor telepon",
                        hintStyle: textFontFS.copyWith(color: Colors.grey),
                        // border: InputBorder.none,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    padding:
                        EdgeInsets.only(left: 20, top: 5, bottom: 5, right: 10),
                    // width: SizeConfig.screenWidth,

                    child: TextField(
                      obscureText: !state._showPassword,
                      onSubmitted: (value) {},
                      style: textFontFS.copyWith(
                          color: primaryColor, fontWeight: FontWeight.w400),
                      onChanged: (value) =>
                          dispatch.setPasswordController(value),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: dispatch.showPassword,
                          child: Icon(
                            state._showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                          ),
                        ),
                        fillColor: Colors.white,
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: primaryColor)),
                        labelStyle: textFontFS.copyWith(color: primaryColor),
                        labelText: "Password",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "Input Password",
                        hintStyle: textFontFS.copyWith(color: Colors.grey),
                      ),
                    ),
                  ),
                  // Spacer(),
                  SizedBox(
                    height: defaultMargin * 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an Account?"),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: () =>
                              route.navigateTo(RegisterScreen.routeName),
                          child: Text(
                            "Sign Up",
                            style: textFontFS.copyWith(
                                fontWeight: FontWeight.w700,
                                color: primaryColor),
                          ))
                    ],
                  ),
                  // Spacer()
                  SizedBox(
                    height: defaultMargin,
                  ),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: defaultMargin / 2),
                      width: SizeConfig.screenWidth * 0.8,
                      height: defaultMargin * 1.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(defaultMargin),
                        child: RaisedButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            color: primaryColor,
                            onPressed: () {},
                            child: Text("LOGIN",
                                style: textFontFS.copyWith(
                                    letterSpacing: defaultMargin * 0.2))),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: textFontFS.copyWith(
                            fontWeight: FontWeight.w700, color: primaryColor),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
