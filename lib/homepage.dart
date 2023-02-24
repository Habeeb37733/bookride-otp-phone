import 'package:flutter/material.dart';
import 'cities.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

import 'confirmtkt.dart';

class CitySelector extends StatefulWidget {
  @override
  _CitySelectorState createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  String _selectedCity1 = '';
   int? approximationTime;
  String _selectedCity2 = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
    if(_selectedCity1!=null && _selectedCity2!=null){
      setState(() {
        approximationTime = Random().nextInt(24) + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('BOOK TICKETS'),
      ),
      body: Column(
        children: [
          Padding(

            padding: const EdgeInsets.only(top: 10),
            child: Text("RIDE TICKETS",style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),),
          ),
          Padding(
            padding: const EdgeInsets.only(top:10),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return cities.where((city) =>
                    city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selectedCity) {
                setState(() {
                  _selectedCity1 = selectedCity;
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      prefixIconColor: Colors.white,
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'FROM',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                    ),

                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: Autocomplete<String>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return cities.where((city) =>
                    city.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (String selectedCity) {
                setState(() {
                  _selectedCity2 = selectedCity;
                });
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 4.0,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: textEditingController,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.place),
                      prefixIconColor: Colors.white,
                      filled: true,
                      fillColor: Colors.black,
                      hintText: 'TO',
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: SizedBox(
                      height: 200.0,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8.0),
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return GestureDetector(
                            onTap: () {
                              onSelected(option);
                            },
                            child: ListTile(
                              title: Text(option),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.black,
              leading: Icon(Icons.date_range,
              color: Colors.white,
              ),
              title: Text('Pickup Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}'
              ,style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.black,

              leading: Icon(Icons.access_time,
                color: Colors.white,
              ),
              title: Text('Pickup Time: ${_selectedTime.format(context)}'
                 , style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _selectTime(context);

              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              tileColor: Colors.black,
              leading: Icon(Icons.access_time,
                color: Colors.white,
              ),
              title: Text('Approximation time:  $approximationTime hours',
                style: TextStyle(color: Colors.white),

              ),

            ),
          ),
          SizedBox(
            height: 10,
          ),

          SizedBox(
            width: MediaQuery.of(context).size.width*0.95,
            height: 50,
            child: ElevatedButton(
              onPressed:

                  (){
                if(_selectedCity1!='' && _selectedCity2!=''){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>
                          ConfirmationTickAnimation(
                              selectcity2:_selectedCity2,date:_selectedDate, selectity1: _selectedCity1,selectedtime:_selectedTime
                          )));
                }else{
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Alert Dialog'),
                        content: Text('SELECT FROM AND TO'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                  },
                child: Text("CONFIRM"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

            ),
          )
        ],
      ),
    );
  }
}
