// class Noteorder {
//   int _id;
//   String _title;

//   Noteorder(this._title);
//   Noteorder.withId(this._id, this._title);

//   int get id => _id;
//   String get title => _title;

//   set title(String newTitle) {
//     if (newTitle.length <= 255) {
//       this._title = newTitle;
//     }
//   }

//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     if (id != null) {
//       map['id'] = _id;
//     }
//     map['title'] = _title;
//     return map;
//   }

//   Noteorder.fromMapObject(Map<String, dynamic> map) {
//     this._id = map['id'];
//     this._title = map['title'];
//   }
// }
