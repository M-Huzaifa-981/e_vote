import 'package:e_vote/testing.dart';
import 'package:e_vote/views/home_screen.dart';
import 'package:flutter/material.dart';

class Main2 extends StatefulWidget {
  const Main2({super.key});

  @override
  State<Main2> createState() => _Main2State();
}

class _Main2State extends State<Main2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Branch"),),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                  },
                  child: Text("Screen1")
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Test()));
                  },
                  child: Text("Test")
              ),
            )
          ],
        ),
      ),
    );

  }
}
