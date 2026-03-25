import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/platform_view_registry_stub.dart';
import '../../../../state/provider/auth_provider.dart';

import 'platform_view_registry_stub.dart'
    if (dart.library.html) 'platform_view_registry_web.dart';

class GoogleSignInButton extends StatefulWidget {
  final double height;
  final double width;

  const GoogleSignInButton({
    super.key,
    this.height = 48,
    this.width = double.infinity,
  });

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  static bool webViewRegistered = false;

  @override
  void initState() {
    super.initState();

    if (kIsWeb && !webViewRegistered) {
      _registerWebView();
      webViewRegistered = true;
    }
  }

  void _registerWebView() {
    const String viewId = "google-signin-button";

    registerViewFactory(viewId, (int id) {
      final container = html.DivElement()
        ..id = "google-signin-container"
        ..style.width = "100%"
        ..style.height = "100%"
        ..style.display = "flex"
        ..style.justifyContent = "center"
        ..style.alignItems = "center";

      return container;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ============================== WEB ==============================
    if (kIsWeb) {
      return Container(
        height: widget.height,
        width: widget.width,
        alignment: Alignment.center,
        child: const HtmlElementView(viewType: "google-signin-button"),
      );
    }

    // ============================== MOBILE ==============================
    return InkWell(
      onTap: () async {
        try {
          final token = await Provider.of<AuthProvider>(
            context,
            listen: false,
          ).signInWithGoogle();

          if (token != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Google sign-in successful")),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Google login error: $e")));
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/google.png", height: 20),
            const SizedBox(width: 12),
            const Text(
              "Sign in with Google",
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
