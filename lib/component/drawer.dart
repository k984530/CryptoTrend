import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "Crypto Trend",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ListTile(
            onTap: () {
              Get.dialog(
                Dialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 25, 15, 10),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Text('''
CoinTrend Privacy Policy

CoinTrend (hereinafter referred to as the "App") places great importance on the privacy of its users and complies with relevant laws, including the Information and Communication Network Act and the Personal Information Protection Act. Accordingly, this Privacy Policy provides information on how the App collects, uses, and protects personal information.

1. Collection of Personal Information

The App does not collect any personal information from its users. As a result, users are not required to provide any personal information during the use of the App. The App does not collect the following personal information:

- Name
- Address
- Phone number
- Email address
- Resident registration number
- Any other personal information
1. Purpose of Collecting Personal Information

The App does not collect any personal information; therefore, there is no purpose for such collection.

1. Use and Retention Period of Personal Information

The App does not collect any personal information; thus, there is no use or retention period for such information.

1. Provision and Sharing of Personal Information

The App does not collect any personal information; thus, there is no provision or sharing of personal information with third parties.

1. Destruction of Personal Information

The App does not collect any personal information; hence, there is no personal information to be destroyed.

1. User Rights

The App does not collect any personal information; thus, there is no procedure for users to exercise rights such as access, correction, deletion, or suspension of processing regarding personal information.

1. Measures for Personal Information Protection

As the App does not collect any personal information, no additional measures for personal information protection are required.

1. Contact for Personal Information-related Inquiries

For any inquiries related to personal information processing by the App, please contact:

[App Developer or Operator Contact]

Name: Won Choi
Email Address: **[alyduho984530@gmail.com](mailto:alyduho984530@gmail.com)**
Phone Number: 010-8433-6060

This Privacy Policy may be subject to change in accordance with changes in laws, policies, or security technologies. In case of any changes, the App will notify users in advance through in-app notices or similar means.

[Date of Writing or Last Update]

Date of Writing: July 26, 2023
Last Update: July 26, 2023

Users are encouraged to periodically review the Privacy Policy to stay informed about any changes.
'''),
                    ),
                  ),
                ),
              );
            },
            leading: Icon(Icons.mobile_friendly),
            title: Text("Privacy Policy"),
          ),
        ],
      ),
    );
  }
}
