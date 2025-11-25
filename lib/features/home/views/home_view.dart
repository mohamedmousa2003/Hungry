import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../productDetail/views/product_details_view.dart';
import '../widget/card_item.dart';
import '../widget/food_catrgory.dart';
import '../widget/search_field.dart';
import '../widget/user_header.dart';
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic', 'Hot'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Gap(mediaQuery.height * 0.06),
              const UserHeader(),
              Gap(mediaQuery.height * 0.03),
              const SearchField(),
              Gap(mediaQuery.height * 0.03),
              FoodCategory(
                category: category,
                selectedIndex: selectedIndex,
              ),
              Gap(mediaQuery.height * 0.05),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.only(bottom: mediaQuery.height * 0.13),
                  itemCount: 6,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsView();
                            },)
                        );
                      },
                      child: CardItem(
                        text: "Cheeseburger",
                        image:
                        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&auto=format&fit=crop&q=60",
                        desc: "Wendy's Burger",
                        rate: "4.9",
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
