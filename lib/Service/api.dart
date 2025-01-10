import 'dart:convert';
import 'dart:io';
import 'package:contact_app_with_api/Model/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class API 
{
  static String _baseurl='http://192.168.227.67/ContactAPI/api/';
  static String imageurl='http://192.168.227.67/ContactAPI/Content/Upload/Images/';
Future<http.Response> getAllContacts()async
{
  
  String url='${_baseurl}ContactHandling/AllContacts';
  var response=await http.get(Uri.parse(url));
  return response;
}
Future<http.Response> saveContact(String name,String number,String email)async
{
  String url='${_baseurl}ContactHandling/AddNewContact?number=${number}&name=${name}&email=${email}';
  return await http.post(Uri.parse(url));
}
Future<http.Response> saveContactObject(Map<String,dynamic> contactobj)async
{
     

  String url='${_baseurl}ContactHandling/NewContact';
  var contact_json= jsonEncode(contactobj);
  return await http.post(Uri.parse(url),
  headers: {'Content-Type':'application/json'},
  body: contact_json);
}
Future<int> saveUsingMultipart(File image,String name,String number,String email)async
{
     

  String url='${_baseurl}ContactHandling/NewContactFormBody';
  http.MultipartRequest request=http.MultipartRequest('POST', Uri.parse(url));
  request.fields["number"]=number;
  request.fields["name"]=name;
  request.fields["email"]=email;
  http.MultipartFile image_file=await http.MultipartFile.fromPath('image', image.path);
  request.files.add(image_file);
 var stream_response=await request.send();
 return stream_response.statusCode;
    
 }

}
