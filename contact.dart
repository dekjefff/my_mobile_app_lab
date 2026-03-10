import 'package:flutter/material.dart';

class ContactView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20), 
          CircleAvatar(
            backgroundImage: AssetImage('assets/dekjefff.jpg'),
            radius: 100,
          ),
          Text(
            'Jeffrey Phillips',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            'Mahidol University',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 30.0,
              color: Colors.indigo,
            ),
          ),
          _buildInfoCard(Icons.email_rounded, 'Email: jaffephillips@gmail.com'),
          _buildInfoCard(Icons.alternate_email, 'Line ID: jaffe12344'),
          Text('Contact Me (:'),
        ],
      ),
    );
  }


  Widget _buildInfoCard(IconData icon, String text) {
    return Container(
      color: Colors.blueAccent[100],
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10.0),
          Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}