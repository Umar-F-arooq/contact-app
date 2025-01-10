import 'package:contact_app_with_api/Service/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ContactFormScreen extends StatefulWidget {
  @override
  _ContactFormScreenState createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  File? _image;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

   ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitUsingQuery() async{
    final name = _nameController.text;
    final number = _numberController.text;
    final email=_emailController.text;
  http.Response response= await API().saveContact(name, number, email);
  if(response.statusCode==200){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data Saved'),);

    });

  }
  else{
     showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data not  Saved'),);

    });

  }


    
  }
  void _submitUsingObject() async{
    final name = _nameController.text;
    final number = _numberController.text;
    final email=_emailController.text;
  http.Response response= await API().saveContactObject({
    "number":number,
    "personName":name,
    "personEmail":email
  });
  if(response.statusCode==200){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data Saved'),);

    });

  }
  else{
     showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data not  Saved'),);

    });

  }


    
  }
 void _submitUsingMultiPart() async{
    final name = _nameController.text;
    final number = _numberController.text;
    final email=_emailController.text;
 int code= await API().saveUsingMultipart(_image!, name, number, email);
  if(code==200){
    showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data Saved'),);

    });

  }
  else{
     showDialog(context: context, builder: (context){
      return AlertDialog(title: Text('Data not  Saved'),);

    });

  }


    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[400],
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitUsingQuery,
              child: Text('Submit 1'),
            ),
            
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitUsingObject,
              child: Text('Submit 2'),
            ),
             SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitUsingMultiPart,
              child: Text('Submit 3'),
            ),


          ],
        ),
      ),
    );
  }
}


