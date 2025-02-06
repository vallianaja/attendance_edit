import 'package:flutter/material.dart';

import 'absent/absent_screen.dart';
import 'attendance/attendance_screen.dart';
import 'attendance_history/attendance_history_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop(context);
          if (shouldPop) {
            Navigator.of(context).pop(true);
          }
        }
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo[800]!,
                Colors.indigo[600]!,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hello Mate!',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          height: 1.4),
                    ),
                    const Text(
                      'What you want to do?',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.4),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                        child: GridView.count(
                            crossAxisCount: 2,
                            childAspectRatio: 0.9,
                            // p/l
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            children: [
                              _buildMenuCard(
                                  icon: Icons.camera,
                                  color: Colors.amberAccent,
                                  title: 'Attendance',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AttendScreen()));
                                  }),
                              _buildMenuCard(
                                  icon: Icons.camera,
                                  color: Colors.amberAccent,
                                  title: 'Absent',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AbsentScreen()));
                                  }),
                              _buildMenuCard(
                                  icon: Icons.camera,
                                  color: Colors.amberAccent,
                                  title: 'Attendance Info',
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const AttendanceHistoryScreen()));
                                  }),
                            ])),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget _buildMenuCard({
        required IconData icon,
        required Color color,
        required String title,
        required VoidCallback onTap})
  {
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 6,
      child: InkWell(
          onTap: () => onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.indigo.shade400,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ],
            ),
          )),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Confirm Exit?'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ])) ??
        false;
  }
}