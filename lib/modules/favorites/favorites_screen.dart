import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';
import '../../models/get_favorites_model.dart';
import '../../shared/cubit/app_cubit/app_cubit.dart';
import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state != AppLodingGetFavoriteState,
          builder: (context) => ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context, index) => buildFavoritesItem(AppCubit.get(context).getFavorites!.data.data[index] , context),
              separatorBuilder:(context, index) => Divider(),
              itemCount: AppCubit.get(context).getFavorites!.data.data.length
          ),
          fallback: (context) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Loding....'),
                ],
              )),
        );
      },
    );
  }

  Widget buildFavoritesItem(Datum model , context) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      model.product.image,
                      // model.image
                    ),
                    height: 100,
                    width: 100,
                  ),
                  if (model.product.discount == 0)
                    Container(
                      color: Colors.red,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(fontSize: 8, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      model.product.name,
                      // model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, height: 1.3),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '${model.product.price}',
                          style: TextStyle(color: defaultColor, fontSize: 14),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        if (model.product.discount == 0)
                          Text(
                            '${model.product.oldPrice}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough),
                          ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                               AppCubit.get(context).changeFavoritesIcon(model.product.id);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              //backgroundColor: model['in_favorites'] ? defaultColor : Colors.grey ,
                              backgroundColor: AppCubit.get(context).favorites[model.product.id]! ? defaultColor : Colors.grey ,
                              child: Icon(
                                Icons.favorite_border_outlined,
                                color: Colors.white,
                                size: 15,
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
