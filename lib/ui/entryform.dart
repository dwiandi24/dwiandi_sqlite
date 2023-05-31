import 'package:flutter/material.dart';
import 'package:sqlite/models/contact.dart';

class EntryForm extends StatefulWidget {
  final Contact contact;
  const EntryForm({super.key, required this.contact});

  @override
  State<EntryForm> createState() => _EntryFormState(contact);
}

class _EntryFormState extends State<EntryForm> {
  Contact contact;
  _EntryFormState(this.contact);
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (contact != null) {
      nameController.text = contact.name;
      phoneController.text = contact.phone;
    }
    return Scaffold(
      appBar: AppBar(
        title: contact == null ? Text('Tambah Data') : Text('Ubah Data'),
        leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: TextField(
                controller: phoneController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Nomor HP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                    child: Text(
                      'Simpan',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      if (contact == null) {
                        contact =
                            Contact(nameController.text, phoneController.text);
                      } else {
                        contact.name = nameController.text;
                        contact.phone = phoneController.text;
                      }
                      Navigator.pop(context, contact);
                    },
                  )
                  ),
                  Container(
                    width: 5.0,
                  ),
                  Expanded(
                      child: ElevatedButton(
                    child: Text(
                      'Batal',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
