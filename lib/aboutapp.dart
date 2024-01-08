import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About App"),
         leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.white,),
            onPressed: () {
          Navigator.pop(context,true);
        
            },
          ),
        // backgroundColor: Colors.green[300],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Center(
                    child: Text(
                      "Finance",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 25,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Color(0xffCE8054)
                            : Colors.green[300],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Center(
                  child: Text(
                    """
           
    - An easy way to keep track of expenses.

    - This app will show you where is your money
      going.

    - You can quickly and easily plan your income
      and outcome which will help you avoid making
      accidental purchases.     

    - This app enable you to keep track of your 
      savings, so you can complete them easily.
                   
    - This app is the tool that manage your 
      savings.
                   
    - It will keep you on track to bring your 
      purchase goals to life.
                   
    - It takes away the frustration fo saving 
      money for a specific goal. 

    - It gives you the power and confidence to 
     succeed every time, and that's just plan 
     smart. 
               """,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "@Copyright2020",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
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
