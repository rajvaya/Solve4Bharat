class Patient {
  String phone;
  String docID;
  String gender;
  String dob;
  String email;
  String name;

  Patient(
      {this.phone, this.docID, this.gender, this.dob, this.email, this.name});

  Patient.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    docID = json['docID'];
    gender = json['gender'];
    dob = json['dob'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['docID'] = this.docID;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
