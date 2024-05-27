import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/classes/apimanager.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/contact_card.dart';
import 'package:theapp/components/navbar.dart';


class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<Map<String, dynamic>> conversation = [];
  List<Map<String, dynamic>> filteredConversation = [];


  @override
  void initState() {
    super.initState();
    getContacts();
  }

  getContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user');
    ApiManager apiManager = ApiManager();
      apiManager.fetchConversations().then((conversations) {
        var filteredConversations = conversations['conversations'].where((conversation) {
          return conversation['userId'] == userId && conversation['open'] == false;
        }).toList();
        setState(() {
          conversation = filteredConversations.map<Map<String, dynamic>>((conversation) {
            return {
              'option': conversation['option'],
              'applicantContact': conversation['applicantContact'],
            };
          }).toList();
        });
        filterSearchResults('');
      });
  }

  void filterSearchResults(String query) {
    if(query.isNotEmpty) {
      List<Map<String, dynamic>> searchResult = [];
      for (var item in conversation) {
        if (item['option'].toLowerCase().contains(query.toLowerCase()) || item['applicantContact'].toLowerCase().contains(query.toLowerCase())) {
          searchResult.add(item);
        }
      }
      setState(() {
        filteredConversation = searchResult;
      });
    } else {
      setState(() {
        filteredConversation = List.from(conversation);
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
        color: BrandColors.white,
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
      ),
      child: const CustomNavBar(
        selectedIndex: 1,
      ),
    ),  
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AppBar(
                  automaticallyImplyLeading: false,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context).translate('contacts'),
                    style: const TextStyle(
                      color: BrandColors.grey,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 56, left: 32, right: 32),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: BrandColors.greyLight.withOpacity(0.2), // Change this to your desired color
                      width: 2, // Change this to your desired width
                    ),
                    borderRadius: BorderRadius.circular(10), // Change this to your desired border radius
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 2),
                  child: TextField(
                    onChanged:(value) => filterSearchResults(value),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context).translate('search_your_contact'),
                      hintStyle: const TextStyle(color: BrandColors.greyLight, fontSize: 16),
                      suffixIcon: const Icon(Icons.person_search_outlined, color: BrandColors.greyLight,),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredConversation.length, // Use the length of the filteredConversation list
                    itemBuilder: (BuildContext context, int index) {
                      return ContactCard(
                        option: filteredConversation[index]['option'], // Use the option from the filteredConversation list
                        applicantContact: filteredConversation[index]['applicantContact'], // Use the applicantContact from the filteredConversation list
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}