import 'dart:async';

import 'package:apnalog/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  final TextEditingController _search = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _company = TextEditingController();

  @override
  void initState() {
    filter();
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

  @override
  void dispose() {
    _search.dispose();
    _company.dispose();
    _name.dispose();
    animcontrol.dispose();
    super.dispose();
  }
  late AnimationController animcontrol;
  late var animation;

  filter()async{
    List<dynamic> data = await Utils.mycons();
    List<dynamic> filtered = data.where((value)=>value["username"].toString().toLowerCase().contains(_search.text.toLowerCase()) || value["company"]["name"].toString().toLowerCase().contains(_search.text.toLowerCase())).toList();
    if (_search.text.isEmpty){
      return data;
    }
    else{
      return filtered;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawer: SafeArea(
        child: Drawer(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Name"),
                subtitle: Text("gmail"),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(onTap: (){
            Scaffold.of(context).openDrawer();
          },child: Icon(Icons.account_circle,color: Colors.white,size: 36,)),
        ),
        backgroundColor: Colors.blueAccent.shade100,
        title: Text("Apna Log",style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 30))
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _search,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(30)
                ),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: "Search",
              ),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value){
                setState(() {
                  filter();
                });
              },
            ),
          ),
          FutureBuilder(future: filter(), builder: (BuildContext context,AsyncSnapshot<dynamic> snapshot){
            if (snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            else if(snapshot.hasData){
              var data = snapshot.data;
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),shrinkWrap: true,itemCount: data.length ,itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    leading: Text("${index+1}",style: TextStyle(fontSize: 20),),
                    title: Text("${data[index]["username"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    subtitle: Text("${data[index]["company"]["name"]}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  ),
                );
              });
            }
            else{
              return Text("data");
            }
          }),
        ],
      ),
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
                  padding: EdgeInsets.all(8.0),
                  child: ScaleTransition(
                    scale: animation,
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const Home()));
                    },style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black87),
                        shadowColor: WidgetStatePropertyAll(Colors.black),
                        elevation: WidgetStatePropertyAll(8),
                        fixedSize: WidgetStatePropertyAll(Size(200,30)),
                        foregroundColor: WidgetStatePropertyAll(Colors.amber)), child: const Text("Add",style: TextStyle(fontSize: 20),),
                    ),
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

