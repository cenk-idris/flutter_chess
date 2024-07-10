import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chess/blocs/user_cubit/user_cubit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _usernameInputController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to chess'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                FontAwesomeIcons.solidChessRook,
                size: 100.0,
                color: Colors.blue,
              ),
              Column(
                children: [
                  TextField(
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    controller: _usernameInputController,
                    decoration:
                        InputDecoration(hintText: 'Enter your username'),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, userState) {
                      if (userState is UserRegistered) {
                        Navigator.pushReplacementNamed(context, '/main-screen');
                      } else if (userState is UserRegistrationError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(userState.message),
                          ),
                        );
                      }
                    },
                    builder: (context, userState) {
                      if (userState is UserBeingRegistered) {
                        return CircularProgressIndicator();
                      } else if (userState is UserNotRegistered ||
                          userState is UserRegistrationError) {
                        return Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  final String username =
                                      _usernameInputController.text.trim();
                                  final RegExp usernamePattern =
                                      RegExp(r'^[a-zA-Z0-9]+$');
                                  if (username.isNotEmpty &&
                                      usernamePattern.hasMatch(username)) {
                                    await context
                                        .read<UserCubit>()
                                        .addUser(username);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Username must contain only letters and numbers')),
                                    );
                                  }
                                },
                                child: Text('Register'),
                              ),
                            ),
                          ],
                        );
                      } else if (userState is UserRegistered) {
                        return Text(
                            'User already registered, redirecting to main screen');
                      } else {
                        return Text('ERROR: Unexpected User State'); //
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
