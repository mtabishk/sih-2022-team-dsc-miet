import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:kiran_doctor_app/app/common/custom_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(context,
        title: title, content: _message(exception), defaultActionText: 'OK');

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message ?? exception.toString();
  }
  return exception.toString();
}
