import 'package:flutter/material.dart';
import 'winnerCheck.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstPlayer = true; // the first player is O
  List<String> symbol = ["", "", "", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                onTap: () {
                  _tapped(index);
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[700])),
                    child: Center(
                      child: Text(
                        symbol[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                        ),
                      ),
                    )),
              ),
            );
          }),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (firstPlayer) {
        symbol[index] = "O";
      } else {
        symbol[index] = "X";
      }
      firstPlayer = false;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //First row
    if (symbol[0] == symbol[1] && symbol[0] == symbol[2] && symbol[0] != "") {
      _showWindDialog();
    }
    //Second Row
    if (symbol[3] == symbol[4] && symbol[3] == symbol[5] && symbol[3] != "") {
      _showWindDialog();
    }
    //third row
    if (symbol[6] == symbol[7] && symbol[6] == symbol[8] && symbol[6] != "") {
      _showWindDialog();
    }
    //First column
    if (symbol[0] == symbol[3] && symbol[0] == symbol[6] && symbol[0] != "") {
      _showWindDialog();
    }
    //Second column
    if (symbol[1] == symbol[4] && symbol[1] == symbol[7] && symbol[1] != "") {
      _showWindDialog();
    }
    //Third column
    if (symbol[2] == symbol[5] && symbol[2] == symbol[8] && symbol[2] != "") {
      _showWindDialog();
    }
    //Diagonal 1
    if (symbol[0] == symbol[4] && symbol[0] == symbol[8] && symbol[0] != "") {
      _showWindDialog();
    }
    //diagonal 2
    if (symbol[2] == symbol[4] && symbol[2] == symbol[6] && symbol[2] != "") {
      _showWindDialog();
    }
  }

  void _showWindDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Winner"),
          );
        });
  }
}
