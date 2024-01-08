class Note3 {
  int _id;
  String _salary;
  String _incomeamount;
  String _outcomeamount;
  String _note;
  String _date;
  String _come;
  int _day;

  Note3(this._salary, this._incomeamount, this._outcomeamount, this._note,
      this._date, this._come, this._day);
  Note3.withId(this._id, this._salary, this._incomeamount, this._outcomeamount,
      this._note, this._date, this._come, this._day);

  int get id => _id;

  String get salary => _salary;

  String get incomeamount => _incomeamount;

  String get outcomeamount => _outcomeamount;

  String get note => _note;

  String get date => _date;

  String get come => _come;

  int get day => _day;

  set salary(String newSalary) {
    if (newSalary.length >= 0) {
      this._salary = newSalary;
    }
  }

  set incomeamount(String newIncomeAmount) {
    if (newIncomeAmount.length >= 0) {
      this._incomeamount = newIncomeAmount;
    }
  }

  set outcomeamount(String newOutcomeAmount) {
    if (newOutcomeAmount.length >= 0) {
      this._outcomeamount = newOutcomeAmount;
    }
  }

  set note(String newNote) {
    if (newNote.length >= 0) {
      this._note = newNote;
    }
  }

  set come(String newCome) {
    if (newCome.length >= 0) {
      this._come = newCome;
    }
  }

  set day(int newDay) {
    if (newDay != 0) {
      this._day = newDay;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['salary'] = _salary;

    map['incomeamount'] = _incomeamount;

    map['outcomeamount'] = _outcomeamount;
    map['note'] = _note;

    map['date'] = _date;
    map['come'] = _come;
    map['day'] = _day;
    return map;
  }

  Note3.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];

    this._salary = map['salary'];

    this._incomeamount = map['incomeamount'];

    this._outcomeamount = map['outcomeamount'];

    this._note = map['note'];

    this._date = map['date'];

    this._come = map['come'];

    this._day = map['day'];
  }
}

// class Note1 {
//   int _id;
//   String _salary;
//   String _amount;
//   String _note;
//   String _date;
//   String _come;
//   Note1(this._salary, this._amount, this._note, this._date, this._come);
//   Note1.withId(
//       this._id, this._salary, this._amount, this._note, this._date, this._come);

//   int get id => _id;
//   String get salary => _salary;
//   String get amount => _amount;
//   String get note => _note;
//   String get date => _date;
//   String get come => _come;

//   set salary(String newSalary) {
//     this._salary = newSalary;
//   }

//   set amount(String newAmount) {
//     this._amount = newAmount;
//   }

//   set note(String newNote) {
//     this._note = newNote;
//   }

//   set date(String newDate) {
//     this._date = newDate;
//   }

//   set come(String newCome) {
//     this._come = newCome;
//   }

// //  Convert a Note into a Map object
//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     if (id != null) {
//       map['id'] = _id;
//     }
//     map['salary'] = _salary;
//     map['amount'] = _amount;
//     map['note'] = _note;
//     map['date'] = _date;
//     map['come'] = _come;

//     return map;
//   }

//   // Extract a Note from a Map object
//   Note1.formMapObject(Map<String, dynamic> map) {
//     this._id = map['id'];
//     this._salary = map['salary'];
//     this._amount = map['amount'];
//     this._note = map['note'];
//     this._date = map['date'];
//     this._come = map['come'];

//   }
// }
