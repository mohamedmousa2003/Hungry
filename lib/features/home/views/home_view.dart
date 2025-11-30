import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/api_error.dart';
import '../../../shared/custom_snack.dart';
import '../../auth/data/auth_repo.dart';
import '../../auth/data/user_model.dart';
import '../../productDetail/views/product_details_view.dart';
import '../data/model/product_model.dart';
import '../data/product_repo.dart';
import '../widget/card_item.dart';
import '../widget/search_field.dart';
import '../widget/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> category = ['All', 'Combo', 'Sliders', 'Classic', 'Hot'];
  int selectedIndex = 0;
  UserModel? userModel;
  List<ProductModel>? products;
  List<ProductModel>? filteredProducts;

  TextEditingController searchController = TextEditingController();
  ProductRepo productRepo = ProductRepo();

  final AuthRepo authRepo = AuthRepo();
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      if (!mounted) return;
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) errorMsg = e.message;
      showErrorBanner(context, errorMsg);
    }
  }
  // ------------------ تحميل المنتجات ------------------
  Future<void> getProducts() async {
    final res = await productRepo.getProducts();
    if (!mounted) return;

    setState(() {
      products = res;
      filteredProducts = res;
    });
  }

  // ------------------ الفلترة ------------------
  void filterProducts(String query) {
    if (query.isEmpty) {
      setState(() => filteredProducts = products);
      return;
    }

    setState(() {
      filteredProducts = products!
          .where((p) =>
      p.name.toLowerCase().contains(query.toLowerCase()) ||
          p.desc.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getProfileData();
    getProducts();  // تحميل المنتجات
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    double headerHeight = mediaQuery.height * 0.3;
    double gridChildAspect = mediaQuery.width / (mediaQuery.height * 0.90);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            clipBehavior: Clip.none,
            slivers: [
              // ------------------ Header ------------------
              SliverAppBar(
                elevation: 0,
                pinned: true,
                floating: false,
                toolbarHeight: headerHeight,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,

                flexibleSpace: Padding(
                  padding: EdgeInsets.only(
                    top: mediaQuery.height * 0.08,
                    right: 20,
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      UserHeader(
                        name: userModel?.name ?? "",
                        image: userModel?.image ?? "",
                      ),
                      const Gap(20),
                      SearchField(
                        controller: searchController,
                        onSearchChanged: filterProducts,
                      ),
                    ],
                  ),
                ),
              ),

              // ------------------ المنتجات ------------------
              SliverPadding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: gridChildAspect,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final product = filteredProducts?[index];
                      if (product == null) {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }

                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) =>
                                ProductDetailsView(
                                    productImage: product.image,
                                  price: product.price,
                                  productId: product.id,

                                ),
                          ),
                        ),
                        child: CardItem(
                          text: product.name,
                          image: product.image,
                          desc: product.desc,
                          rate: product.rate,
                        ),
                      );
                    },
                    childCount: filteredProducts?.length ?? 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
