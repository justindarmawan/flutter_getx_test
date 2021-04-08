import 'package:flutter_getx_test/pages/auth/personal_info_widget.dart';
import 'package:flutter_getx_test/pages/auth/register_widget.dart';
import 'package:flutter_getx_test/pages/auth/signin_widget.dart';
import 'package:flutter_getx_test/pages/auth/verification_widget.dart';

final authItems = [
  {
    'item': SigninWidget(),
    'label': 'SIGN IN',
  },
  {
    'item': RegisterWidget(),
    'label': 'REGISTER',
  },
  {
    'item': PersonalInfoWidget(),
    'label': 'PERSONAL INFO',
  },
  {
    'item': VerificationWidget(),
    'label': 'VERIFICATION',
  },
];
