import 'package:database/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/dbhelper.dart';

class First_Screen extends StatefulWidget {
  const First_Screen({Key? key}) : super(key: key);

  @override
  State<First_Screen> createState() => _First_ScreenState();
}

class _First_ScreenState extends State<First_Screen> {

  Home_Controller home_controller = Get.put(Home_Controller(),);

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData()async{
    DbHelper db = DbHelper();
    home_controller.StdList.value = await db.readData();

  }

  TextEditingController txtName = TextEditingController();
  TextEditingController txtMoblie = TextEditingController();
  TextEditingController txtstd = TextEditingController();

  TextEditingController utxtName = TextEditingController();
  TextEditingController utxtMoblie = TextEditingController();
  TextEditingController utxtstd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("Student Data"),
            actions: [
              ],
          ),
          body: Obx(()=>
           ListView.builder(
             itemCount: home_controller.StdList.value.length,
             itemBuilder: (context,index){
               return ListTile(
                 leading: Text("${home_controller.StdList.value[index]['id']}"),
                 title: Text("${home_controller.StdList.value[index]['name']}"),
                 subtitle: Text("${home_controller.StdList.value[index]['mobile']}"),
                 trailing:  Container(
                   width: 100,
                   child: Row(
                     children: [
                       IconButton(onPressed: (){
                         utxtName =TextEditingController(text: "${home_controller.StdList.value[index]['name']}");
                         utxtMoblie =TextEditingController(text: "${home_controller.StdList.value[index]['mobile']}");
                         utxtstd =TextEditingController(text: "${home_controller.StdList.value[index]['std']}");

                         Get.defaultDialog(
                           content: Column(
                              children: [
                                TextField(
                                    controller: utxtName,decoration: InputDecoration(hintText: "Name",),),
                                TextField(
                                  controller: utxtMoblie,decoration: InputDecoration(hintText: "Moblie",),),
                                   TextField(
                                  controller: utxtstd,decoration: InputDecoration(hintText: "std",),),
                                SizedBox(height: 10,),
                                ElevatedButton(onPressed: (){
                                  DbHelper dp = DbHelper();
                                  dp.updatedata("${home_controller.StdList.value[index]['id']}",utxtName.text, utxtMoblie.text,utxtstd.text,);
                                  getData();
                                } ,child:Text("update") ),
                              ],
                           ),
                         );
                       },
                           icon: Icon(Icons.edit)),
                       IconButton(onPressed: (){
                         DbHelper dp = DbHelper();
                         dp.deletedata("${home_controller.StdList.value[index]['id']}");
                         getData();
                       }, icon:Icon(Icons.delete)),
                     ],
                   ),
                 ),
               );
             },
           )
          ),
          floatingActionButton:FloatingActionButton(
            onPressed: (){
             Get.defaultDialog(
               title: "Student",
               content: Column(
                 children: [
                   TextField(controller: txtName,decoration: InputDecoration(hintText: "Name",),),
                   TextField(controller: txtMoblie,decoration: InputDecoration(hintText: "Moblie",),),
                   TextField(controller: txtstd,decoration: InputDecoration(hintText: "std",),),
                   SizedBox(height: 10,),
                   ElevatedButton(onPressed: (){
                     DbHelper  DB = DbHelper();
                     DB.insertData(txtName.text,txtMoblie.text,txtstd.text);
                     getData();
                     txtName.clear();
                     txtstd.clear();
                     txtMoblie.clear();
                     Get.back();
                   },
                       child: Text("Submit")),
                 ],
               ),
             );
           },
            child: Icon(Icons.add),
          ),
        ));

  }
}
