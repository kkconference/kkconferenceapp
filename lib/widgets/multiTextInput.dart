
import 'package:flutter/material.dart';
import 'package:kk_conferences/global/constants.dart';
import 'package:kk_conferences/main.dart';


class MultiLineTextInput extends StatelessWidget {
  String m_hintText;
  String m_helperText;
  String m_labelText;
  TextEditingController controller;
  TextInputType type;

  MultiLineTextInput(
      {this.m_hintText="", this.m_helperText="", this.m_labelText="", this.controller,this.type=TextInputType.multiline});



  @override
  Widget build(BuildContext context) {
    return  new TextField(
      controller: controller,
      minLines: 1,//Normal textInputField will be displayed
      maxLines: 5,// when user presses enter it will adapt to it
      keyboardType: type,
      decoration: new InputDecoration(
          border: new OutlineInputBorder(
              borderSide: new BorderSide(color:main_color)),
          hintText: m_hintText,
          helperText: m_helperText,
          labelText: m_labelText,
          prefixIcon: const Icon(
            Icons.pending_actions,
          ),
          prefixText: ' ',
          suffixIcon:InkWell(
            onTap: (){
              controller.text="";
            },
            child: InkWell(
              onTap: (){
                controller.text="";
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Icon(Icons.clear)),
              ),
            ),
          ),
          suffixStyle: const TextStyle(color: Colors.red)),
    );
  }
}
