class Note2 {

  int _id;
  String _title;
  String _price;
  String _total;

  Note2(this._title, this._price, this._total);

  Note2.withId(this._id, this._title, this._price, this._total);

  int get id => _id;

  String get title => _title;

  String get price => _price;

  String get total => _total;

  set title(String newTitle) {
    if(newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set price(String newPrice) {
    this._price = newPrice;
  }

  set total(String newTotal) {
    this._total = newTotal;
  }

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();

    if(id != null) {
      map['id'] = _id;
    }

    map['title'] = _title;
    map['price'] = _price;
    map['total'] = _total;

    return map;

  }

  Note2.fromMapObject(Map<String, dynamic> map) {

    this._id = map['id'];
    this._title = map['title'];
    this._price = map['price'];
    this._total = map['total'];

  }

}