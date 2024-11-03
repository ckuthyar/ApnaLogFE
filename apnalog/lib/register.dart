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

class _FillFormState extends State<FillForm> {

  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();

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
                      child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                      },style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black87),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                        elevation: WidgetStatePropertyAll(8),
                        foregroundColor: WidgetStatePropertyAll(Colors.amber),
                      ), child: const Text("Register",style: TextStyle(fontSize: 20),),
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
