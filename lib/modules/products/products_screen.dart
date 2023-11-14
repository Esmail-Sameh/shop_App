import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_cubit.dart';
import 'package:shop_app/shared/cubit/app_cubit/app_status.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.homeModel != null,
          builder: (context) => productsBuilder(cubit.homeModel!),
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

  Widget productsBuilder(HomeModel model) => SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map((e) => Image.network(
                        '${e['image']}',
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
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.7,
                children: List.generate(model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index])),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(dynamic model) => Container(
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
                      '${model['image']}',
                    ),
                    height: 200,
                    width: double.infinity,
                  ),
                  if (model['discount'] == 0)
                  Container(
                    color: Colors.red,
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Text(
                '${model['name']}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14, height: 1.3),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '${model['price']}',
                    style: TextStyle(color: defaultColor, fontSize: 14),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (model['discount'] == 0)
                    Text(
                      '${model['old_price']}',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      print('is favorit');
                    },
                    icon: Icon(
                      Icons.favorite_border_outlined,
                      size: 15,
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
