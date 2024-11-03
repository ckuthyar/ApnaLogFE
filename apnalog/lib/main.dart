import 'dart:async';

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

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  final TextEditingController _email = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  late AnimationController animcontrol;
  late var animation;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    animcontrol=AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation=Tween(end: 1.1,begin: 1.0).animate(
      CurvedAnimation(parent: animcontrol, curve: Curves.bounceInOut)
    )..addStatusListener((status){
      if(status==AnimationStatus.completed){
        animcontrol.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        animcontrol.forward();
      }
    }
    );
    animcontrol.forward();
  }

  @override
  void dispose() {
    _email.dispose();
    _otp.dispose();
    super.dispose();
  }

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
                        child: Text("register",style: TextStyle(fontStyle: FontStyle.italic,color: Colors.indigo,decoration: TextDecoration.underline)),
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
                      child: ScaleTransition(
                        scale: animation,
                        child: ElevatedButton(
                          onPressed: (){
                        },style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.black87),
                            shadowColor: WidgetStatePropertyAll(Colors.black),
                            fixedSize: WidgetStatePropertyAll(Size(200,30)),
                            elevation: WidgetStatePropertyAll(40),
                            foregroundColor: WidgetStatePropertyAll(Colors.amber)), child: const Text("Get Otp",style: TextStyle(fontSize: 20),),
                        ),
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
