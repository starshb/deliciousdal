import 'package:deliciousdal/common/const/colors.dart';
import 'package:deliciousdal/common/layout/default_layout.dart';
import 'package:deliciousdal/product/component/product_card.dart';
import 'package:deliciousdal/restaurant/component/restaurant_card.dart';
import 'package:deliciousdal/restaurant/model/restaurant_detail_model.dart';
import 'package:deliciousdal/restaurant/model/restaurant_model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../common/const/data.dart';

class RestaurantDetailScreen extends StatefulWidget {
  RestaurantModel model;

  RestaurantDetailScreen({
    required this.model,
    super.key,
  });

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  int counter = 0;

  Future<dynamic> getFood() async {
    final resp =
        await client.from('food').select().eq('store_id', widget.model.id);
    return resp;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: widget.model.name,
      floatingActionButton: FloatingActionButton(
        child: badges.Badge(
          badgeContent: Text(counter.toString()),
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.white,
          ),
          showBadge: counter > 0 ? true : false,
          position: badges.BadgePosition.topEnd(
            top: -20,
            end: -20,
          ), //top= y,
          child: Icon(Icons.shopping_cart_outlined),
        ),
        backgroundColor: SECOND_COLOR,
        onPressed: () {},
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantCard.fromModel(
              model: widget.model,
              isDetail: true,
            ),
            renderLabel(),
            Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FutureBuilder<dynamic>(
                    future: getFood(),
                    builder: (context, AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) {
                          final item = snapshot.data![index];
                          final pItem = RestaurantFoodModel.fromJson(
                            json: item,
                          );

                          return InkWell(
                            onTap: () {
                              counter++;
                              setState(() {});
                            },
                            child: ProductCard.fromModel(
                              model: pItem,
                            ),
                          );
                        },
                        separatorBuilder: (_, index) {
                          return SizedBox(
                            height: 16.0,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderLabel() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        '메뉴',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
