import 'package:flutter/material.dart';
import 'package:shop_app/shared/components/components.dart';

class Test extends StatelessWidget {
  static var routName = 'testscreen';
  var controller = TextEditingController();
  var formKey = GlobalKey<FormFieldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            defaultTextFile(
              key: formKey,
                lable: 'test',
                prefixIcon: Icons.text_decrease,
                controller: controller,
                inputType: TextInputType.text,
              validator: (value) {
                if (value!.isEmpty){
                  return 'moust mot';
                }
                return '';
              },
            ),

            TextFormField(
              validator: (value) {
                if(value!.isEmpty){
                  return 'moust not ';
                }
              },

            ),




          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(formKey.currentState!.validate()){
              print('not empty');
            }
          }
      ),
    );
  }
}
