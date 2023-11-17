import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  static String routName = 'searchScreen';

  var searchController = TextEditingController();
  var searchKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              child: defaultTextFile(
                key: searchKey,
                onSubmitted: (value) {
                  if(searchKey.currentState!.validate()){
                    print(searchController.text);
                  }
                },
                lable: 'Search',
                prefixIcon: Icons.search_rounded,
                controller: searchController ,
                inputType: TextInputType.text,
                validator: (value) {
                  if(searchController.text.isEmpty){
                    return 'Please Enter any words';
                  }
                },


              ),
            )
          ],
        ),
      ),
    );
  }
}
