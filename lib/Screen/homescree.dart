import 'dart:convert';
import 'package:contact_app_with_api/Model/contact.dart';
import 'package:contact_app_with_api/Screen/contactformScreen.dart';
import 'package:contact_app_with_api/Service/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({super.key});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return ContactFormScreen();
        }));
      },child: Text('+'),),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: API().getAllContacts(), 
          builder:(context, snapshot){
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            

            http.Response response =snapshot.data!;
            if(response.statusCode!=200){
              return Center(child: Text('Something went wrong'),);

            }
              List<dynamic> mapList=  jsonDecode(response.body);
              List<Contact> contactlist=mapList.map((e) => Contact.fromMap(e)).toList();
            if(contactlist.isEmpty){
              return Center(child: Text('No record found'),);
            }
            
            return Expanded(child: Container(child: 
            ListView.builder(
              itemCount: contactlist.length,
              itemBuilder: (context,index){
                Contact contact=contactlist[index];
                return Card(
                   margin: EdgeInsets.all(8.0),
         child: Padding(
               padding: const EdgeInsets.all(16.0),
                     child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        contact.pic == null
            ? CircleAvatar(
                radius: 30,
                child: Icon(Icons.person, size: 30),
              )
            : CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('${API.imageurl}${contact.pic}'),
              ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              contact.name == null
                  ? Text(
                      'Name: ---',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )
                  : Text(
                      'Name: ${contact.name!}',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
              SizedBox(height: 8),
              Text(
                'Number: ${contact.number}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 8),
              contact.email == null
                  ? Text(
                      'Email: ---',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    )
                  : Text(
                      'Email: ${contact.email!}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
            ],
          ),
        ),
      ],
    ),
  ),
);
              }),)
            );

          })
        )
      
    );
  }
}