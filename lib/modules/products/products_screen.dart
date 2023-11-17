import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';
import 'package:shop_app/shared/styles/colors.dart';
import '../../models/categories_model.dart';


class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if(state is AppChangeFavoriteSuccessState){
          if(state.model.status == false){
            showToast(
                text: state.model.message,
                state: ToastState.ERROR
            );
          }else{
            showToast(
                text: state.model.message,
                state: ToastState.SUCCESS
            );
          }
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null && cubit.categoriesModel != null,
          builder: (context) =>
              productsBuilder(cubit.homeModel!, cubit.categoriesModel! ,context),
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

  Widget productsBuilder(HomeModel hModel, CategoriesModel cModel , context  ) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: hModel.data.banners
                  .map((e) => Image.network(
                        e.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildCategoriesItem(cModel.data.data[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 10,
                            ),
                        itemCount: cModel.data.data.length
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.68,
                children: List.generate(hModel.data.products.length,
                    (index) => buildGridProduct(hModel.data.products[index] , context ) ),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(Datum model) => Container(
        height: 100,
        width: 100,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image(
              image: NetworkImage(
                model.image
                  ),
              height: 100,
            ),
            Container(
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5) , bottomRight: Radius.circular(5)),
                color: Colors.black.withOpacity(.6),
              ),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Products model , context) => Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image(
                    image: NetworkImage(
                      // '${model['image']}',
                      model.image
                    ),
                    height: 200,
                    width: double.infinity,
                  ),
                  if (model.discount == 0)
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
                height: 10,
              ),
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    //'${model['price']}',
                    '${model.price}',
                    style: TextStyle(color: defaultColor, fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model.discount == 0)
                    Text(
                      //'${model['old_price']}',
                      '${model.oldPrice}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).changeFavoritesIcon(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15,
                        //backgroundColor: model['in_favorites'] ? defaultColor : Colors.grey ,
                        backgroundColor: AppCubit.get(context).favorites[model.id]! ? defaultColor : Colors.grey ,
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
      );
}
