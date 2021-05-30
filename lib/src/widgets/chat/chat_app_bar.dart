import 'package:flutter/material.dart';

class ChatAppBar extends StatelessWidget {
  const ChatAppBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 16),
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,),
          ),
          SizedBox(width: 2,),
          CircleAvatar(
            backgroundImage: NetworkImage("https://miro.medium.com/max/1090/1*UNf6kxqv_ujIjKoMI0q97A.png"),
            maxRadius: 20,
          ),
          SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("joli",style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                SizedBox(height: 6,),
                Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
