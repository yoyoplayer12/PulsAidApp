
import "package:flutter/material.dart";
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/buttons/Button_dark_blue.dart';
import 'package:theapp/components/navbar.dart';


class ChangeAccountType extends StatefulWidget {
  const ChangeAccountType({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChangeAccountTypeState createState() => _ChangeAccountTypeState();
}

class _ChangeAccountTypeState extends State<ChangeAccountType> {
  var accountType = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {
  final userInfo = await ApiManager().userInfo();
  setState(() {
    accountType = userInfo["user"]["role"];
    if (accountType == 'EHBO'){
      accountType = AppLocalizations.of(context).translate('ehbo');
    }else if(accountType == 'EAD'){
      accountType = AppLocalizations.of(context).translate('aed');
    }else if(accountType == 'lisiningear'){
      accountType = AppLocalizations.of(context).translate('lisiningear');
    }
  });
}

  void saveChange(String newType) async {
    final response = await ApiManager().changeAccountType(newType);
    if (response['status'] == 200) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushNamed(context, '/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 32, left: 16, right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
        decoration: BoxDecoration(
          color: BrandColors.offWhiteLight,
          borderRadius: BorderRadius.circular(30), // Adjust the value as needed
        ),
        child: const CustomNavBar(
          selectedIndex: 3,
        ),
      ),
      body:Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              AppBar(
                centerTitle: true,
                title:  Text(
                  AppLocalizations.of(context).translate('change_account_type'),
                  style: const TextStyle(
                    color: BrandColors.grayMid,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                backgroundColor: Colors.transparent, // make the AppBar background transparent
                elevation: 0, // remove shadow
                automaticallyImplyLeading: false,
                actions: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(right: 30.0), // adjust the value as needed
                    child: IconButton(
                      icon: const Icon(Icons.close, size: 32, color: BrandColors.grayMid, semanticLabel: 'Exit'), // replace with your desired icon
                      onPressed: () {
                        // handle the icon tap here
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]
              ),
              Container(
                margin: const EdgeInsets.only(left: 32, right: 32),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: BrandColors.offWhiteLight,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                    AppLocalizations.of(context).translate('current_type'),
                    style: const TextStyle(
                      color: BrandColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                    accountType,
                    style: const TextStyle(
                      color: BrandColors.black,
                      fontSize: 20,
                    ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity-64,
                margin: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: 
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(accountType == 'Reanimatiehulp' || accountType == 'Resusciation aid')...[
                    const Text(
                      'Type 1',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_aed'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('aed_aid')),
                      onPressed: () {
                        // handle the button tap here
                        saveChange('EAD');
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Type 2',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_listeningear'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('lisiningear')),
                      onPressed: () {
                        // handle the button tap here
                       saveChange('lisiningear');
                      },
                    ),
                  ]else if(accountType == 'AED')...[
                    const Text(
                      'Type 1',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_ehbo'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('ehbo')),
                      onPressed: () {
                        // handle the button tap here
                        saveChange('EHBO');
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Type 2',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_listeningear'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('lisiningear')),
                      onPressed: () {
                        // handle the button tap here
                        saveChange('lisiningear');
                      },
                    ),
                  ]else if(accountType == 'lisiningear' || accountType == 'Luisterend oor')...[
                     const Text(
                      'Type 1',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_ehbo'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('ehbo')),
                      onPressed: () {
                        // handle the button tap here
                        saveChange('EHBO');
                      },
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Type 2',
                      style: TextStyle(
                        color: BrandColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context).translate('explination_aed'),
                      style: const TextStyle(
                        color: BrandColors.black,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButtonDarkBlue(
                      icon: Icons.sync,
                      child: Text(AppLocalizations.of(context).translate('aed_aid')),
                      onPressed: () {
                        saveChange('EAD');
                      },
                    ),
                  ]
                ],
                )
              ),
          ],
          )
        ],
      ),
    );
  }
}