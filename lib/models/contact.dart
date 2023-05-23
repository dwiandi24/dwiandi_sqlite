class Contact {
  int _id = 0;
  String _name = '';
  String _phone = '';

  // konstruktor 1
  Contact(this._name, this. _phone);

  // konstruktor 2: konversi dari Map ke Contact
  Contact.fromMap(Map<String, dynamic> map){
    this._id = map['id'];
    this._name = map['name'];
    this._phone = map['phone'];
  }

  // getter
  int get id => _id;
  String get name => _name;
  String get phone => _phone;

  // setter
  set name(String value){
    _name = value;
  }

  set phone(String value){
    _phone = value;
  }

  // konversi dari Contact ke Map
  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = Map<String, dynamic>();    
    map['name'] = this._name;
    map['phone'] = this._phone;
    return map;
  }
}
