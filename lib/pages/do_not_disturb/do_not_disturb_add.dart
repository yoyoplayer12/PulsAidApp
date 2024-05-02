import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/intl.dart';
import 'package:theapp/app_localizations.dart';
import 'package:theapp/colors.dart';
import 'package:theapp/components/navbar.dart';

class DoNotDisturbAdd extends StatefulWidget {
  const DoNotDisturbAdd({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DoNotDisturbAddState createState() => _DoNotDisturbAddState();
}

class _DoNotDisturbAddState extends State<DoNotDisturbAdd>{
   bool repeat = true;
   bool fullDay = false;
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  void changed(bool? value) {
    if (value != null) {
      setState(() {
        fullDay = !fullDay;
        if (fullDay) {
          selectedStartDate = DateTime.now();
          selectedStartTime = TimeOfDay.now();
          selectedEndDate = DateTime.now().add(const Duration(days: 1));
          selectedEndTime = TimeOfDay.fromDateTime(selectedEndDate);
        }
      });
    }
  }

    Future<void> selectStartDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  
  Future<void> selectStartTime() async {
    final TimeOfDay? picked = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 215,
            child: hourMinuteSecond(),
          ),
        );
      },
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

      Future<void> selectEndDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  
  Future<void> selectEndTime() async {
    final TimeOfDay? picked = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 215,
            child: hourMinuteSecond(),
          ),
        );
      },
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }
  
    Widget hourMinuteSecond() {
      return TimePickerSpinner(
        isForce2Digits: true,
        isShowSeconds: false,
        onTimeChange: (time) {
          setState(() {
            selectedEndTime = TimeOfDay.fromDateTime(time);
          });
        },
      );
    }


//main content
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
        selectedIndex: 1,
      ),
    ),
    body: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context).translate('availability'),
                style: const TextStyle(
                  color: BrandColors.grayMid,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
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
                ],
              backgroundColor: Colors.transparent, // make the AppBar background transparent
              elevation: 0, // remove shadow
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0, left: 32.0, right: 32.0),
              width: MediaQuery.of(context).size.width - 64,
              child:Column(
              children: [
                GestureDetector(
                  onTap: () {
                    changed(fullDay);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: BrandColors.secondaryExtraDark, // Set the border color
                        width: 2, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              AppLocalizations.of(context).translate("full_day"),
                              style: const TextStyle(
                                color: BrandColors.grayLight,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Radio<bool>(
                            value: true,
                            groupValue: fullDay,
                            onChanged: changed,
                            fillColor: MaterialStateProperty.all(BrandColors.secondaryExtraDark),
                          ),
                        ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if(fullDay) return;
                        await selectStartDate();
                        await selectStartTime();
                      },
                      child: Column(
                      children: [
                        Text(
                          DateFormat('EEE dd MMM', Localizations.localeOf(context).languageCode).format(selectedStartDate),
                          style: const TextStyle(
                            color: BrandColors.grayLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          )                      
                        ),
                        Text(
                        selectedStartTime.format(context),
                          style: const TextStyle(
                            color: BrandColors.grayLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          )          
                        ),
                      ]                    
                      )
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: BrandColors.black,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if(fullDay) return;
                        await selectEndDate();
                        await selectEndTime();
                      },
                      child: Column(
                        children: [
                          Text(
                          DateFormat('EEE dd MMM', Localizations.localeOf(context).languageCode).format(selectedEndDate),
                            style: const TextStyle(
                              color: BrandColors.grayLight,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            )                      
                          ),
                          Text(
                            selectedEndTime.format(context),
                            style: const TextStyle(
                              color: BrandColors.grayLight,
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            )          
                          ),
                        ]                    
                      ),
                    ),
                  ],
                  )
                ],
              ),
              ),
          ],
        ),
      ],
    ),
  );
}
}