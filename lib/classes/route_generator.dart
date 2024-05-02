import 'package:flutter/material.dart';
import 'package:theapp/pages/language.dart';
import 'package:theapp/pages/login.dart';
import 'package:theapp/pages/navpages/do_not_disturb.dart';
import 'package:theapp/pages/navpages/instructions.dart';
import 'package:theapp/pages/navpages/account.dart';
import 'package:theapp/pages/navpages/notifications.dart';
import 'package:theapp/pages/role.dart';
import 'package:theapp/pages/role_aed.dart';
import 'package:theapp/pages/ehbo_registration.dart';
import 'package:theapp/pages/ehbo_registration2.dart';
import 'package:theapp/pages/ehbo_registration3.dart';
import 'package:theapp/pages/aed_registration.dart';
import 'package:theapp/pages/aed_registration2.dart';
import 'package:theapp/pages/save_registration.dart';
import 'package:theapp/pages/conversation.dart';
import 'package:theapp/pages/settings/account.dart';
import 'package:theapp/pages/settings/certificates.dart';
import 'package:theapp/pages/navpages/home.dart';
import 'package:theapp/pages/settings/certificate_detail.dart';
import 'package:theapp/pages/settings/certificate_edit.dart';
import 'package:theapp/pages/settings/save_certificate2.dart';
import 'package:theapp/pages/settings/save_certificate.dart';
import 'package:theapp/pages/settings/add_certificate.dart';
import 'package:theapp/pages/settings/change_account_type.dart';
import 'package:theapp/pages/conversation2.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/language':
        return MaterialPageRoute(builder: (_) => const Language());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/role':
        return MaterialPageRoute(builder: (_) => const RolePage());
      case '/roleAed':
        return MaterialPageRoute(builder: (_) => const RoleAedPage());
      case '/ehboRegistration':
        return MaterialPageRoute(builder: (_) => const EhboRegistrationPage());
      case '/ehboRegistration2':
        return MaterialPageRoute(builder: (_) => const EhboRegistration2Page());
      case '/ehboRegistration3':
        return MaterialPageRoute(builder: (_) => const EhboRegistration3Page());
      case '/aedRegistration':
        return MaterialPageRoute(builder: (_) => const AedRegistrationPage());
      case '/aedRegistration2':
        return MaterialPageRoute(builder: (_) => const AedRegistration2Page());
      case '/saveRegistration':
        return MaterialPageRoute(builder: (_) => const SaveRegistrationPage());
      case '/doNotDisturb':
        return MaterialPageRoute(builder: (_) => const DoNotDisturb());
      case '/instructions':
        return MaterialPageRoute(builder: (_) => const Instructions());
      case '/account':
        return MaterialPageRoute(builder: (_) => const Account());
      case '/conversation':
        return MaterialPageRoute(builder: (_) => const Conversation());
      case '/accountSettings':
        return MaterialPageRoute(builder: (_) => const AccountSettings());
      case '/certificates':
        return MaterialPageRoute(builder: (_) => const Certificates());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/certificateDetail':
        return MaterialPageRoute(builder: (_) => CertificateDetailPage(certificate: settings.arguments as Map<String, dynamic>));
      case '/certificateEdit':
        return MaterialPageRoute(builder: (_) => CertificateEditPage(certificate: settings.arguments as Map<String, dynamic>));
      case '/saveCertificates2':
        var args = settings.arguments as Map;
        return MaterialPageRoute(builder: (_) => SaveCertificates2Page(formData: args['formData'], certificate: args['certificate']));
      case '/saveCertificates':
        return MaterialPageRoute(builder: (_) => SaveCertificatesPage(formData: settings.arguments as Map<String, dynamic>));
      case '/addCertificate':
        return MaterialPageRoute(builder: (_) => AddCertificate(userId: settings.arguments as String));
      case '/videoPlayer':
        return MaterialPageRoute(builder: (_) => VideoPlayerScreen(path: settings.arguments as String));
      case '/notifications':
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Notifications(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;
            var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      case '/changeType':
        return MaterialPageRoute(builder: (_) => const ChangeAccountType());
      case '/conversation2':
        return MaterialPageRoute(builder: (_) => Conversation2(option: settings.arguments as String));
      default:
        return MaterialPageRoute(builder: (_) => const Home());
    }
  }
}