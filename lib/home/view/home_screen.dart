import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';
import '../../utils/logout_confirmation_dialog.dart';
import '../model/product_card_model.dart';
import '../viewmodel/product_card_view_model.dart';
import 'components/middle_container.dart';
import 'components/product_card.dart';
import 'components/top_container.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<ProductCardModel> _filteredProducts = [];

  @override
  void initState() {
    super.initState();

    final productCardViewModel = Provider.of<ProductCardViewModel>(
      context,
      listen: false,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productCardViewModel.fetchProducts().then((_) {
        setState(() {
          _filteredProducts = productCardViewModel.products;
        });
      });
    });
  }

  List<ProductCardModel> _applySearchFilter(String query) {
    final productCardViewModel = Provider.of<ProductCardViewModel>(
      context,
      listen: false,
    );

    if (query.isEmpty) return productCardViewModel.products;

    return productCardViewModel.products
        .where(
          (product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredProducts = _applySearchFilter(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productCardViewModel = Provider.of<ProductCardViewModel>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (void didPop) async {
        await showLogoutDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hi Rubel !!!', style: TextStyle(color: Colors.white)),
          backgroundColor: kPrimaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                TopContainer(),
                SizedBox(height: 40), // Space for middle container
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Popular Items",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.brown,
                        ),
                      ),
                      TextButton(onPressed: () {}, child: Text("View all")),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        productCardViewModel.isLoading
                            ? Center(
                              child: LoadingAnimationWidget.threeRotatingDots(
                                color: kPrimaryColor,
                                size: 50,
                              ),
                            )
                            : SizedBox(
                              child: GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisExtent:
                                          220, // Fixed height per card (adjust as needed)
                                    ),
                                scrollDirection: Axis.vertical,
                                itemCount: _filteredProducts.length,
                                itemBuilder: (context, index) {
                                  final post = _filteredProducts[index];
                                  return ProductCard(product: post);
                                },
                              ),
                            ),
                  ),
                ),
              ],
            ),
            MiddleContainer(
              controller: _searchController,
              onChanged: _onSearchChanged,
            ),
          ],
        ),
      ),
    );
  }
}
