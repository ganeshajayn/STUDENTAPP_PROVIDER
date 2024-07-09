import 'package:demostudents/model/student.dart';
import 'package:demostudents/services/functions.dart';
import 'package:demostudents/utils/constants.dart';
import 'package:demostudents/view/add_studentscreen.dart/add_student_screen.dart';
import 'package:demostudents/view/edit_screen/editscreen.dart';
import 'package:demostudents/view/student_search_screen/student_search_screen.dart';
import 'package:demostudents/view/widgets/app_bar_widget.dart';
import 'package:demostudents/view/widgets/floating_actionbutton.dart';
import 'package:demostudents/view/widgets/student_list_widgets.dart';
import 'package:demostudents/viewmodel/student_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:provider/provider.dart';

class StudentListScreen extends StatelessWidget {
  const StudentListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentController = context.read<StudentProvider>();

    studentController.loadStudents();

    return Scaffold(
      backgroundColor: Constants().blackColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 90),
        child: AppBarWidget(
          onTapRight: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SearchStudentScreen(),
              ),
            );
          },
          righticon: Icons.search,
          title: 'STUDENTS DETAILS',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<StudentProvider>(
            builder: (context, studentProvider, _) {
              if (studentProvider.students.isEmpty) {
                return Text(
                  'No Student Found',
                  style: TextStyle(fontSize: 20, color: Constants().whiteColor),
                );
              } else {
                return ListView.separated(
                  physics: const ScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  separatorBuilder: (context, index) => Constants().kheight10,
                  itemCount: studentProvider.students.length,
                  itemBuilder: (context, index) {
                    var student = studentProvider.students[index];
                    return InkWell(
                      onTap: () => showStudentDetailsDialog(context, student),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: StudentCardWidget(
                            student: student,
                            studentController: studentProvider),
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: const FloatingActionButtonWidget(
        page: AddStudentScreen(),
      ),
    );
  }
}

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({
    Key? key,
    required this.student,
    required this.studentController,
  }) : super(key: key);

  final StudentModel student;
  final StudentProvider studentController;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditScreen(student: student),
              ),
            );
          },
          icon: Icons.edit,
          backgroundColor: Colors.green,
        ),
        SlidableAction(
          onPressed: (context) {
            showDeleteConfirmationDialog(context, student, studentController);
          },
          icon: Icons.delete,
          backgroundColor: Colors.red,
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Constants().kWidth10,
                StudentImageContainerWidget(
                  student: student,
                  height: 150,
                  width: 150,
                ),
                Constants().kWidth10,
                Expanded(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name.toUpperCase(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Constants().kheight10,
                        Text(
                          'Age: ${student.age}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Department: ${student.department.toUpperCase()}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          'Phone No: ${student.phoneNumber}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
