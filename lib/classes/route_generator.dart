import 'package:flutter/material.dart';
import 'package:theapp/pages/do_not_disturb/do_not_disturb_add.dart';
import 'package:theapp/pages/do_not_disturb/do_not_disturb_repeat.dart';
import 'package:theapp/pages/do_not_disturb/save_do_not_disturb.dart';
import 'package:theapp/pages/ear_registration.dart';
import 'package:theapp/pages/ear_registration2.dart';
import 'package:theapp/pages/ear_registration3.dart';
import 'package:theapp/pages/language.dart';
import 'package:theapp/pages/login.dart';
import 'package:theapp/pages/navpages/contacts.dart';
import 'package:theapp/pages/navpages/do_not_disturb.dart';
import 'package:theapp/pages/navpages/home/rate_process.dart';
import 'package:theapp/pages/navpages/instructions.dart';
import 'package:theapp/pages/navpages/account.dart';
import 'package:theapp/pages/navpages/notifications.dart';
import 'package:theapp/pages/passwordForgot/code.dart';
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
import 'package:theapp/pages/settings/contact_info.dart';
import 'package:theapp/pages/settings/language.dart';
import 'package:theapp/pages/settings/notifications.dart';
import 'package:theapp/pages/settings/privacy.dart';
import 'package:theapp/pages/settings/privacy_policy.dart';
import 'package:theapp/pages/settings/save_certificate2.dart';
import 'package:theapp/pages/settings/save_certificate.dart';
import 'package:theapp/pages/settings/add_certificate.dart';
import 'package:theapp/pages/settings/change_account_type.dart';
import 'package:theapp/pages/conversation2.dart';
import 'package:theapp/pages/passwordForgot/email.dart';
import 'package:theapp/pages/passwordForgot/reset_password.dart';
import 'package:theapp/pages/settings/save_certificate3.dart';
import 'package:theapp/pages/settings/save_contact_info.dart';
import 'package:theapp/pages/settings/terms_of_use.dart';
import 'package:theapp/pages/settings/upload_certificate.dart';
import 'package:theapp/pages/settings/upload_contact.dart';
import 'package:theapp/pages/conversation_loader.dart';
import 'package:theapp/pages/conversation_loader_ear.dart';

import '../pages/settings/location.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {
      case '/language':
          return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Language(),
            transitionDuration: Duration.zero,
          );
      case '/home':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Home(),
            transitionDuration: Duration.zero,
            );
      case '/role':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const RolePage(),
            transitionDuration: Duration.zero,
            );
      case '/roleAed':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const RoleAedPage(),
            transitionDuration: Duration.zero,
            );
      case '/ehboRegistration':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EhboRegistrationPage(),
            transitionDuration: Duration.zero,
            );
      case '/ehboRegistration2':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EhboRegistration2Page(),
            transitionDuration: Duration.zero,
            );
      case '/ehboRegistration3':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EhboRegistration3Page(),
            transitionDuration: Duration.zero,
            );
      case '/aedRegistration':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const AedRegistrationPage(),
            transitionDuration: Duration.zero,
            );
      case '/aedRegistration2':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const AedRegistration2Page(),
            transitionDuration: Duration.zero,
            );
      case '/saveRegistration':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const SaveRegistrationPage(),
            transitionDuration: Duration.zero,
            );
      case '/doNotDisturb':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const DoNotDisturb(),
            transitionDuration: Duration.zero,
            );
      case '/instructions':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Instructions(),
            transitionDuration: Duration.zero,
            );
      case '/account':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Account(),
            transitionDuration: Duration.zero,
            );
      case '/conversation':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Conversation(),
            transitionDuration: Duration.zero,
            );
      case '/accountSettings':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const AccountSettings(),
            transitionDuration: Duration.zero,
            );
      case '/certificates':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Certificates(),
            transitionDuration: Duration.zero,
            );
      case '/login':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const LoginPage(),
            transitionDuration: Duration.zero,
            );
      case '/certificateDetail':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => CertificateDetailPage(certificate: settings.arguments as Map<String, dynamic>),
            transitionDuration: Duration.zero,
            );
      case '/certificateEdit':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => CertificateEditPage(certificate: settings.arguments as Map<String, dynamic>),
            transitionDuration: Duration.zero,
            );
      case '/saveCertificates2':
        var args = settings.arguments as Map;
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SaveCertificates2Page(formData: args['formData'], certificate: args['certificate']),
            transitionDuration: Duration.zero,
            );
      case '/saveCertificates':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SaveCertificatesPage(formData: settings.arguments as Map<String, dynamic>),
            transitionDuration: Duration.zero,
            );
      case '/addCertificate':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => AddCertificate(userId: settings.arguments as String),
            transitionDuration: Duration.zero,
            );
      case '/videoPlayer':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => VideoPlayerScreen(path: settings.arguments as String),
            transitionDuration: Duration.zero,
            );
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
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const ChangeAccountType(),
            transitionDuration: Duration.zero,
            );
      case '/conversation2':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Conversation2(option: settings.arguments as String),
            transitionDuration: Duration.zero,
            );
      case '/rateProcess':
        var args = settings.arguments as Map;
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RateProcess(date: args['date'] as String, id: args['id'] as String),
            transitionDuration: Duration.zero,
            );
      case '/doNotDisturbAdd':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => DoNotDisturbAdd(repeat: settings.arguments != null ? settings.arguments as String : ''),            transitionDuration: Duration.zero,
            );
      case '/doNotDisturbRepeat':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => DoNotDisturbRepeat(selected: settings.arguments as String),
            transitionDuration: Duration.zero,
            );
      case '/saveDoNotDisturb':
        var args = settings.arguments as Map;
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SaveDoNotDisturbPage(formData: args['formData']),
            transitionDuration: Duration.zero,
            );
      case '/forgot-password':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Email(),
            transitionDuration: Duration.zero,
            );
      case '/code':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => Code(email: settings.arguments as String),
            transitionDuration: Duration.zero,
        );
      case '/resetPassword':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ResetPassword(email: settings.arguments as String),
            transitionDuration: Duration.zero,
        );
      case '/location':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Location(),
            transitionDuration: Duration.zero,
        );
      case '/ear_registration':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EarRegistrationPage(),
            transitionDuration: Duration.zero,
        );
      case '/earRegistration2':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EarRegistration2Page(),
            transitionDuration: Duration.zero,
        );
      case '/ear_registration3':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const EarRegistration3Page(),
            transitionDuration: Duration.zero,
        );
      case '/contacts':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Contacts(),
            transitionDuration: Duration.zero,
        );
      case '/privacy':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Privacy(),
            transitionDuration: Duration.zero,
        );
      case '/privacypolicy':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const PrivacyPolicy(),
            transitionDuration: Duration.zero,
        );
      case '/termsofuse':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const TermsOfUse(),
            transitionDuration: Duration.zero,
        );
      case '/uploadCertificate':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => UploadCertificate(role: settings.arguments as String),
            transitionDuration: Duration.zero,
        );
      case '/saveCertificate3':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SaveCertificates3Page(formData: settings.arguments as Map<String, dynamic>),
            transitionDuration: Duration.zero,
        );
      case '/uploadContact':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => UploadContact(role: settings.arguments as String),
            transitionDuration: Duration.zero,
        );
      case '/saveContactInfo':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => SaveContactInfo(formData: settings.arguments as Map<String, dynamic>),
            transitionDuration: Duration.zero,
        );
      case '/contactInfo':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const ContactInfo(),
            transitionDuration: Duration.zero,
        );
      case '/languageSettings':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const LanguageSettings(),
            transitionDuration: Duration.zero,
        );
      case '/notificationsSettings':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const NotificationsSettings(),
            transitionDuration: Duration.zero,
        );
      case '/conversationLoader':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => ConversationLoader(platform: settings.arguments as String),
            transitionDuration: Duration.zero,
        );
      case '/conversationLoaderEar':
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
            final args = settings.arguments as Map<String, dynamic>;
            return ConversationLoaderEar(platform: args['platform'], userId: args['userId']);
          },
            transitionDuration: Duration.zero,
        );
      default:
        return PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => const Home(),
            transitionDuration: Duration.zero,
            );
    }
  }
}
