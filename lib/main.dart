import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 1',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        textTheme: TextTheme(
          displayLarge: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo),
          bodyLarge: TextStyle(fontSize: 16.0, color: Colors.indigo),
        ),
      ),
      home: LoginPage(),
    );
  }
}

// LoginPage
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final String correctUsername = "wyldan";
  final String correctPassword = "123";

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == correctUsername && password == correctPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau Password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.account_circle, size: 100, color: Colors.indigo),
                SizedBox(height: 20),
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon:
                                Icon(Icons.person, color: Colors.indigo),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          obscureText: true,
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            filled: true,
                            fillColor: Colors.grey[200],
                            prefixIcon: Icon(Icons.lock, color: Colors.indigo),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.indigo,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                          ),
                          onPressed: _login,
                          child: Text('Login',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
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

// MenuPage
class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Menu Utama")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            _buildMenuCard(
                context, 'Akun', Icons.group, GroupListPage()),
            _buildMenuCard(context, 'Penjumlahan', Icons.add, SumPage()),
            _buildMenuCard(
                context, 'Pengurangan', Icons.remove, SubtractionPage()),
            _buildMenuCard(context, 'Cek Ganjil/Genap', Icons.calculate,
                GanjilGenapPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(
      BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 40, color: Colors.indigo),
              SizedBox(height: 10),
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

// Anggota kelompok
class GroupListPage extends StatelessWidget {
  final List<Map<String, String>> members = [
    {"nama": "Wyldan Saharaputra H", "nim": "124220115"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Akun")),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Nama: ${members[index]['nama']}"),
              subtitle: Text("NIM: ${members[index]['nim']}"),
            ),
          );
        },
      ),
    );
  }
}

// Penjumlahan
class SumPage extends StatefulWidget {
  @override
  _SumPageState createState() => _SumPageState();
}

class _SumPageState extends State<SumPage> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String result = "";

  void _calculateSum() {
    int num1 = int.tryParse(_number1Controller.text) ?? 0;
    int num2 = int.tryParse(_number2Controller.text) ?? 0;
    setState(() {
      result = "Hasil Penjumlahan: ${num1 + num2}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Penjumlahan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _number1Controller,
              decoration: InputDecoration(
                labelText: 'Angka Pertama',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _number2Controller,
              decoration: InputDecoration(
                labelText: 'Angka Kedua',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSum,
              child: Icon(Icons.add, size: 40, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20, backgroundColor: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}

// Pengurangan
class SubtractionPage extends StatefulWidget {
  @override
  _SubtractionPageState createState() => _SubtractionPageState();
}

class _SubtractionPageState extends State<SubtractionPage> {
  final TextEditingController _number1Controller = TextEditingController();
  final TextEditingController _number2Controller = TextEditingController();
  String result = "";

  void _calculateSubtraction() {
    int num1 = int.tryParse(_number1Controller.text) ?? 0;
    int num2 = int.tryParse(_number2Controller.text) ?? 0;
    setState(() {
      result = "Hasil Pengurangan: ${num1 - num2}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pengurangan")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _number1Controller,
              decoration: InputDecoration(
                labelText: 'Angka Pertama',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _number2Controller,
              decoration: InputDecoration(
                labelText: 'Angka Kedua',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSubtraction,
              child: Icon(Icons.remove, size: 40, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20, backgroundColor: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}

// Ganjil atau Genap
class GanjilGenapPage extends StatefulWidget {
  @override
  _GanjilGenapPageState createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController _numberController = TextEditingController();
  String result = "";

  void _checkOddEven() {
    int number = int.tryParse(_numberController.text) ?? 0;
    setState(() {
      if (number % 2 == 0) {
        result = "$number adalah Genap";
      } else {
        result = "$number adalah Ganjil";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cek Ganjil/Genap")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _numberController,
              decoration: InputDecoration(
                labelText: 'Masukkan Angka',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkOddEven,
              child: Icon(Icons.check, size: 40, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.all(15),
              ),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20, backgroundColor: Colors.amber),
            ),
          ],
        ),
      ),
    );
  }
}