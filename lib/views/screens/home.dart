import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gmn/views/providers/store_provider.dart';
import 'package:gmn/views/providers/trainee_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? title;

  const Home({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Provider.of<TraineeProvider>(context, listen: false).getTrainee();
    Provider.of<StoreProvider>(context, listen: false).getAllProducts();
    // context.read<TraineeProvider>().getTrainee();
    // return Consumer<TraineeProvider>(builder: (context, value, child) {
    // value.getTrainee();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer<StoreProvider>(
              builder: (context, provider, child) {
                if (provider.products != null) {
                  return Column(
                    children: [
                      Text(provider.products.toString()),
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://thebrandhopper.com/wp-content/uploads/2021/10/Product-Innovation.jpg",
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TraineeProvider>().getTrainee();
              },
              child: Container(
                decoration: const BoxDecoration(color: Colors.black),
                child: const SizedBox(
                  height: 100,
                  width: 200,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
