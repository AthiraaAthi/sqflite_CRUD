import 'package:flutter/material.dart';
import 'package:sqflite_selfff/controller/my_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyController obj = MyController();
  List mylist = [];
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    fetchdata();
    super.initState();
  }

  fetchdata() async {
    await obj.getAllData();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: obj.data.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 129, 245, 133),
                borderRadius: BorderRadius.circular(20)),
            height: 100,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(obj.data[index]["name"]),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Container(
                          child: Column(
                            children: [
                              TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                    hintText: "Enter the new title",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20))),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    await obj.editScreen(
                                      nameController.text,
                                      await obj.data[index]["id"],
                                    );
                                    nameController.clear();

                                    Navigator.pop(context);

                                    fetchdata();
                                  },
                                  child: Text("Save"))
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.edit)),
                IconButton(
                    onPressed: () async {
                      await obj.deleteScreen(obj.data[index]["id"]);
                      await obj.getAllData();
                      setState(() {});
                    },
                    icon: Icon(Icons.delete)),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                          hintText: "Enter title",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          await obj.AddScreen(
                              name: nameController.text.toString());
                          await obj.getAllData();
                          setState(() {});
                          nameController.clear();
                          Navigator.pop(context);
                          // await obj.AddScreen(name: nameController.text);
                          // await obj.getAllData();
                          // //mylist.add(nameController.text);
                          // setState(() {});
                          // nameController.clear();
                          // Navigator.pop(context);
                        },
                        child: Text("save"))
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
