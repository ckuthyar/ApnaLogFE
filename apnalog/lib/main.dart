import 'package:apnalog/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/Apna_log.png"),
                      radius: 200,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: _email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          prefixIcon: const Icon(Icons.email_sharp),
                          hintText: "Email",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    InkWell(
                        child: const Text("didn't registered yet? register hear"),
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const FillForm()));
                      },
                    ),
                    _otp.text.isEmpty?Container():Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: _otp,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          hintText: "Otp",
                          prefixIcon: const Icon(Icons.key),
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed: (){
                      },style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black87),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                        elevation: WidgetStatePropertyAll(8),
                        foregroundColor: WidgetStatePropertyAll(Colors.amber),
                      ), child: const Text("Get Otp",style: TextStyle(fontSize: 20),),
                      ),
                    ),
                  ],
                ),
              )
          ),
        )
    );
  }
}
