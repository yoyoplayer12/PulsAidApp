import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';


class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
        decoration: BoxDecoration(
          color: BrandColors.offWhiteLight,
          borderRadius: BorderRadius.circular(30),
        ),
        child: const CustomNavBar(
          selectedIndex: 3,
        ),
      ),
      body:
       Column(
        children: [
          AppBar(
            centerTitle: true,
            title: Text(
              AppLocalizations.of(context).translate('privacy_policy'),
              style: const TextStyle(
                color: BrandColors.grayMid,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 30.0),
                child: IconButton(
                  icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 49,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: BrandColors.grayDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Proxima-Soft'
                  ),
                  children: [
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('terms_of_use_for_pulsaid_application')}\n\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('welcome_to_pulsaid_an_application_that_allows_users_to_register_as_resuscitation_aid_aed_aid_or_a_listening_ear_by_registering_and_using_our_services_you_agree_to_the_following_terms_of_use_please_read_these_terms_carefully_before_using_the_application')}\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('1_general_terms')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('1_1_age_requirement')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('the_application_is_only_intended_for_individuals_aged_18_and_older')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('1_2_registration')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('users_must_register_with_accurate_and_complete_information_when_registering_as_resuscitation_aid_it_is_mandatory_to_provide_a_valid_certificate_or_diploma')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('1_3_data_processing')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('by_creating_an_account_the_user_consents_to_the_processing_of_personal_data_as_described_in_our_privacy_policy')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('2_use_of_the_service')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('2_1_purpose_of_the_service')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('the_application_provides_support_in_emergencies_by_connecting_helpers_with_people_in_need_users_can_register_as')}:\n',
                    ),
                    TextSpan(text: '${AppLocalizations.of(context).translate('resuscitation_aid')}\n'),
                    TextSpan(text: '${AppLocalizations.of(context).translate('aed_aid')}\n'),
                    TextSpan(text: '${AppLocalizations.of(context).translate('listening_ear')}\n\n'),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('2_2_responsibilities')}:\n',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:  '${AppLocalizations.of(context).translate('resuscitation_aid_and_aed_aid')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('it_is_only_permitted_to_respond_to_an_emergency_call_with_the_intention_of_actually_helping_it_is_not_allowed_to_go_to_an_emergency_situation_as_a_spectator')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('listening_ear')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('users_who_register_as_a_listening_ear_offer_support_to_people_in_need_without_providing_medical_or_legal_advice')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('3_code_of_conduct')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('3_1_respect_and_non_discrimination')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('all_users_must_treat_each_other_with_respect_discrimination_based_on_gender_appearance_sexual_orientation_race_religion_or_any_other_grounds_is_strictly_prohibited')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('3_2_authority_of_emergency_services')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('once_professional_emergency_services_are_on_site_they_take_over_the_situation_users_must_strictly_follow_the_instructions_of_the_emergency_services_and_not_hinder_their_work')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('4_certification')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('4_1_verification_of_certificates')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('users_who_register_as_resuscitation_aid_must_present_a_valid_certificate_or_diploma_pulsaid_reserves_the_right_to_verify_the_authenticity_of_these_documents')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('4_2_maintaining_certification')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('it_is_the_users_responsibility_to_ensure_that_their_certificates_are_up_to_date_users_with_expired_certificates_will_not_be_considered_as_resuscitation_aid')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('5_liability')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('5_1_limitation_of_liability')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('pulsaid_is_not_liable_for_any_direct_or_indirect_damage_resulting_from_the_use_of_the_application_or_the_services_of_other_users')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('5_2_user_responsibility')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('users_are_responsible_for_their_own_actions_and_for_complying_with_laws_and_regulations_while_providing_assistance')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('6_termination_of_service')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('6_1_termination_by_user')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('users_can_terminate_their_account_at_any_time_by_contacting_pulsaid_customer_service')}.\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('6_2_termination_by_pulsaid')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('pulsaid_reserves_the_right_to_terminate_accounts_for_violations_of_these_terms_of_use_or_for_other_inappropriate_behavior')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('7_changes_to_the_terms_of_use')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('7_1_amendments')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('pulsaid_reserves_the_right_to_change_these_terms_of_use_at_any_time_changes_will_be_communicated_to_users_via_the_application_or_by_email')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('8_governing_law')}\n',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('8_1_jurisdiction')}: ',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('these_terms_of_use_are_governed_by_dutch_law_any_disputes_will_be_submitted_to_the_competent_court_in_belgium')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('by_using_the_pulsaid_application_you_agree_to_these_terms_of_use_for_questions_or_support_please_contact_our_customer_service')}.\n\n',
                    ),
                    TextSpan(
                      text: '${AppLocalizations.of(context).translate('date_of_last_modification_may_19_2024')}\n\n',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('sincerely_the_pulsaid_team'),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
        ),
        ],
      ),
    );
  }
}
