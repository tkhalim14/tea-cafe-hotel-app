
import 'package:flutter/material.dart';

const textformstyling = InputDecoration(
  //icon: const Icon(Icons.password),
  // hintText: 'Enter password',
  //labelText: 'Password',
  fillColor: Color.fromARGB(255, 255, 218, 218),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromARGB(134, 3, 168, 244),
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.lightBlue,
      width: 2.0,
    ),
  ),
);
