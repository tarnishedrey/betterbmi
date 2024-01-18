import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  bool isLoading = false;
  String _gender = 'Laki-Laki';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double _bmi = 0.0;
  String _bmiCategory = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        leading: Icon(Icons.accessibility_new),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _heightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Tinggi (cm)',
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tinggi harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _weightController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Berat (kg)',
                    contentPadding: EdgeInsets.all(12.0),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Berat harus diisi';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Laki-Laki',
                          groupValue: widget._gender,
                          onChanged: (String? value) {
                            setState(() {
                              widget._gender = value!;
                            });
                          },
                        ),
                        Text('Laki-Laki'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Radio<String>(
                          value: 'Perempuan',
                          groupValue: widget._gender,
                          onChanged: (String? value) {
                            setState(() {
                              widget._gender = value!;
                            });
                          },
                        ),
                        Text('Perempuan'),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                widget.isLoading
                    ? Column(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          // Validate the form
                          if (_formKey.currentState?.validate() ?? false) {
                            // Set loading state
                            setState(() {
                              widget.isLoading = true;
                            });

                            double height =
                                double.parse(_heightController.text);
                            double weight =
                                double.parse(_weightController.text);

                            // Simulate asynchronous operation (replace with your actual logic)
                            await Future.delayed(Duration(seconds: 2));

                            setState(() {
                              // Different BMI calculation based on gender
                              if (widget._gender == 'Laki-Laki') {
                                _bmi =
                                    weight / ((height / 100) * (height / 100));
                              } else if (widget._gender == 'Perempuan') {
                                _bmi = weight /
                                    ((height / 100) * (height / 100)) *
                                    1.1;
                              }

                              // Different BMI category determination based on gender
                              if (_bmi < 18.5) {
                                _bmiCategory = 'Kekurusan';
                              } else if (_bmi >= 18.5 && _bmi < 24.9) {
                                _bmiCategory = 'Ideal';
                              } else if (_bmi >= 25.0 && _bmi < 29.9) {
                                _bmiCategory = 'Overweight';
                              } else {
                                _bmiCategory = 'Obesitas';
                              }

                              // Reset loading state
                              widget.isLoading = false;
                            });
                          }
                        },
                        child: Text('Hitung'),
                      ),
                SizedBox(height: 16),
                _bmi > 0
                    ? Column(
                        children: [
                          Text(
                            'BMI: ${_bmi.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Kategori: $_bmiCategory',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
