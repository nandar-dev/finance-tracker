import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'add_money_detail.dart';
import 'database/database_helper_money.dart';
import 'database/money_note.dart';

class AddMoney extends StatefulWidget {
  String saveMoney;
  AddMoney(this.saveMoney);
  @override
  State<StatefulWidget> createState() {
    return AddMoneyState(this.saveMoney);
  }
}

class AddMoneyState extends State<AddMoney> {
  DatabaseHelperMoney databaseHelperMoney = DatabaseHelperMoney();
  List<MoneyNote> noteListMoney;
  int count = 0;

  String saveMoney;
  int totalprice;
  String getPrice;
  int getTotalPrice;
  String stringGetTotalPrice;


  AddMoneyState(this.saveMoney);

  @override
  Widget build(BuildContext context) {
    if (noteListMoney == null) {
      noteListMoney = List<MoneyNote>();
      updateMoneyListView();
    }

    if(totalprice == 0) {
      getTotal();
    }else if(totalprice != 0){
      getTotal();
    }

    stringGetTotalPrice = totalprice.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('View History'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color:Colors.white,),
            onPressed: () {
          Navigator.pop(context,true);
        
            },
          ),
       
      ),
      body: getNoteListViewMoney(),
      
    );
  }

  ListView getNoteListViewMoney() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
         
          elevation: 0,
          child: ListTile(
            title: Text(this.noteListMoney[position].money, style: titleStyle),

            subtitle: Text(this.noteListMoney[position].date),

            // subtitle: Text(saveMoney),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.grey),
              onTap: () {
                _delete(context, noteListMoney[position]);
              },
            ),
            onTap: () {
              // navigateToDetail(this.noteListMoney[position], 'Edit Note');
            },
          ),
        );
      },
    );
  }

  void _delete(BuildContext context, MoneyNote note) async {
    int result = await databaseHelperMoney.deleteMoneyNote(note.id);
    if (result != 0) {
      // _showSnackBar(context, 'Note Deleted Successfully');
      updateMoneyListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  // void navigateToDetail(MoneyNote note, stringGetTotalPrice) async {
  //   bool result =
  //       await Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return AddMoneyDetail(note, stringGetTotalPrice);
  //   }));

  //   if (result == true) {
  //     updateMoneyListView();
  //   }
    
  // }

  void updateMoneyListView() {
    final Future<Database> dbFuture = databaseHelperMoney.initalizeDatabase();
    dbFuture.then((database) {
      Future<List<MoneyNote>> noteListFuture =
          databaseHelperMoney.getNoteListMoney(saveMoney);
      noteListFuture.then((noteListMoney) {
        setState(() {
          this.noteListMoney = noteListMoney;
          this.count = noteListMoney.length;
        });
      });
    });
  }


  void getTotal() async {

    var total = (await databaseHelperMoney.getTotal(saveMoney))[0]['Total'];
    setState(() {
      totalprice = total;

    });
  }

  
 
}
