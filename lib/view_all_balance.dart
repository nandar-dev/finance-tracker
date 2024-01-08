import 'package:flutter/material.dart';
import 'package:water_reminder_app/database/database_helper_money.dart';
import 'package:water_reminder_app/database/databasehelper.dart';
import 'package:water_reminder_app/home.dart' as prefix0;


class ViewAllBalance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewAllBalanceState();
  }
}

class ViewAllBalanceState extends State<ViewAllBalance> {


  DatabaseCome databaseHelper = DatabaseCome();
  DatabaseHelperMoney databaseHelperMoney = DatabaseHelperMoney();
  int totalincomeprice;
  int totaloutcomeprice;
  int totalallprice;
  int totalBalance;
  int currentBalance;

  ViewAllBalanceState();

  @override
  Widget build(BuildContext context) {

// Map<String, double> dataMap = new Map();
// dataMap.putIfAbsent("Flutter", () =>prefix0.totalBalance.toDouble());
// dataMap.putIfAbsent("React", () => prefix0.totaloutcomeprice.toDouble());
// dataMap.putIfAbsent("Xamarin", () =>currentBalance.toDouble());
// dataMap.putIfAbsent("Ionic", () => 2);

// PieChart(dataMap: dataMap);



    if (totalincomeprice == 0) {
      incometotal();
    } else if (totalincomeprice != 0) {
      incometotal();
    }

    if (totaloutcomeprice == 0) {
      outcometotal();
    } else if (totaloutcomeprice != 0) {
      outcometotal();
    }

    if (totalallprice == 0) {
      getAllTotal();
    } else if (totalallprice != 0) {
      getAllTotal();
    }


    totalBalance = (totalincomeprice + totalallprice) - totaloutcomeprice;

    currentBalance = totalincomeprice - (totaloutcomeprice + totalallprice);
  

    return Scaffold(
      appBar: AppBar(
        title: Text('View All Balance'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.white,),
            onPressed: () {
          Navigator.pop(context,true);
        
            },
          ),
       
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text("BALANCE", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ListTile(
              leading: Text("Total Balance :", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
              trailing: Text("$totalincomeprice MMK", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            ),
            
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
            ),
            ListTile(
              leading: Text("Current Balance :", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
              trailing: Text("$currentBalance MMK", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
            ),
            ListTile(
              leading: Text("Income :", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
              trailing: Text("$totalincomeprice MMK", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
            ),
            ListTile(
              leading: Text("Outcome :", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
              trailing: Text("$totaloutcomeprice MMK", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
            ),
            ListTile(
              leading: Text("Saved-Money :", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
              trailing: Text("$totalallprice MMK", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
            ),
            
            Divider(
              color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
            ),
    //       PieChart(
    //     dataMap: dataMap,
    //     animationDuration: Duration(milliseconds: 800),
    //     chartLegendSpacing: 32.0,
    //     chartRadius: MediaQuery.of(context).size.width / 2.7,
    //     showChartValuesInPercentage: true,
    //     showChartValues: true,
    //     showChartValuesOutside: false,
    //     chartValueBackgroundColor: Colors.grey[200],
    //     // colorList: colorList,
    //     showLegends: true,
    //     legendPosition: LegendPosition.right,
    //     decimalPlaces: 1,
    //     showChartValueLabel: true,
    //     initialAngle: 0,
    //     chartValueStyle: defaultChartValueStyle.copyWith(
    //       color: Colors.blueGrey[900].withOpacity(0.9),
    //     ),
    //     chartType: ChartType.disc,
    // ),
          ],
          
        ),
        
      ),
      
    );
  }

  void incometotal() async {
    var total = (await databaseHelper.totalIncome())[0]['Total'];

    setState(() {
      if (total == 0) {
        totalincomeprice = 0;
      } else if (total == null) {
        totalincomeprice = 0;
      } else {
        totalincomeprice = total;
      }
    });
  }


  void outcometotal() async {
    // print("Sdfsf");
    var total = (await databaseHelper.totalOutcome())[0]['Total'];
    // print('$total');
    setState(() {
      if (total == 0) {
        totaloutcomeprice = 0;
      } else if (total == null) {
        totaloutcomeprice = 0;
      } else {
        totaloutcomeprice = total;
      }
    });
  }

  void getAllTotal() async {
    var total = (await databaseHelperMoney.getAllTotal())[0]['AllTotal'];

    setState(() {
      totalallprice = total;
      if (total == null) {
        totalallprice = 0;
      }
    });
  }
}

// class SimpleLineChart extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
// Map<String, double> dataMap = new Map();
// dataMap.putIfAbsent("Flutter", () => 5);
// dataMap.putIfAbsent("React", () => 3);
// dataMap.putIfAbsent("Xamarin", () => 2);
// dataMap.putIfAbsent("Ionic", () => 2);

// PieChart(dataMap: dataMap);


//     return new PieChart(
//         dataMap: dataMap,
//         animationDuration: Duration(milliseconds: 800),
//         chartLegendSpacing: 32.0,
//         chartRadius: MediaQuery.of(context).size.width / 2.7,
//         showChartValuesInPercentage: true,
//         showChartValues: true,
//         showChartValuesOutside: false,
//         chartValueBackgroundColor: Colors.grey[200],
//         // colorList: colorList,
//         showLegends: true,
//         legendPosition: LegendPosition.right,
//         decimalPlaces: 1,
//         showChartValueLabel: true,
//         initialAngle: 0,
//         chartValueStyle: defaultChartValueStyle.copyWith(
//           color: Colors.blueGrey[900].withOpacity(0.9),
//         ),
//         chartType: ChartType.disc,
//     );
//   }
// }
