import 'package:bloc_login/model/api_model.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


final _base = "https://flutter-ui--django-backend.herokuapp.com";
final _tokenEndPoint = "/api-token-auth/";
final _tokenURL = _base + _tokenEndPoint;

Future<Token> getToken(UserLogin userLogin) async{
  print(_tokenURL);
  final http.Response response = await http.post(
    _tokenURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8', 
    },
    body: jsonEncode(userLogin.toDatabaseJson()),
  );

  if(response.statusCode == 200){
    return Token.fromJson(json.decode(response.body));
  }else{
    print(json.decode(response.body).toString());
    throw Exception(json.decode(response.body));
  }
}