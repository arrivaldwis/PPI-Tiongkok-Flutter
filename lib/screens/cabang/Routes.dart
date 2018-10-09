import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
// import '../cabang/cabangDetailPage.dart';

class Routes {
  static final Router _router = new Router();


  // static var cabangDetailHandler = new Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  //       return new CabangDetailPage();
  //     });

  static void initRoutes() {
    // _router.define("/detail/:name&:endpoint", handler: cabangDetailHandler);
  }

  static void navigateTo(context, String route, {TransitionType transition}) {
    _router.navigateTo(context, route, transition: transition);
  }

}