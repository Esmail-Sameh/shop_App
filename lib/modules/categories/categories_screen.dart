import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';

import '../../models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =AppCubit.get(context).categoriesModel!.data.data;
        return ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context, index) => catBuildItem(cubit[index]),
            separatorBuilder:(context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(color: Colors.grey,height: 5,),
            ),
            itemCount: cubit.length
        );
      },
    );
  }

  Widget catBuildItem(Datum model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          height: 80,
          width: 80,
        ),
        SizedBox(width: 10,),
        Text(
          model.name,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 24.0,
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
