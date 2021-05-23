import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/model/customer.dart';
import 'package:kk_conferences/providers/staff/accounts_provider.dart';
import 'package:kk_conferences/widgets/drawer.dart';
import 'package:provider/provider.dart';
import 'package:kk_conferences/utils.dart';

class Account extends StatefulWidget {
  static const String classname = "/Account";

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {



  Card topArea() => Card(
        margin: EdgeInsets.all(10.0),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        child: Container(
            decoration: BoxDecoration(
                gradient: RadialGradient(colors: [main_color, main_color])),
            padding: EdgeInsets.all(5.0),
            // color: Color(0xFF015FFF),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    Text("${Provider.of<AccountProvider>(context,listen: false).title}",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    )
                  ],
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text("₹ ${Provider.of<AccountProvider>(context,listen: false).amount} ",
                        style: TextStyle(color: Colors.white, fontSize: 24.0)),
                  ),
                ),
                SizedBox(height: 35.0),
              ],
            )),
      );

  bool ispayment = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AccountProvider>(context);
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(child: CommonDrawer()),
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: main_color, //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: Text(
            "Accounts",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.date_range,
                color: main_color,
              ),
              onPressed: () async {
                DateTime date = DateTime.now();
                FocusScope.of(context).requestFocus(new FocusNode());
                DateTime picked = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2021, 05, 2, 00, 00, 00, 00, 00),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now(),
                );
                if (picked != null && picked != date) {
                  // add this line.
                  provider.updatePayments(picked);
                }
              },
            )
          ],
        ),
        body: Consumer<AccountProvider>(builder: (context, value, child) {
          return SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  topArea(),
                  Container(
                    margin: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        if(provider.model!=null)
                          ...provider.items.mapIndexed((e, i) => accountItems("Payment ${++i} ", "${value.ispayment==true?"+":"-"} \$ ${e.amount}", "Dated : ${DateFormat('dd-MM-yyyy').format(Timestamp.fromMillisecondsSinceEpoch(e.createdAt*1000).toDate())}", "${e.status}",
                              oddColour: ++i%2==0? Color(0xFFF7F7F9):Colors.white)),

                        /*         accountItems("Trevello App", r"+ $ 4,946.00", "28-04-16", "credit",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 5,428.00", "26-04-16", "credit"),
          accountItems("Amazon EU", r"+ $ 746.00", "25-04-216", "Payment",
              oddColour: const Color(0xFFF7F7F9)),
          accountItems(
              "Creative Studios", r"+ $ 14,526.00", "16-04-16", "Payment"),
          accountItems(
              "Book Hub Society", r"+ $ 2,876.00", "04-04-16", "Credit",
              oddColour: const Color(0xFFF7F7F9)),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FlatButton(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  color: provider.ispayment == true ? main_color : Colors.white,
                  // borderSide: BorderSide(color: Color(0xFF015FFF), width: 1.0),
                  onPressed: () {
                    provider.setPayments();

                  },
                  child: Text(
                    "Payments",
                    style: TextStyle(
                        color: provider.ispayment == true
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
                FlatButton(
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  color:
                      provider.ispayment == false ? main_color : Colors.white,
                  // borderSide: BorderSide(color: Color(0xFF015FFF), width: 1.0),
                  onPressed: () {
                    provider.setRefunds();
                  },
                  child: Text(
                    "Refunds",
                    style: TextStyle(
                        color: provider.ispayment == false
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container accountItems(
          String item, String charge, String dateString, String type,
          {Color oddColour = Colors.white}) =>
      Container(
        decoration: BoxDecoration(color: oddColour),
        padding:
            EdgeInsets.only(top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(item, style: TextStyle(fontSize: 16.0)),
                Text(charge, style: TextStyle(fontSize: 16.0))
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(dateString,
                    style: TextStyle(color: Colors.grey, fontSize: 14.0)),
                Text(type, style: TextStyle(color: Colors.grey, fontSize: 14.0))
              ],
            ),
          ],
        ),
      );

  displayAccoutList() {

    return ;
  }

  @override
  void initState() {
    super.initState();
    final provider=Provider.of<AccountProvider>(context,listen: false);
     Future.delayed(Duration(seconds: 1)).then((value) =>
         provider.updatePayments(DateTime.now())
     );
  }
}
