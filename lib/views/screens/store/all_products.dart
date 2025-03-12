import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gmn/data/models/content/store/product.dart';
import 'package:gmn/values/app_router.dart';
import 'package:gmn/values/colors.dart';
import 'package:gmn/views/providers/program_store_provider.dart';
import 'package:gmn/views/providers/user_provider.dart';
import 'package:gmn/views/widgets/dialogs/show_loading_dialog.dart';
import 'package:gmn/views/widgets/dialogs/content/show_product_dialog.dart';
import 'package:gmn/views/widgets/scoop_app/scaffold.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductsIndex extends StatelessWidget {
  const ProductsIndex({super.key});

  @override
  Widget build(BuildContext context) {
    String? token = context.read<UserProvider>().user!.token;
    if (context.read<ProgramStoreProvider>().products == null) {
      context.read<ProgramStoreProvider>().getAllProducts(token!);
    }

    return AppScaffold.build(context, _body(), screenTitle: "Products");
  }

  _body() {
    BuildContext context = AppRouter.navKey.currentContext!;
    String? token = context.read<UserProvider>().user!.token;

    return Consumer<ProgramStoreProvider>(
      builder: (context, provider, child) {
        if (provider.products == null) {
          return const Center(child: Text("Nothing Arrived Yet.."));
        }
        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(12.sp),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14.sp,
                  mainAxisSpacing: 14.sp,
                  childAspectRatio: 1.2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index == provider.products!.items!.length) {
                      return provider.products!.next == null
                          ? const Center(
                              child: Text(
                                "No more!",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 12,
                                  color: AppColors.background,
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () async {
                                showLoadingDialog();
                                await context
                                    .read<ProgramStoreProvider>()
                                    .getProductsNextPage(token!);
                                AppRouter.popFromWidget();
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 150.sp,
                                padding: EdgeInsets.all(12.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12.sp)),
                                    color: Colors.blue),
                                child: const Text(
                                  "More..",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: Colors.white),
                                ),
                              ),
                            );
                    }
                    return _productItem(provider.products!.items![index]);
                  },
                  childCount: provider.products!.items!.length + 1,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _productItem(Product product) {
    return InkWell(
      onTap: () => showProductDialog(product),
      child: Container(
        // margin: EdgeInsets.only(top: 18.sp),
        height: 140.sp,
        width: 175.sp,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(130, 32, 106, 210),
              Color.fromARGB(150, 124, 17, 177)
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.sp)),
              child: SizedBox(
                height: 109.sp,
                width: 175.sp,
                child: Image.network(
                  product.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              product.productName.toString().length > 12
                  ? "${product.productName.toString().substring(0, 9)}.."
                  : product.productName.toString(),
              style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.theme1,
                  height: 2.sp),
            ),
          ],
        ),
      ),
    );
  }
}
