import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class WriteMessage extends StatelessWidget {
  const WriteMessage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Icon(Icons.add, color: AppColors.primaryColor, size: 22, ),
                  ),
                ),
                SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: AppColors.hintFontColor),
                        border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(width: 15,),
                FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: (){},
                  child: Icon(Icons.send,color: AppColors.primaryColor,size: 22,),
                  elevation: 0,
                ),
              ],

            ),
          ),
        ),
      ],
    );
  }
}
