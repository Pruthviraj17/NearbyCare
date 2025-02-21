import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:nearby_hospitals/animations/show_snackbar.dart';
import 'package:nearby_hospitals/services/auth_service.dart';
import 'package:nearby_hospitals/widgets/components/custom_text_widget.dart';
import 'package:nearby_hospitals/widgets/screens/HomeScreen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1.0; // Animate to fully opaque
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 40,
            children: [
              Flexible(child: Image.asset("assets/hospital_banner.png")),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomTextWidget(
                  text:
                      "Instantly find nearby hospitals based on your current location",
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                  fontSize: 18,
                ),
              ),

              OutlinedButton(
                onPressed: () => AuthService().signInWithGoogle(),
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.resolveWith<Color?>((
                    states,
                  ) {
                    if (states.contains(WidgetState.pressed)) {
                      return const Color.fromARGB(
                        255,
                        158,
                        158,
                        158,
                      ).withValues(alpha: 0.2); // Tap effect color
                    }
                    return null; // Default effect
                  }),
                  splashFactory: InkSplash.splashFactory,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Image.asset("assets/google_logo.png", width: 50),

                    CustomTextWidget(text: "Login / Signup"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
