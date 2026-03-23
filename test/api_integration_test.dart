//flutter test test/api_integration_test.dart
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:domra_tech/service/auth_service.dart';
import 'package:domra_tech/service/user_service.dart';
import 'package:domra_tech/service/word_service.dart';
import 'package:domra_tech/service/request_service.dart';

void main() {
  final client = http.Client();
  final authService = AuthService(client);
  final userService = UserService(client);
  final wordService = WordService(client);
  final requestService = RequestService(client);

  String? authToken;
  int? userId; // Store the userId extracted from the token
  const String existingEmail = "inchanaliza@gmail.com";
  const String testPassword = "636363";

  group('Domra-Tech Full API Bridge', () {
    // --- 1. AUTHENTICATION ---
    // group('AuthService', () {
    //   test('Login should return 200 and capture Token + UserId', () async {
    //     final res = await authService.login(existingEmail, testPassword);
    //     expect(res.statusCode, 200);

    //     final data = jsonDecode(res.body);
    //     authToken = data['token'] ?? data['accessToken'];
    //     expect(authToken, isNotNull);

    //     // DECODE JWT TO GET USER ID
    //     try {
    //       final payloadBase64 = authToken!.split('.')[1];
    //       final normalizedPayload = base64.normalize(payloadBase64);
    //       final payloadString = utf8.decode(base64.decode(normalizedPayload));
    //       final Map<String, dynamic> payload = jsonDecode(payloadString);

    //       userId = payload['id'] ?? payload['userId'];
    //       print("Authenticated User ID: $userId");
    //     } catch (e) {
    //       print("Could not decode JWT payload: $e");
    //     }
    //   });
    // });

    // --- 2. USER PROFILE ---
    group('UserService', () {
      test('getProfile should return user details', () async {
        if (authToken == null) markTestSkipped("No token");
        final res = await userService.getProfile(authToken!);
        expect(res.statusCode, 200);

        final data = jsonDecode(res.body);
        // Check if data is nested or flat
        final email = (data['data'] != null)
            ? data['data']['email']
            : data['email'];
        expect(email, existingEmail);
      });
    });

    // --- 3. WORDS & FAVORITES ---
    group('WordService', () {
      test('getAllWords and Favorite lifecycle', () async {
        final listRes = await wordService.getAllWords();
        expect(listRes.statusCode, 200);

        final dynamic decodedBody = jsonDecode(listRes.body);
        List words = (decodedBody is Map)
            ? (decodedBody['words'] ?? [])
            : decodedBody;

        if (words.isNotEmpty) {
          final String realId = words[0]['wordId'].toString();
          final favRes = await wordService.createFavorite(realId, authToken!);

          // 200/201 = Success, 400/409 = Already Favorited (Still valid for test)
          expect(favRes.statusCode, anyOf(200, 201, 400, 409));
        }
      });
    });

    // --- 4. REQUESTS (Word & Correction) ---
    group('RequestService', () {
      test('Word Request & Correction Request flow', () async {
        if (authToken == null) markTestSkipped("No token");

        // A. CREATE WORD REQUEST
        final wordReqRes = await requestService.createWordRequest({
          "newEnglishWord": "Test ${DateTime.now().millisecondsSinceEpoch}",
          "newKhmerWord": "តេស្ត",
          "newDefinition": "Integration Test",
        }, authToken!);
        expect(wordReqRes.statusCode, anyOf(200, 201));

        // B. CREATE CORRECTION REQUEST
        final listRes = await wordService.getAllWords();
        final dynamic decodedBody = jsonDecode(listRes.body);
        List words = (decodedBody is Map)
            ? (decodedBody['words'] ?? [])
            : decodedBody;

        if (words.isNotEmpty) {
          final String realWordId = words[0]['wordId'].toString();

          final corrReqRes = await requestService.createCorrectionRequest({
            "userId": userId, // Dynamically extracted from token
            "wordId": realWordId,
            "suggestedCorrection": "Dynamic correction test",
            "reason": "Testing the bridge",
          });

          expect(
            corrReqRes.statusCode,
            anyOf(200, 201),
            reason: "Correction failed: ${corrReqRes.body}",
          );
        } else {
          fail("Test failed: Words table is empty, cannot test corrections.");
        }
      });
    });
  });

  tearDownAll(() => client.close());
}
