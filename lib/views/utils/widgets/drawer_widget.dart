import 'dart:async';

import 'package:appscrip_assignment/controllers/provider_controller/user_auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Consumer<UserAuthProvider>(
            builder: (context, provider, child) => DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  SizedBox(child: ClipRRect(child: provider.userProfile.avatar == null? Icon(CupertinoIcons.profile_circled,size: 100,):  Image.network(provider.userProfile.avatar??""),borderRadius: BorderRadius.circular(50),),height: 100,width: 100,),
                  Text(
                    '${provider.userProfile.fullName ?? ""}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          Consumer<UserAuthProvider>(
            builder: (context, provider, child) => ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Logout'),
              onTap: () {
                provider.logout(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
