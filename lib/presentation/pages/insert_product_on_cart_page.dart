import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_cubit.dart';
import 'package:sell_point/logic/cubits/product/search/search_product_state.dart';
import 'package:sell_point/presentation/components/shared/button_widget.dart';
import 'package:sell_point/presentation/components/shared/info_card_widget.dart';
import 'package:sell_point/presentation/components/shared/product_widget.dart';
import 'package:sell_point/presentation/components/shared/searchbar_widget.dart';

class InsertProductOnCartPage extends StatefulWidget {
  final int cartId;

  const InsertProductOnCartPage({super.key, required this.cartId});

  @override
  State<InsertProductOnCartPage> createState() =>
      _InsertProductOnCartPageState();
}

class _InsertProductOnCartPageState extends State<InsertProductOnCartPage> {
  final searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final searchProductCubit = context.read<SearchProductCubit>();
        return BlocBuilder<SearchProductCubit, SearchProductState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Produtos',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: AppColors.main,
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(
                  bottom: Sizes.defaultVerticalPadding,
                ),
                child: ButtonWidget(
                  title: 'Adicionar Produto',
                  height: 45,
                  width: MediaQuery.of(context).size.width * .8,
                  onPress: () {},
                ),
              ),
              body: Column(
                children: [
                  InfoCardWidget(
                    title: 'Adicionar produto à venda',
                    description:
                        'Utilize a barra de pesquisa para encontrar o produto pelo identificador',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.defaultHorizontalPadding,
                      vertical: Sizes.defaultVerticalPadding,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SearchBarWidget(
                            keyboardType: TextInputType.number,
                            controller: searchCtrl,
                            onSendButtonPressed: () {
                              final input = searchCtrl.text;
                              if (int.tryParse(input) != null) {
                                searchProductCubit.search(int.parse(input));
                              }
                            },
                          ),
                          const SizedBox(height: 16),
                          if (state is ProductFoundState)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 11,
                                    top: 11,
                                    bottom: 5.5
                                  ),
                                  child: const Text(
                                    'Produto encontrado: ',
                                    style: TextStyle(
                                      color: AppColors.subtitleDarkGray,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                ProductWidget(product: state.product),
                              ],
                            )
                          else if (state is SearchProductError)
                            const Text('Produto não encontrado'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
