import 'package:flutter/material.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

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
      body: Column(
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
            height: 65,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    color: BrandColors.grayDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Proxima-Soft'
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: AppLocalizations.of(context).translate('privacy_policy\n\n'), 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('last_updated:may_18,_2024\n\n')
                      ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('this_privacy_policy_describes_our_policies_and_procedures_on_the_collection,_use,and_disclosure_of_your_information_when_you_use_the_service_and_informs_you_about_your_privacy_rights_and_how_the_law_protects_you.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('we_use_your_personal_data_to_provide_and_improve_the_service._by_using_the_service,_you_agree_to_the_collection_and_use_of_information_in_accordance_with_this_privacy_policy.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('interpretation_and_definitions\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('interpretation\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_words_with_initial_capital_letters_have_meanings_defined_under_the_following_conditions._the_following_definitions_shall_have_the_same_meaning_regardless_of_whether_they_appear_in_singular_or_plural.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('definitions\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('for_the_purposes_of_this_privacy_policy:\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_account_means_a_unique_account_created_for_you_to_access_our_service_or_parts_of_our_service.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("-_affiliate_means_an_entity_that_controls,_is_controlled_by,_or_is_under_common_control_with_a_party,_where_'control'_means_ownership_of_50%_or_more_of_the_shares,_equity_interest,_or_other_securities_entitled_to_vote_for_election_of_directors_or_other_managing_authority.\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_application_refers_to_pulsaid,_the_software_program_provided_by_the_company.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("-_company_(referred_to_as_either_'the_company',_'we',_'us',_or_'our'_in_this_agreement)_refers_to_pulsaid,_raghenoplein_21_bis,_2800_mechelen.\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_country_refers_to:_belgium\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_device_means_any_device_that_can_access_the_service,_such_as_a_computer,_cellphone,_or_digital_tablet.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_personal_data_is_any_information_that_relates_to_an_identified_or_identifiable_individual.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_service_refers_to_the_application.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_service_provider_means_any_natural_or_legal_person_who_processes_data_on_behalf_of_the_company._it_refers_to_third-party_companies_or_individuals_employed_by_the_company_to_facilitate_the_service,_to_provide_the_service_on_behalf_of_the_company,_to_perform_services_related_to_the_service,_or_to_assist_the_company_in_analyzing_how_the_service_is_used.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_third-party_social_media_service_refers_to_any_website_or_any_social_network_website_through_which_a_user_can_log_in_or_create_an_account_to_use_the_service.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_usage_data_refers_to_data_collected_automatically,_either_generated_by_the_use_of_the_service_or_from_the_service_infrastructure_itself_(for_example,_the_duration_of_a_page_visit).\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_you_means_the_individual_accessing_or_using_the_service,_or_the_company_or_other_legal_entity_on_behalf_of_which_such_individual_is_accessing_or_using_the_service,_as_applicable.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('_collecting_and_using_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('_types_of_data_collected\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_while_using_our_service,_we_may_ask_you_to_provide_us_with_certain_personally_identifiable_information_that_can_be_used_to_contact_or_identify_you._personally_identifiable_information_may_include,_but_is_not_limited_to:\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_email_address\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_first_name_and_last_name\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_phone_number\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_usage_data\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_usage_data\n\n'),
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_usage_data_is_collected_automatically_when_using_the_service.\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("_usage_data_may_include_information_such_as_your_device's_internet_protocol_address_(e.g._ip_address),_browser_type,_browser_version,_the_pages_of_our_service_that_you_visit,_the_time_and_date_of_your_visit,_the_time_spent_on_those_pages,_unique_device_identifiers,_and_other_diagnostic_data.\n\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_when_you_access_the_service_by_or_through_a_mobile_device,_we_may_collect_certain_information_automatically,_including,_but_not_limited_to,_the_type_of_mobile_device_you_use,_your_mobile_device_unique_id,_the_ip_address_of_your_mobile_device,_your_mobile_operating_system,_the_type_of_mobile_internet_browser_you_use,_unique_device_identifiers,_and_other_diagnostic_data.\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_we_may_also_collect_information_that_your_browser_sends_whenever_you_visit_our_service_or_when_you_access_the_service_by_or_through_a_mobile_device.\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_information_from_third-party_social_media_services\n\n'),
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_the_company_allows_you_to_create_an_account_and_log_in_to_use_the_service_through_the_following_third-party_social_media_services:\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_google\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_facebook\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_instagram\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("_if_you_decide_to_register_through_or_otherwise_grant_us_access_to_a_third-party_social_media_service,_we_may_collect_personal_data_that_is_already_associated_with_your_third-party_social_media_service's_account,_such_as_your_name,_your_email_address,_your_activities,_or_your_contact_list_associated_with_that_account.\n\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("_you_may_also_have_the_option_of_sharing_additional_information_with_the_company_through_your_third-party_social_media_service's_account._if_you_choose_to_provide_such_information_and_personal_data,_during_registration_or_otherwise,_you_are_giving_the_company_permission_to_use,_share,_and_store_it_in_a_manner_consistent_with_this_privacy_policy.\n\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_information_collected_while_using_the_application\n\n'),
                        style: const TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_while_using_our_application,_in_order_to_provide_features_of_our_application,_we_may_collect,_with_your_prior_permission:\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_information_regarding_your_location\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("-_pictures_and_other_information_from_your_device's_camera_and_photo_library\n\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("_we_use_this_information_to_provide_features_of_our_service,_to_improve_and_customize_our_service._the_information_may_be_uploaded_to_the_company's_servers_and/or_a_service_provider's_server_or_it_may_be_simply_stored_on_your_device.\n\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_you_can_enable_or_disable_access_to_this_information_at_any_time_through_your_device_settings.\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_use_of_your_personal_data\n\n'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('_the_company_may_use_personal_data_for_the_following_purposes:\n\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_to_provide_and_maintain_our_service,_including_monitoring_the_usage_of_our_service.\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_to_manage_your_account:_to_manage_your_registration_as_a_user_of_the_service._the_personal_data_you_provide_can_give_you_access_to_different_functionalities_of_the_service_that_are_available_to_you_as_a_registered_user.\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_for_the_performance_of_a_contract:_the_development,_compliance,_and_undertaking_of_the_purchase_contract_for_the_products,_items,_or_services_you_have_purchased_or_of_any_other_contract_with_us_through_the_service.\n')
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate("-_to_contact_you:_to_contact_you_by_email,_telephone_calls,_sms,_or_other_equivalent_forms_of_electronic_communication,_such_as_a_mobile_application's_push_notifications_regarding_updates_or_informative_communications_related_to_the_functionalities,_products,_or_contracted_services,_including_the_security_updates,_when_necessary_or_reasonable_for_their_implementation.\n")
                      ),
                      TextSpan(
                        text: AppLocalizations.of(context).translate('-_to_manage_your_requests:_to_attend_and_manage_your_requests_to_us.\n')
                      ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_for_business_transfers:_we_may_use_your_information_to_evaluate_or_conduct_a_merger,_divestiture,_restructuring,_reorganization,_dissolution,_or_other_sale_or_transfer_of_some_or_all_of_our_assets,_whether_as_a_going_concern_or_as_part_of_bankruptcy,_liquidation,_or_similar_proceeding,_in_which_personal_data_held_by_us_about_our_service_users_is_among_the_assets_transferred.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_for_other_purposes:_we_may_use_your_information_for_other_purposes,_such_as_data_analysis,_identifying_usage_trends,_determining_the_effectiveness_of_our_promotional_campaigns,_and_evaluating_and_improving_our_service,_products,_services,_marketing,_and_your_experience.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('we_may_share_your_personal_information_in_the_following_situations:\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_for_business_transfers:_we_may_share_or_transfer_your_personal_information_in_connection_with,_or_during_negotiations_of,_any_merger,_sale_of_company_assets,_financing,_or_acquisition_of_all_or_a_portion_of_our_business_to_another_company.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_with_affiliates:_we_may_share_your_information_with_our_affiliates,_in_which_case_we_will_require_those_affiliates_to_honor_this_privacy_policy._affiliates_include_our_parent_company_and_any_other_subsidiaries,_joint_venture_partners,_or_other_companies_that_we_control_or_that_are_under_common_control_with_us.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_with_business_partners:_we_may_share_your_information_with_our_business_partners_to_offer_you_certain_products,_services,_or_promotions.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_with_other_users:_when_you_share_personal_information_or_otherwise_interact_in_the_public_areas_with_other_users,_such_information_may_be_viewed_by_all_users_and_may_be_publicly_distributed_outside.\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_with_your_consent:_we_may_disclose_your_personal_information_for_any_other_purpose_with_your_consent.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('retention_of_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_company_will_retain_your_personal_data_only_for_as_long_as_is_necessary_for_the_purposes_set_out_in_this_privacy_policy._we_will_retain_and_use_your_personal_data_to_the_extent_necessary_to_comply_with_our_legal_obligations_(for_example,_if_we_are_required_to_retain_your_data_to_comply_with_applicable_laws),_resolve_disputes,_and_enforce_our_legal_agreements_and_policies.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_company_will_also_retain_usage_data_for_internal_analysis_purposes._usage_data_is_generally_retained_for_a_shorter_period_of_time,_except_when_this_data_is_used_to_strengthen_the_security_or_to_improve_the_functionality_of_our_service,_or_we_are_legally_obligated_to_retain_this_data_for_longer_time_periods.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('transfer_of_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("your_information,_including_personal_data,_is_processed_at_the_company's_operating_offices_and_in_any_other_places_where_the_parties_involved_in_the_processing_are_located._it_means_that_this_information_may_be_transferred_to_—_and_maintained_on_—_computers_located_outside_of_your_state,_province,_country,_or_other_governmental_jurisdiction_where_the_data_protection_laws_may_differ_from_those_of_your_jurisdiction.\n\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('your_consent_to_this_privacy_policy_followed_by_your_submission_of_such_information_represents_your_agreement_to_that_transfer.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_company_will_take_all_steps_reasonably_necessary_to_ensure_that_your_data_is_treated_securely_and_in_accordance_with_this_privacy_policy_and_no_transfer_of_your_personal_data_will_take_place_to_an_organization_or_a_country_unless_there_are_adequate_controls_in_place_including_the_security_of_your_data_and_other_personal_information.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('delete_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('you_have_the_right_to_delete_or_request_that_we_assist_in_deleting_the_personal_data_that_we_have_collected_about_you.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('our_service_may_give_you_the_ability_to_delete_certain_information_about_you_from_within_the_service.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('you_may_update,_amend,_or_delete_your_information_at_any_time_by_signing_in_to_your_account,_if_you_have_one,_and_visiting_the_account_settings_section_that_allows_you_to_manage_your_personal_information._you_may_also_contact_us_to_request_access_to,_correct,_or_delete_any_personal_information_that_you_have_provided_to_us.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('please_note,_however,_that_we_may_need_to_retain_certain_information_when_we_have_a_legal_obligation_or_lawful_basis_to_do_so.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('disclosure_of_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('business_transactions\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('if_the_company_is_involved_in_a_merger,_acquisition,_or_asset_sale,_your_personal_data_may_be_transferred._we_will_provide_notice_before_your_personal_data_is_transferred_and_becomes_subject_to_a_different_privacy_policy.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('law_enforcement\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('under_certain_circumstances,_the_company_may_be_required_to_disclose_your_personal_data_if_required_to_do_so_by_law_or_in_response_to_valid_requests_by_public_authorities_(e.g.,_a_court_or_a_government_agency).\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('other_legal_requirements\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_company_may_disclose_your_personal_data_in_the_good_faith_belief_that_such_action_is_necessary_to:\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_comply_with_a_legal_obligation\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_protect_and_defend_the_rights_or_property_of_the_company\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_prevent_or_investigate_possible_wrongdoing_in_connection_with_the_service\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_protect_the_personal_safety_of_users_of_the_service_or_the_public\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_protect_against_legal_liability\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('security_of_your_personal_data\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('the_security_of_your_personal_data_is_important_to_us,_but_remember_that_no_method_of_transmission_over_the_internet_or_method_of_electronic_storage_is_100%_secure._while_we_strive_to_use_commercially_acceptable_means_to_protect_your_personal_data,_we_cannot_guarantee_its_absolute_security.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("children's_privacy\n\n"),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('our_service_does_not_address_anyone_under_the_age_of_18._we_do_not_knowingly_collect_personally_identifiable_information_from_anyone_under_the_age_of_18._if_you_are_a_parent_or_guardian_and_you_are_aware_that_your_child_has_provided_us_with_personal_data,_please_contact_us._if_we_become_aware_that_we_have_collected_personal_data_from_anyone_under_the_age_of_18_without_verification_of_parental_consent,_we_take_steps_to_remove_that_information_from_our_servers.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("if_we_need_to_rely_on_consent_as_a_legal_basis_for_processing_your_information_and_your_country_requires_consent_from_a_parent,_we_may_require_your_parent's_consent_before_we_collect_and_use_that_information.\n\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('links_to_other_websites\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("our_service_may_contain_links_to_other_websites_that_are_not_operated_by_us._if_you_click_on_a_third-party_link,_you_will_be_directed_to_that_third_party's_site._we_strongly_advise_you_to_review_the_privacy_policy_of_every_site_you_visit.\n\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('we_have_no_control_over_and_assume_no_responsibility_for_the_content,_privacy_policies,_or_practices_of_any_third-party_sites_or_services.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('changes_to_this_privacy_policy\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('we_may_update_our_privacy_policy_from_time_to_time._we_will_notify_you_of_any_changes_by_posting_the_new_privacy_policy_on_this_page.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate("we_will_let_you_know_via_email_and/or_a_prominent_notice_on_our_service,_prior_to_the_change_becoming_effective_and_update_the_'last_updated'_date_at_the_top_of_this_privacy_policy.\n\n")
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('you_are_advised_to_review_this_privacy_policy_periodically_for_any_changes._changes_to_this_privacy_policy_are_effective_when_they_are_posted_on_this_page.\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('contact_us\n\n'),
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('if_you_have_any_questions_about_this_privacy_policy,_you_can_contact_us:\n\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_by_email:_contact@pulsaid.be\n')
                    ),
                    TextSpan(
                      text: AppLocalizations.of(context).translate('-_by_visiting_this_page_on_our_website:_www.pulsaid.com/contact\n')
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
