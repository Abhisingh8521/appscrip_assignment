import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/provider_controller/user_auth_provider.dart';
import '../../utils/widgets/app_widgets.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var view = AppWidgets();
    var theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.background,
      appBar: AppBar(title: Text('Login'),centerTitle: true,),
      extendBody: false,
      bottomNavigationBar:  Container(
        height: 130,
        color: theme.secondary,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Consumer<UserAuthProvider>(
                builder: (context, provider, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: view.elevatedButtonView(
                      onPressed: (){
                        if (_formKey.currentState!.validate()){
                        }
                        provider.login(context);
                        },
                      child:  Text('Login',style: TextStyle(color: theme.onPrimary))),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: theme.primary,
                  ),
                ),
                SizedBox(width: 8),
                Consumer<UserAuthProvider>(
                    builder: (context, provider, child) => TextButton(
                      onPressed: () {

                        provider.navigateSignUp(context);
                        },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PhysicalModel(
          color: theme.secondary,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                view.sizedBoxView(height: 50),
                Text(
                  'Login Here',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: theme.inversePrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: theme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 100),
                Column(
                  children: [
                    Consumer<UserAuthProvider>(
                        builder: (context, provider, child) => view.textFormFieldView(
                            controller: provider.emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a Email Address';
                              }
                              return null;
                            },
                            hintText: 'Enter Email')),

                  ],
                ),
                SizedBox(height: 25),
                Consumer<UserAuthProvider>(
                    builder: (context, provider, child) => view.textFormFieldView(
                        controller: provider.passwordController,
                        hintText: 'Enter Password',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Password';
                          }
                          return null;
                        },
                        hiddenStatus: true)),
                SizedBox(height: 100),

              ],
            ),
          ),
        ),
      ),
    );
  }
}