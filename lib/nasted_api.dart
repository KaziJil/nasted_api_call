import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiCall extends StatefulWidget {
  const ApiCall({Key? key}) : super(key: key);

  @override
  _ApiCallState createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  var data;
  Future<void>getCallApi() async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode==200){
      data=jsonDecode(response.body.toString());
    }else{

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nasted Api Call"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getCallApi(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.waiting){
                  return CircularProgressIndicator();

                }else{
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [

                                ReUsableRow(title: "Name:", value: data[index]["name"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Username:", value: data[index]["username"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Email:", value: data[index]["email"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Address:", value: data[index]["address"]["street"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Suite:", value: data[index]["address"]["suite"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "City:", value: data[index]["address"]["city"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Zipcode:", value: data[index]["address"]["zipcode"].toString()),
                                SizedBox(width: 10,height: 10,),
                                ReUsableRow(title: "Geo:", value: data[index]["address"]["geo"].toString()),
                                SizedBox(width: 10,height: 10,),




                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}


class ReUsableRow extends StatelessWidget {
  String title, value;
  ReUsableRow({Key? key, required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(value )
      ],
    );
  }
}


