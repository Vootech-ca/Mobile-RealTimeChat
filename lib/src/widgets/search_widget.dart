import 'package:flutter/material.dart';
import 'package:vootech_realchat/core/app_colors.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: AppColors.hintFontColor),
        suffixIcon: Icon(Icons.search,color: AppColors.hintFontColor, size: 20,),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
                color: Colors.white
            )
        ),
      ),
    );
  }
}
