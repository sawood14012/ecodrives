import 'package:flutter/material.dart';
import 'package:flutter_template/views/home/home_view_model.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(viewModel.title),
          ),
          body: Center(
            child: Text(viewModel.body),
          ),
        );
      },
    );
  }
}
