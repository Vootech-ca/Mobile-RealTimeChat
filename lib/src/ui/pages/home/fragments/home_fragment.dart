import 'package:flutter/material.dart';
import 'package:vootech_realchat/src/ui/pages/users/users_list_page.dart';
import 'package:vootech_realchat/src/ui/widgets/card/home_card.dart';
import 'package:vootech_realchat/src/ui/widgets/ping_item_widget.dart';
import 'package:vootech_realchat/src/ui/widgets/search_widget.dart';

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
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UsersListPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text("Search...", style: TextStyle(color: Colors.grey, fontSize: 12)),
                            )),
                        Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Icon(Icons.search, size: 24, color: Colors.pinkAccent),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
