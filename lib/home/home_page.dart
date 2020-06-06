import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_login/bloc/authentication_bloc.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text('Welcome', style:TextStyle(fontSize:24)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.16,
                child: RaisedButton(
                  child: Text("Logout", style:TextStyle(fontSize:24)),
                  onPressed: (){
                    BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                  },
                  shape: StadiumBorder(
                    side: BorderSide(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}