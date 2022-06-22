import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import '../screens/products_screen.dart';

import '../models/http_exception.dart';

enum SignType { signUp, signIn }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth-screen';
  const AuthScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          //................... Public background.....................................
          Opacity(
            opacity: .7,
            child: Image(
              image: const AssetImage('assets/images/vectorback1.jpg'),
              fit: BoxFit.cover,
              height: screenSize.height,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(211, 162, 113, .8),
            ),
            height: screenSize.height,
          ),

          SingleChildScrollView(
            child: SizedBox(
              height: screenSize.height,
              width: screenSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    flex: screenSize.width > 600 ? 2 : 1,
                    child: const AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//.......................Auth Card...................................................
class AuthCard extends StatefulWidget {
  const AuthCard({Key? key}) : super(key: key);

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
  SignType _signType = SignType.signIn;

  final Map<String?, String?> _signData = {'E-mail': '', 'Password': ''};

  final _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  bool _isLoading = false;

// Set up animation controller.
  late AnimationController _animationController;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

// Declare the animation that we use with the Sign form.
  @override
  void initState() {
    super.initState();

    // Declaring the Animation controller.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    // Declaring the Opacity animation the we use with confirm password TextFormField.
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInBack,
      ),
    );

    // Declaring the SlideTransition Animation.

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
  }

// Dispose password controller dut to memory leaks.
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _animationController.dispose();
  }

  // creating a show dialog for displaying errors...
  void _showDialog(String? message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Error occurred'),
              content: Text('$message'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Okay'),
                ),
              ],
            ));
  }

// Submit Data from form after validating.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    //wait for Signing...
    setState(() {
      _isLoading = true;
    });
    try {
      // Sign Up...
      if (_signType == SignType.signUp) {
        await Provider.of<AuthProvider>(context, listen: false).signUp(
          _signData['E-mail'],
          _signData['password'],
        );
      }

      // Sign in...
      if (_signType == SignType.signIn) {
        // ignore: use_build_context_synchronously
        await Provider.of<AuthProvider>(context, listen: false).signIn(
          _signData['E-mail'],
          _signData['password'],
        );
      }

      // Navigate to products screen if authenticated...
      Navigator.of(context).pushReplacementNamed(ProductsScreen.routeName);

      // Catching authentication errors...
    } on HttpException catch (error) {
      var errorMessage = 'Failed to authenticate you';

      if (error.message.contains('EMAIL_EXISTS')) {
        errorMessage = 'This E-mail is already in use. try to login instead';
      } else if (error.message.contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'This E-mail is not registered. try to sign up';
      } else if (error.message.contains('INVALID_PASSWORD')) {
        errorMessage = 'This password is invalid.';
      } else if (error.message.contains('USER_DISABLED')) {
        errorMessage = 'This account is disabled by administrator';
      }
      _showDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Authentication failed!';
      _showDialog(errorMessage);
    }

    //Signing finished.
    setState(() {
      _isLoading = false;
    });
  }

  void _switchSignType() {
    if (_signType == SignType.signIn) {
      setState(() {
        _signType = SignType.signUp;
      });
      // to start the animation
      _animationController.forward();
    } else {
      setState(() {
        _signType = SignType.signIn;
      });
      // to reverse the animation
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        width: screenSize.width * 0.75,
        height: _signType == SignType.signUp ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: _signType == SignType.signUp ? 320 : 260,
        ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //....................E-mail.........................................
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid E-mail';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _signData['E-mail'] = value!;
                  },
                ),
                //.........................Password.....................................
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'Password is too short';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _signData['password'] = value!;
                  },
                ),
                //............Confirm password........................................

                // Using animated container to get rid of the white space reserved by FadeTransition.
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  constraints: BoxConstraints(
                    minHeight: _signType == SignType.signUp ? 60 : 0,
                    maxHeight: _signType == SignType.signUp ? 120 : 0,
                  ),
                  curve: Curves.easeIn,
                  // Using FadeTransition to display som animation.
                  child: FadeTransition(
                    opacity: _opacityAnimation!,
                    // Using SlideTransition to give an animation that it make the Text Form field to look like as it was hidden under the above TextFormField.
                    child: SlideTransition(
                      position: _slideAnimation!,
                      child: TextFormField(
                        enabled: _signType == SignType.signUp,
                        decoration: const InputDecoration(
                            labelText: 'Confirm password'),
                        obscureText: true,
                        validator: _signType == SignType.signUp
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Password don\' match';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //......................submit form button.........................
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 8),
                    ),
                    child: Text(
                        _signType == SignType.signUp ? 'Sign Up' : 'Sign in'),
                  ),
                //......................change submit type button.................
                TextButton(
                  onPressed: _switchSignType,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 4),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  child: Text(
                      '${_signType == SignType.signIn ? 'Sign up' : 'Sign in'} Instead'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
