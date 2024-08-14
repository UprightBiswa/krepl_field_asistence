import 'package:flutter/material.dart';

class ActivityData {
  final String activityName;
  final int todayActivity;
  final int targetActivityNumbers;
  final int achievedActivityNumbers;
  final IconData icon;
  final Gradient gradientColor;
  final Color todayActivityColor;
  final Color targetActivityColor;
  final Color achievedActivityColor;

  ActivityData({
    required this.activityName,
    required this.todayActivity,
    required this.targetActivityNumbers,
    required this.achievedActivityNumbers,
    required this.icon,
    required this.gradientColor,
    required this.todayActivityColor,
    required this.targetActivityColor,
    required this.achievedActivityColor,
  });
}

final List<ActivityData> dummyMtdData = [
  ActivityData(
    activityName: 'Village Coverage',
    todayActivity: 100000000,
    targetActivityNumbers: 1000000,
    achievedActivityNumbers: 8000000,
    icon: Icons.location_on,
    gradientColor:
        const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    todayActivityColor: Colors.blue,
    targetActivityColor: Colors.green,
    achievedActivityColor: Colors.red,
  ),
  ActivityData(
    activityName: 'New Farmer Registration',
    todayActivity: 5, // Adjust these values as needed
    targetActivityNumbers: 20,
    achievedActivityNumbers: 12,
    icon: Icons.person_add, // Choose an appropriate icon for each activity
    gradientColor:
        const LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    todayActivityColor: Colors.orange,
    targetActivityColor: Colors.yellow,
    achievedActivityColor: Colors.deepOrange,
  ),
  ActivityData(
    activityName: 'One to one farmers contact',
    todayActivity: 8,
    targetActivityNumbers: 30,
    achievedActivityNumbers: 25,
    icon: Icons.handshake,
    gradientColor:
        const LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
    todayActivityColor: Colors.purple,
    targetActivityColor: Colors.indigo,
    achievedActivityColor: Colors.blueGrey,
  ),
  // Add more activities here...
  ActivityData(
    activityName: 'Group farmer meeting',
    todayActivity: 2,
    targetActivityNumbers: 5,
    achievedActivityNumbers: 3,
    icon: Icons.group,
    gradientColor:
        const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
    todayActivityColor: Colors.teal,
    targetActivityColor: Colors.lightGreen,
    achievedActivityColor: Colors.green,
  ),
  ActivityData(
    activityName: 'Organise Farmer meetings',
    todayActivity: 1,
    targetActivityNumbers: 3,
    achievedActivityNumbers: 2,
    icon: Icons.calendar_today,
    gradientColor:
        const LinearGradient(colors: [Colors.brown, Colors.lightGreenAccent]),
    todayActivityColor: Colors.brown,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),
  ActivityData(
    activityName: 'Demonstrations',
    todayActivity: 3,
    targetActivityNumbers: 10,
    achievedActivityNumbers: 7,
    icon: Icons.science,
    gradientColor:
        const LinearGradient(colors: [Colors.red, Colors.pinkAccent]),
    todayActivityColor: Colors.red,
    targetActivityColor: Colors.pink,
    achievedActivityColor: Colors.pinkAccent,
  ),
  ActivityData(
    activityName: 'Field Days',
    todayActivity: 0,
    targetActivityNumbers: 2,
    achievedActivityNumbers: 1,
    icon: Icons.location_searching,
    gradientColor:
        const LinearGradient(colors: [Colors.yellow, Colors.amberAccent]),
    todayActivityColor: Colors.yellow,
    targetActivityColor: Colors.amber,
    achievedActivityColor: Colors.orangeAccent,
  ),
  ActivityData(
    activityName: 'Jeep campaign',
    todayActivity: 4,
    targetActivityNumbers: 15,
    achievedActivityNumbers: 9,
    icon: Icons.directions_car,
    gradientColor: const LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
    todayActivityColor: Colors.grey,
    targetActivityColor: Colors.blueGrey,
    achievedActivityColor: Colors.lightBlue,
  ),
  ActivityData(
    activityName: 'Ballon show',
    todayActivity: 1,
    targetActivityNumbers: 1,
    achievedActivityNumbers: 1,
    icon: Icons.festival,
    gradientColor: const LinearGradient(
        colors: [Colors.lightBlue, Colors.lightGreenAccent]),
    todayActivityColor: Colors.lightBlue,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),

  ActivityData(
    activityName: 'KVK Visit',
    todayActivity: 10,
    targetActivityNumbers: 100,
    achievedActivityNumbers: 80,
    icon: Icons.location_on,
    gradientColor:
        const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    todayActivityColor: Colors.blue,
    targetActivityColor: Colors.green,
    achievedActivityColor: Colors.red,
  ),
  ActivityData(
    activityName: 'Haat operation',
    todayActivity: 5,
    targetActivityNumbers: 20,
    achievedActivityNumbers: 12,
    icon: Icons.account_balance_wallet, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    todayActivityColor: Colors.orange,
    targetActivityColor: Colors.yellow,
    achievedActivityColor: Colors.deepOrange,
  ),
  ActivityData(
    activityName: 'Melas',
    todayActivity: 8,
    targetActivityNumbers: 30,
    achievedActivityNumbers: 25,
    icon: Icons.festival, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
    todayActivityColor: Colors.purple,
    targetActivityColor: Colors.indigo,
    achievedActivityColor: Colors.blueGrey,
  ),
  ActivityData(
    activityName: 'Seminars',
    todayActivity: 2,
    targetActivityNumbers: 5,
    achievedActivityNumbers: 3,
    icon: Icons.school, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
    todayActivityColor: Colors.teal,
    targetActivityColor: Colors.lightGreen,
    achievedActivityColor: Colors.green,
  ),
  ActivityData(
    activityName: 'Distribution of POP',
    todayActivity: 1,
    targetActivityNumbers: 3,
    achievedActivityNumbers: 2,
    icon: Icons.shopping_cart, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.brown, Colors.lightGreenAccent]),
    todayActivityColor: Colors.brown,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),
  ActivityData(
    activityName: 'Dealer Stock',
    todayActivity: 3,
    targetActivityNumbers: 10,
    achievedActivityNumbers: 7,
    icon: Icons.inventory, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.red, Colors.pinkAccent]),
    todayActivityColor: Colors.red,
    targetActivityColor: Colors.pink,
    achievedActivityColor: Colors.pinkAccent,
  ),
  ActivityData(
    activityName: 'New Doctor',
    todayActivity: 0,
    targetActivityNumbers: 2,
    achievedActivityNumbers: 1,
    icon: Icons.local_hospital, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.yellow, Colors.amberAccent]),
    todayActivityColor: Colors.yellow,
    targetActivityColor: Colors.amber,
    achievedActivityColor: Colors.orangeAccent,
  ),
];

final List<ActivityData> dummyYtdData = [
  ActivityData(
    activityName: 'Village Coverage',
    todayActivity: 1000,
    targetActivityNumbers: 100000,
    achievedActivityNumbers: 80000,
    icon: Icons.location_on,
    gradientColor:
        const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    todayActivityColor: Colors.blue,
    targetActivityColor: Colors.green,
    achievedActivityColor: Colors.red,
  ),
  ActivityData(
    activityName: 'New Farmer Registration',
    todayActivity: 5, // Adjust these values as needed
    targetActivityNumbers: 20,
    achievedActivityNumbers: 12,
    icon: Icons.person_add, // Choose an appropriate icon for each activity
    gradientColor:
        const LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    todayActivityColor: Colors.orange,
    targetActivityColor: Colors.yellow,
    achievedActivityColor: Colors.deepOrange,
  ),
  ActivityData(
    activityName: 'One to one farmers contact',
    todayActivity: 8,
    targetActivityNumbers: 30,
    achievedActivityNumbers: 25,
    icon: Icons.handshake,
    gradientColor:
        const LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
    todayActivityColor: Colors.purple,
    targetActivityColor: Colors.indigo,
    achievedActivityColor: Colors.blueGrey,
  ),
  // Add more activities here...
  ActivityData(
    activityName: 'Group farmer meeting',
    todayActivity: 2,
    targetActivityNumbers: 5,
    achievedActivityNumbers: 3,
    icon: Icons.group,
    gradientColor:
        const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
    todayActivityColor: Colors.teal,
    targetActivityColor: Colors.lightGreen,
    achievedActivityColor: Colors.green,
  ),
  ActivityData(
    activityName: 'Organise Farmer meetings',
    todayActivity: 1,
    targetActivityNumbers: 3,
    achievedActivityNumbers: 2,
    icon: Icons.calendar_today,
    gradientColor:
        const LinearGradient(colors: [Colors.brown, Colors.lightGreenAccent]),
    todayActivityColor: Colors.brown,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),
  ActivityData(
    activityName: 'Demonstrations',
    todayActivity: 3,
    targetActivityNumbers: 10,
    achievedActivityNumbers: 7,
    icon: Icons.science,
    gradientColor:
        const LinearGradient(colors: [Colors.red, Colors.pinkAccent]),
    todayActivityColor: Colors.red,
    targetActivityColor: Colors.pink,
    achievedActivityColor: Colors.pinkAccent,
  ),
  ActivityData(
    activityName: 'Field Days',
    todayActivity: 0,
    targetActivityNumbers: 2,
    achievedActivityNumbers: 1,
    icon: Icons.location_searching,
    gradientColor:
        const LinearGradient(colors: [Colors.yellow, Colors.amberAccent]),
    todayActivityColor: Colors.yellow,
    targetActivityColor: Colors.amber,
    achievedActivityColor: Colors.orangeAccent,
  ),
  ActivityData(
    activityName: 'Jeep campaign',
    todayActivity: 4,
    targetActivityNumbers: 15,
    achievedActivityNumbers: 9,
    icon: Icons.directions_car,
    gradientColor: const LinearGradient(colors: [Colors.grey, Colors.blueGrey]),
    todayActivityColor: Colors.grey,
    targetActivityColor: Colors.blueGrey,
    achievedActivityColor: Colors.lightBlue,
  ),
  ActivityData(
    activityName: 'Ballon show',
    todayActivity: 1,
    targetActivityNumbers: 1,
    achievedActivityNumbers: 1,
    icon: Icons.festival,
    gradientColor: const LinearGradient(
        colors: [Colors.lightBlue, Colors.lightGreenAccent]),
    todayActivityColor: Colors.lightBlue,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),
  ActivityData(
    activityName: 'KVK Visit',
    todayActivity: 10,
    targetActivityNumbers: 100,
    achievedActivityNumbers: 80,
    icon: Icons.location_on,
    gradientColor:
        const LinearGradient(colors: [Colors.blue, Colors.lightBlueAccent]),
    todayActivityColor: Colors.blue,
    targetActivityColor: Colors.green,
    achievedActivityColor: Colors.red,
  ),
  ActivityData(
    activityName: 'Haat operation',
    todayActivity: 5,
    targetActivityNumbers: 20,
    achievedActivityNumbers: 12,
    icon: Icons.account_balance_wallet, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.orange, Colors.orangeAccent]),
    todayActivityColor: Colors.orange,
    targetActivityColor: Colors.yellow,
    achievedActivityColor: Colors.deepOrange,
  ),
  ActivityData(
    activityName: 'Melas',
    todayActivity: 8,
    targetActivityNumbers: 30,
    achievedActivityNumbers: 25,
    icon: Icons.festival, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.purple, Colors.deepPurpleAccent]),
    todayActivityColor: Colors.purple,
    targetActivityColor: Colors.indigo,
    achievedActivityColor: Colors.blueGrey,
  ),
  ActivityData(
    activityName: 'Seminars',
    todayActivity: 2,
    targetActivityNumbers: 5,
    achievedActivityNumbers: 3,
    icon: Icons.school, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.teal, Colors.tealAccent]),
    todayActivityColor: Colors.teal,
    targetActivityColor: Colors.lightGreen,
    achievedActivityColor: Colors.green,
  ),
  ActivityData(
    activityName: 'Distribution of POP',
    todayActivity: 1,
    targetActivityNumbers: 3,
    achievedActivityNumbers: 2,
    icon: Icons.shopping_cart, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.brown, Colors.lightGreenAccent]),
    todayActivityColor: Colors.brown,
    targetActivityColor: Colors.lime,
    achievedActivityColor: Colors.greenAccent,
  ),
  ActivityData(
    activityName: 'Dealer Stock',
    todayActivity: 3,
    targetActivityNumbers: 10,
    achievedActivityNumbers: 7,
    icon: Icons.inventory, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.red, Colors.pinkAccent]),
    todayActivityColor: Colors.red,
    targetActivityColor: Colors.pink,
    achievedActivityColor: Colors.pinkAccent,
  ),
  ActivityData(
    activityName: 'New Doctor',
    todayActivity: 0,
    targetActivityNumbers: 2,
    achievedActivityNumbers: 1,
    icon: Icons.local_hospital, // Adjust icon accordingly
    gradientColor:
        const LinearGradient(colors: [Colors.yellow, Colors.amberAccent]),
    todayActivityColor: Colors.yellow,
    targetActivityColor: Colors.amber,
    achievedActivityColor: Colors.orangeAccent,
  ),
];
