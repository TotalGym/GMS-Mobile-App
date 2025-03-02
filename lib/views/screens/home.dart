import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gmn/views/providers/trainee_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  final String? title;

  const Home({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    Provider.of<TraineeProvider>(context, listen: false).getTrainee();
    // context.read<TraineeProvider>().getTrainee();
    // return Consumer<TraineeProvider>(builder: (context, value, child) {
    // value.getTrainee();
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Consumer<TraineeProvider>(
            builder: (context, provider, child) {
              return Text(provider.trainees.toString());
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
      )),
    );
  }
}
