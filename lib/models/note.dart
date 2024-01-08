class Note{
  int _id;
  String _password;
  Note(this._password);
  Note.withId(this._id, this._password);
  
  int get id => _id;
  String get password => _password;

  set password(String newPassword) {
    this._password = newPassword;
  }

//  Convert a Note into a Map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['password'] = _password;
    return map;
  }

  // Extract a Note from a Map object
  Note.formMapObjedt(Map<String, dynamic> map) {
    this._id = map['id'];
    this._password = map['password'];
  }
}
