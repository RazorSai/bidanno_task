import 'package:bidanno_task/phones/phones_page.dart';
import 'package:flutter/material.dart';

import 'laptops/laptops_page.dart';

class CategorySelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Categories",
          style: TextStyle(
            fontSize: 20.0
          )
        )
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "Phones",
            ),
            onTap: (){
              openWidget(context, PhonesPage());
            },
          ),
          ListTile(
            title: Text(
                "Laptops"
            ),
            onTap: (){
              openWidget(context, LaptopsPage());
            },
          )
        ],
      ),
    );
  }

  void openWidget(BuildContext context, Widget widget){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context){
        return widget;
      }
    ));
  }

}
