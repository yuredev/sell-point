import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sell_point/core/constants/colors.dart';
import 'package:sell_point/core/constants/sizes.dart';
import 'package:sell_point/core/routes.dart';
import 'package:sell_point/domain/dto/cart_product_dto/cart_product_dto.dart';
import 'package:sell_point/domain/product/product.dart';
import 'package:sell_point/domain/user/user.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_cubit.dart';
import 'package:sell_point/logic/cubits/cart/flow/cart_flow_state.dart';
import 'package:sell_point/logic/cubits/global_alert/global_alert_cubit.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_cubit.dart';
import 'package:sell_point/logic/cubits/product/load/load_products_state.dart';
import 'package:sell_point/presentation/widgets/products_page/cart_summary_widget.dart';
import 'package:sell_point/presentation/widgets/shared/illustration_widget.dart';
import 'package:sell_point/presentation/widgets/shared/product_widget.dart';
import 'package:sell_point/presentation/widgets/shared/searchbar_widget.dart';
import 'package:sell_point/utils/number_utils.dart';

class ProductsPage extends StatefulWidget {
  final User user;

  const ProductsPage({super.key, required this.user});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final LoadProductsCubit loadProductsCubit = context.read();
  late final GlobalAlertCubit globalAlertCubit = context.read();
  late final CartFlowCubit cartFlowCubit = context.read();
  final searchCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final filteredProducts = <Product>[];
  var isFirstLoading = true;
  Map<int, int> productQuantityMapping = {};

  @override
  void initState() {
    super.initState();
    final state = cartFlowCubit.state;
    if (state is AddingProductsState) {
      productQuantityMapping = {
        for (var dto in state.dtos) dto.productId: dto.quantity,
      };
    }
    loadProductsCubit.load();
  }

  String? validateSearch(String? p1) {
    final text = p1?.trim();
    if (text == null || text.isEmpty) {
      return 'O campo de pesquisa está vazio';
    }
    if (NumberUtils.isInteger(p1.toString())) {
      return null;
    }
    return null;
  }

  List<Product> getFilteredProducts(List<Product> products) {
    final valorBusca = searchCtrl.text.trim();
    if (NumberUtils.isInteger(valorBusca)) {
      return products.where((p) => p.id == int.parse(valorBusca)).toList();
    }
    return products.where((p) => p.title.startsWith(valorBusca)).toList();
  }

  void applyFilter(LoadProductsState state) {
    if (state is ProductsLoadedState) {
      setState(() {
        filteredProducts
          ..clear()
          ..addAll(getFilteredProducts(state.products));
      });
    }
    FocusScope.of(context).unfocus();
  }

  bool get summaryWidgetVisibility {
    return productQuantityMapping.values.any((v) => v > 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.main,
      ),
      body: BlocConsumer<LoadProductsCubit, LoadProductsState>(
        listener: (context, state) {
          if (state is ProductsLoadedState && isFirstLoading) {
            setState(() {
              isFirstLoading = false;
              filteredProducts
                ..clear()
                ..addAll(state.products);
            });
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              RefreshIndicator(
                onRefresh: () => loadProductsCubit.load(),
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.defaultHorizontalPadding,
                          vertical: Sizes.defaultVerticalPadding,
                        ),
                        child: SearchBarWidget(
                          label: 'Pesquisar produto',
                          controller: searchCtrl,
                          textInputAction: TextInputAction.search,
                          sendButtonColor: AppColors.main,
                          onSendButtonPressed: () => applyFilter(state),
                          onFieldSubmitted: (_) => applyFilter(state),
                        ),
                      ),
                    ),
                    if (state is ProductsLoadErrorState)
                      SliverToBoxAdapter(
                        child: IllustrationWidget(
                          illustrationName: 'error.json',
                          title: 'Erro ao listar os produtos',
                          isAnimation: true,
                          imageWidth: MediaQuery.of(context).size.width * .6,
                          fontSize: 18,
                          textImageSpacing: 22,
                          subtitle: 'Verifique sua conexão com a internet.',
                        ),
                      )
                    else if (state is LoadingProductsState)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.defaultHorizontalPadding,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) =>
                                ProductWidget(isLoading: true, quantity: 0),
                            childCount: 10,
                          ),
                        ),
                      )
                    else if (state is ProductsLoadedState &&
                        filteredProducts.isEmpty)
                      SliverToBoxAdapter(
                        child: IllustrationWidget(
                          illustrationName: 'no-data.png',
                          title: 'Sem dados',
                          imageWidth: MediaQuery.of(context).size.width * 0.33,
                          subtitle:
                              'Não há resultados para os parâmetros atuais',
                        ),
                      )
                    else if (state is ProductsLoadedState)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Sizes.defaultHorizontalPadding,
                        ),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((_, index) {
                            final product = filteredProducts[index];
                            final quantity =
                                productQuantityMapping[product.id] ?? 0;
                            return ProductWidget(
                              product: product,
                              quantity: quantity,
                              onChangeQuantity: (value) {
                                FocusScope.of(context).unfocus();
                                final totalProdutos = productQuantityMapping
                                    .values
                                    .fold(0, (a, b) => a + b);
                                if (value > quantity && totalProdutos == 10) {
                                  globalAlertCubit.fire(
                                    'Número máximo de produtos atingido',
                                  );
                                  return;
                                }
                                setState(() {
                                  if (value == 0) {
                                    productQuantityMapping.remove(product.id);
                                  } else {
                                    productQuantityMapping[product.id] = value;
                                  }
                                  final dtos =
                                      productQuantityMapping.entries
                                          .map(
                                            (p) => CartProductDto(
                                              productId: p.key,
                                              quantity: p.value,
                                            ),
                                          )
                                          .toList();
                                  cartFlowCubit.addToCart(dtos);
                                });
                              },
                            );
                          }, childCount: filteredProducts.length),
                        ),
                      ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: Sizes.defaultVerticalPadding * 10,
                      ),
                    ),
                  ],
                ),
              ),
              if (state is ProductsLoadedState && summaryWidgetVisibility)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CartSummaryWidget(
                    summary:
                        productQuantityMapping.entries.map((entry) {
                          final product = state.products.firstWhere(
                            (p) => p.id == entry.key,
                          );
                          return CartSummaryDTO(
                            product: product,
                            quantity: entry.value,
                          );
                        }).toList(),
                    aoContinuar: () {
                      Navigator.pushNamed(
                        context,
                        Routes.cartResume,
                        arguments: {
                          'productQuantityMapping': productQuantityMapping,
                          'products': state.products,
                          'user': widget.user,
                        },
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
