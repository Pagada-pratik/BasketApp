import 'package:flutter/material.dart';

import '../../resources/constants.dart';

class ProductDataView extends StatelessWidget {
  final String title;
  final String description;
  const ProductDataView(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: AppConstants.defaultPadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 40,
                      child: BackButton(),
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppConstants.defaultPadding),
                child: Text(
                  description,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}