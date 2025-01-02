import 'dart:convert';
import 'package:contact_app_with_api/Model/contact.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class API 
{
  static String _baseurl='http://192.168.111.107/ContactAPI/api/';
  static String imageurl='http://192.168.111.107/ContactAPI/Content/Upload/Images/';
Future<http.Response> getAllContacts()async
{
  List<Contact> contactlist=[];
  String url='${_baseurl}ContactHandling/AllContacts';
  var response=await http.get(Uri.parse(url));
  return response;
}

}
