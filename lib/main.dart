import 'package:flutter/material.dart';

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
  int xScore = 0;
  int oScore = 0;
  int filledBoxes = 0;
  bool firstPlayer = true; // the first player is O
  List<String> symbol = ["", "", "", "", "", "", "", "", ""];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: <Widget>[
          Expanded(
              child: Container(
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Player X",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      xScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Player O",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      oScore.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    )
                  ],
                )
              ],
            )),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
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
          ),
          Expanded(
            child: Container(
              color: Colors.grey[600],
            ),
          )
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (firstPlayer && symbol[index] == "") {
        symbol[index] = "O";
        filledBoxes += 1;
      } else if (!firstPlayer && symbol[index] == "") {
        symbol[index] = "X";
        filledBoxes += 1;
      }
      firstPlayer = !firstPlayer;
      _checkWinner();
    });
  }

  void _checkWinner() {
    //First row
    if (symbol[0] == symbol[1] && symbol[0] == symbol[2] && symbol[0] != "") {
      _showWindDialog(symbol[0]);
      return;
    }
    //Second Row
    if (symbol[3] == symbol[4] && symbol[3] == symbol[5] && symbol[3] != "") {
      _showWindDialog(symbol[3]);
      return;
    }
    //third row
    if (symbol[6] == symbol[7] && symbol[6] == symbol[8] && symbol[6] != "") {
      _showWindDialog(symbol[6]);
      return;
    }
    //First column
    if (symbol[0] == symbol[3] && symbol[0] == symbol[6] && symbol[0] != "") {
      _showWindDialog(symbol[0]);
      return;
    }
    //Second column
    if (symbol[1] == symbol[4] && symbol[1] == symbol[7] && symbol[1] != "") {
      _showWindDialog(symbol[1]);
      return;
    }
    //Third column
    if (symbol[2] == symbol[5] && symbol[2] == symbol[8] && symbol[2] != "") {
      _showWindDialog(symbol[2]);
      return;
    }
    //Diagonal 1
    if (symbol[0] == symbol[4] && symbol[0] == symbol[8] && symbol[0] != "") {
      _showWindDialog(symbol[0]);
      return;
    }
    //diagonal 2
    if (symbol[2] == symbol[4] && symbol[2] == symbol[6] && symbol[2] != "") {
      _showWindDialog(symbol[2]);
      return;
    } else if (filledBoxes == 9) {
      _showDrawDialog();
      return;
    }
  }

  void _showWindDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(winner + "is the Winner"),
            actions: <Widget>[
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });

    if (winner == 'O') {
      oScore += 1;
    } else if (winner == "X") {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        symbol[i] = "";
      }
    });
    filledBoxes = 0;
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("GAME DRAW"),
            actions: <Widget>[
              FlatButton(
                child: Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
