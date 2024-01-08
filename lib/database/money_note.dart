
class MoneyNote {

  int _id;
  String _money;
  String _date;
  String _number;
  

  MoneyNote(this._money, this._date, this._number);

  MoneyNote.withId(this._id, this._money, this._date, this._number);

  int get id => _id;

  String get money => _money;

  String get date => _date;

  String get number => _number;


  set money(String newTitle) {
    if(newTitle.length <= 255) {
      this._money = newTitle;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set number(String newNumber) {
    if(newNumber != null){
      this._number = newNumber;
    }
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if(id != null) {
      map['id'] = _id;
    }

    map['money'] = _money;
    map['date'] = _date;
    map['number'] = _number;

    return map;

  }

  MoneyNote.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._money = map['money'];
    this._date = map['date'];
    this._number = map['number'];
  }

}