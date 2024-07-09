import 'package:demostudents/model/student.dart';
import 'package:demostudents/utils/constants.dart';
import 'package:demostudents/view/widgets/student_list_widgets.dart';
import 'package:demostudents/viewmodel/student_controller.dart';
import 'package:flutter/material.dart';

void snackBarFunction({
  required BuildContext context,
  required String title,
  required String subtitle,
  Color? backgroundColor,
  DismissDirection? dismissDirection,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(subtitle),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {},
      ),
    ),
  );
}

void showDeleteConfirmationDialog(BuildContext context, StudentModel student,
    StudentProvider studentController) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Are you sure you want to delete ${student.name}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              studentController.deleteStudent(int.parse(student.id.toString()));
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

void showStudentDetailsDialog(BuildContext context, StudentModel student) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 550,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Constants().kheight20,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StudentImageContainerWidget(
                      student: student,
                      height: 300,
                      width: 300,
                    ),
                  ),
                  Constants().kheight20,
                  Text(
                    student.name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Constants().kheight20,
                  Text(
                    'Age: ${student.age}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Department: ${student.department.toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Place: ${student.place}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Guardian Name: ${student.guardianName}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Phone No: ${student.phoneNumber}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
