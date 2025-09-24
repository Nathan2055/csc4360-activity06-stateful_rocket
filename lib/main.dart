import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Rocket Launch Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      // A widget that will be started on the application startup
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  //set counter value
  int _counter = 0;

  //set rocket color
  Color DisplayColor() {
    if (_counter == 0) {
      return Colors.red;
    } else if (_counter > 50) {
      return Colors.green;
    } else {
      return Colors.orange;
    }
  }

  void IgniteButtonLogic(BuildContext context) {
    if (_counter < 100) {
      setState(() {
        _counter++;
      });
    }
    if (_counter == 100) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('IGNITION!!!'),
          content: const Text('We have liftoff! Congratulations!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      //set up the widget alignement
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: DisplayColor(),
              child: Text(
                _counter == 100 ? 'LIFTOFF!' : '$_counter',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Slider(
            min: 0,
            max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              setState(() {
                _counter = value.toInt();
              });
            },
            activeColor: Colors.blue,
            inactiveColor: Colors.red,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => IgniteButtonLogic(context),
            child: Text('Ignite'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (_counter != 0) {
                  _counter--;
                }
              });
            },
            child: Text('Decrement'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter = 0;
              });
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }
}
