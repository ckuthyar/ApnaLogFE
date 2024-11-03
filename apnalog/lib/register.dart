import 'dart:async';

import 'package:apnalog/home.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FillForm(),
    );
  }
}

class FillForm extends StatefulWidget {
  const FillForm({super.key});

  @override
  State<FillForm> createState() => _FillFormState();
}

class _FillFormState extends State<FillForm> with SingleTickerProviderStateMixin{

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _name.dispose();
    _phone.dispose();
    super.dispose();
  }
  late AnimationController animcontrol;
  late var animation;
  @override
  void initState() {
    super.initState();
    animcontrol = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    animation = Tween<double>(begin: 1.0,end: 1.1).animate(
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

  final _formKey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Form(
              key: _formKey1,
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
                        controller: _name,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          prefixIcon: const Icon(Icons.account_circle),
                          hintText: "Name",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextFormField(
                        controller: _phone,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                          prefixIcon: const Icon(Icons.phone),
                          hintText: "Mobile number",
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ScaleTransition(
                        scale: animation,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                        },style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(Colors.black87),
                            shadowColor: WidgetStatePropertyAll(Colors.black),
                            elevation: WidgetStatePropertyAll(8),
                            fixedSize: WidgetStatePropertyAll(Size(200,30)),
                            foregroundColor: WidgetStatePropertyAll(Colors.amber)), child: const Text("Register",style: TextStyle(fontSize: 20),),
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
