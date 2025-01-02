class Contact
{
  late String number;
  String ?name;
  String ?email,pic;
  Contact.fromMap(Map<String,dynamic> map)
  {
    number=map["number"];
    name=map["personName"];
    email=map["personEmail"];
    pic=map["personPic"];
  }


}