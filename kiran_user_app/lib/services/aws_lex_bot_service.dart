import 'dart:convert';
import 'package:aws_common/aws_common.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';

class AWSLexBotService {
  /*
  To do so just use --dart-define argument during flutter run or flutter build
flutter run --dart-define=AWS_ACCESS_KEY_ID=AKIAUPI2SRNPC2RCA7ZJ --dart-define=AWS_SECRET_ACCESS_KEY=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
*/
  String kRegion = 'us-east-1';

  Future<List<String>> callBot(String message) async {
    try {
      const AWSSigV4Signer signer = AWSSigV4Signer(
        credentialsProvider: AWSCredentialsProvider.environment(),
      );

      final scope = AWSCredentialScope(
        region: kRegion,
        service: AWSService.lexRuntimeService,
      );

      final request = AWSHttpRequest(
        method: AWSHttpMethod.post,
        uri: Uri.https('runtime.lex.$kRegion.amazonaws.com',
            '/bot/bot/alias/sihChatBot/user/UserOne/text'),
        headers: const {
          AWSHeaders.contentType: 'application/json',
        },
        body: json.encode({
          "inputText": message,
        }).codeUnits,
      );

      // Sign and send the HTTP request
      final signedRequest = await signer.sign(
        request,
        credentialScope: scope,
      );

      final resp = await signedRequest.send();
      final respBody = await resp.decodeBody();

      List<String> msgsList = [];
      final msg = json.decode(respBody)["message"];

      try {
        final msgs = json.decode(msg)["messages"];
        for (var m in msgs) {
          msgsList.add(m["value"]);
        }
      } catch (e) {
        msgsList.add(msg);
      }

      return msgsList;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
