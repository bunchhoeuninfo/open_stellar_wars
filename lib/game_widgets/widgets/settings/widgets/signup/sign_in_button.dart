
import 'package:flutter/material.dart';
import 'package:open_stellar_wars/core/utils/log_util.dart';

class SignInButton extends StatelessWidget {
  final bool isSignedIn;

  const SignInButton({super.key, required this.isSignedIn});

  @override
  Widget build(BuildContext context) {
    return _buildCenter();
  }

  Center _buildCenter() {
    LogUtil.debug('Start building Setting - Sign In Button');
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (isSignedIn) {
            // Sign out logic
          } else {
            // Open sign-in screen
          }
        },
        child: Text(isSignedIn ? 'Sign Out' : 'Sign In'),
      ),
    );
  }
  
}