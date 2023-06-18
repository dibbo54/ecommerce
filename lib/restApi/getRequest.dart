import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../ui/state_managers/auth_controller.dart';

Future<bool> userneworold() async {
  var URL = Uri.parse("https://craftybay.teamrabbil.com/api/ReadProfile");
  var PostHeader = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'token': AuthController.token.toString(),
  };
  var response = await http.get(URL, headers: PostHeader);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['data']==[]) {
    //SuccessToast("Request Success");
    log("yes");
    return true;
  } else {
    //ErrorToast("Request fail ! try again");
    //return [];la
    return false;
    log("no");
  }
}
