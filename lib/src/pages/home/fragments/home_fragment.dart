import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/widgets/card/home_card.dart';
import 'package:vootech_realchat/src/widgets/ping_item_widget.dart';
import 'package:vootech_realchat/src/widgets/search_widget.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({Key key}) : super(key: key);

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.white, appBar: PreferredSize(preferredSize: Size.fromHeight(100.0), // here the desired height
        child:AppBar(elevation: 1,flexibleSpace: SafeArea(child: SingleChildScrollView(scrollDirection: Axis.vertical,child: Row(children: [PingItemWidget(name: "name"),PingItemWidget(name: "name"),PingItemWidget(name: "name")],)),),toolbarHeight: 100,backgroundColor: Colors.white,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 16),
          child: Column(
            children: <Widget>[
              SizedBox(height: 4,),
              SearchWidget(),
              SizedBox(height: 16,),
              HomeCard(name: "name", time: "time", data: "data",number: "12",),
              HomeCard(name: "name", time: "time", data: "data",number: "12",),
              HomeCard(name: "name", time: "time", data: "data",number: "12",),
              HomeCard(name: "name", time: "time", data: "data",number: "12",),
              HomeCard(name: "name", time: "time", data: "data",number: "12",),

            ],
          ),
        ),
      ),
    );
  }
}
