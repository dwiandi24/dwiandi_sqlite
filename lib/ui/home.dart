import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/helpers/dbhelper.dart';
import 'package:sqlite/models/contact.dart';
import 'package:sqlite/ui/entryform.dart';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Contact> contactList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite'),
      ),
      body: createListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Tambah Data',
        onPressed: () async {
          var contact = await navigateToEntryForm(context, Contact('', ''));
          if(contact.name != '' && contact.phone != '') addContact(contact);
        },
      ),
    );
  }

  Future<Contact> navigateToEntryForm(BuildContext context, Contact contact) async {
    var result = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (BuildContext context){ return EntryForm(contact: contact); })
      );
    return result;
  }

  ListView createListView(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.people),
            ),
          title: Text(this.contactList[index].name),
          subtitle: Text(this.contactList[index].phone),
          trailing: GestureDetector(
            child: Icon(Icons.delete),
            onTap: () {
              deleteContact(contactList[index]);
            },
          ),
          onTap: () async {
            var contact = await navigateToEntryForm(context, this.contactList[index]);
            if(contact.name != '' && contact.phone != '') editContact(contact);
          },
          ),      
        );
      },
    );
  }

  void addContact(Contact object) async {
    int result = await dbHelper.insert(object);
    if (result > 0) {
      updateListView();      
    }
  }

  void editContact(Contact object) async {
    int result = await dbHelper.update(object);
    if (result > 0) {
      updateListView();      
    }
  }

  void deleteContact(Contact object) async {
    int result = await dbHelper.delete(object.id);
    if (result > 0) {
      updateListView();      
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Contact>> contactListFuture = dbHelper.getContactList();
      contactListFuture.then((contactList){
        setState(() {
          this.contactList = contactList;
          this.count = contactList.length;
        });
      });
    });
  }
}