import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../init_screen.dart';
import '../../utils/constants.dart';
import '../../utils/expandable_text.dart';
import '../model/product_detail_model.dart';
import '../service/ProductDetailService.dart';

class ProductDetailScreen extends StatefulWidget {
  static String routeName = '/product_detail';
  final int productId;

  const ProductDetailScreen({required this.productId, Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<ProductDetailModel> productDetail;
  final ProductDetailService _service = ProductDetailService();

  @override
  void initState() {
    super.initState();
    productDetail = _service.fetchProductDetail(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (void didPop) async {
        Navigator.pushReplacementNamed(context, InitScreen.routeName);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: const [
                  Icon(CupertinoIcons.heart_fill),
                  SizedBox(width: 8),
                  Icon(Icons.share, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        body: FutureBuilder<ProductDetailModel>(
          future: productDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No Data Found'));
            } else {
              final product = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: Image.network(
                        product.images[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: kPrimaryBodyColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 150),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  product.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.brown,
                                    fontSize: 28,
                                    fontFamily: "Mulish",
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "\$${product.price}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    "\$${product.discountPercentage}",
                                    style: const TextStyle(
                                      color: Colors.brown,
                                      fontSize: 22,
                                      fontFamily: "Mulish",
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              RatingBarIndicator(
                                rating: product.rating,
                                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${product.rating}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Mulish",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.brown,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Brand",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product.brand,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Category",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            product.category,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Description",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ExpandableText(
                            text: "${product.description} ${product.description} ${product.description}",
                            trimLines: 4,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            debugPrint("Add to Cart clicked");
          },
          backgroundColor: Colors.brown,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.shopping_cart),
          label: const Text(
            "Add to Cart",
            style: TextStyle(
              fontFamily: "Mulish",
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
