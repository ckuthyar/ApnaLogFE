import 'package:apnalog/utils.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final TextEditingController _search = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _company = TextEditingController();

  static List<String> list1 = ["Name","Company"];
  String db1=list1.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _search,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
              prefixIcon: const Icon(Icons.search),
              hintText: "Search",
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        actions: [
          DropdownButton(value: db1,
              items: list1.map<DropdownMenuItem<String>>((String values){
            return DropdownMenuItem(value: values,child: Text(values));
          }).toList(), onChanged: (value){
            setState(() {
              db1=value!;
            });
          })
        ],
      ),
      body: FutureBuilder(future: Utils.verify(), builder: (BuildContext context, snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if(snapshot.hasError){
          return const Text("data");
        }
        else if(snapshot.hasData){
          var data = snapshot.data;
          return ListView.builder(itemBuilder: (context,index){
            return const ListTile(
              title: Text("data"),
              subtitle: Text("data"),
            );
          });
        }
        else{
          return const Text("data");
        }
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Add Contacts",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      hintText: "Name",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _company,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                      ),
                      hintText: "Company",
                    ),
                    keyboardType: TextInputType.text,
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
                  ), child: const Text("Add",style: TextStyle(fontSize: 20),),
                  ),
                ),
              ],
            );
          });
        }, label: const Text("Add"),
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}

