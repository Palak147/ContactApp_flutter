import 'dart:async';

class Validators {
  final validateName = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.trim().length > 0) {
        sink.add(name);
      } else {
        sink.addError('Name is required');
      }
    },
  );

  final validateMobile = StreamTransformer<String, String>.fromHandlers(
    handleData: (mobile, sink) {
      RegExp exp = new RegExp(r'^[0-9]+$');

      if (exp.hasMatch(mobile) && mobile.length == 10) {
        sink.add(mobile);
      } else {
        sink.addError('Enter a valid mobile number');
      }
    },
  );

  final validateLandline = StreamTransformer<String, String>.fromHandlers(
    handleData: (landline, sink) {
      RegExp exp = new RegExp(r'^[0-9]+$');
      if (exp.hasMatch(landline)) {
        sink.add(landline);
      } else {
        sink.addError('Enter a valid landline number');
      }
    },
  );
}
