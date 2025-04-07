import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_cubit.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_state.dart';
import 'package:sell_point/presentation/components/shared/button_widget.dart';
import 'package:sell_point/presentation/components/shared/searchbar_widget.dart';

class InsertProductOnCartPage extends StatefulWidget {
  final int cartId;

  const InsertProductOnCartPage({super.key, required this.cartId});

  @override
  State<InsertProductOnCartPage> createState() =>
      _InsertProductOnCartPageState();
}

class _InsertProductOnCartPageState extends State<InsertProductOnCartPage> {
  late final SearchProductCubit searchProductCubit = context.read();
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.main,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: Sizes.defaultVerticalPadding),
        child: ButtonWidget(
          title: 'Adicionar Produto',
          height: 45,
          width: MediaQuery.of(context).size.width * .8,
          onPress: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.defaultHorizontalPadding,
          vertical: Sizes.defaultVerticalPadding,
        ),
        child: BlocBuilder<SearchProductCubit, SearchProductState>(
          builder:
              (context, state) => SingleChildScrollView(
                child: Column(
                  children: [
                    SearchBarWidget(
                      keyboardType: TextInputType.number,
                      controller: searchCtrl,
                      onSendButtonPressed: () {
                        searchProductCubit.search(int.parse(searchCtrl.text));
                      },
                    ),
                    if (state is ProductFoundState)
                      Column(
                        children: [
                          Text('Produto encontrado: ${state.product.title}'),
                        ],
                      )
                    else if (state is SearchProductError)
                      Text('Produto não encontrado'),
                  ],
                ),
              ),
        ),
      ),
    );
  }
}
