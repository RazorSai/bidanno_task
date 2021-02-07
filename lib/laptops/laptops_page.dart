import 'package:bidanno_task/global/products_model.dart';
import 'package:bidanno_task/laptops/bloc/laptops_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaptopsPage extends StatefulWidget {
  @override
  _LaptopsPageState createState() => _LaptopsPageState();
}

class _LaptopsPageState extends State<LaptopsPage> {

  LaptopsBloc _laptopsBloc;

  List<ProductsModel> productsList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _laptopsBloc = LaptopsBloc();
    getLaptopsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider(
          create: (_) => _laptopsBloc,
          child: BlocListener<LaptopsBloc, LaptopsState>(
            listener: (_, state){

            },
            child: BlocBuilder<LaptopsBloc, LaptopsState>(
              builder: (_, state){

                if(state is LaptopsDataLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (state is LaptopsDataError){
                  return Center(
                    child: Text(
                        state.errorMessage
                    ),
                  );
                }
                else if(state is LaptopsDataLoaded){
                  this.productsList = state.productsList;
                }
                return RefreshIndicator(
                  onRefresh: getLaptopsList,
                  child: ListView.builder(
                    itemBuilder: (_, index){
                      ProductsModel productsModel = productsList[index];
                      return ExpansionTile(
                        title: Text(productsModel.Name, style: TextStyle(fontWeight: FontWeight.bold)),
                        initiallyExpanded: true,
                        children: getInnerChildren(productsModel.productsList),
                      );
                    },
                    itemCount: productsList.length,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> getInnerChildren(List<ProductsModel> children){
    List<Widget> widgets = List();
    children.forEach((element) {
      widgets.addAll(getAllWidgets(element.Name, element.productsList));
    });

    return widgets;
  }
  
  List<Widget> getAllWidgets(String name, List<ProductsModel> children){
    List<Widget> widgets = List();
    if(children.length == 0){
      widgets.add(ListTile(
        title: Text(
          name
        ),
      ));
    }
    else{
      widgets.add(ExpansionTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
        initiallyExpanded: true,
        children: getInnerChildren(children),
      ));
    }
    return widgets;
  }

  Future getLaptopsList() async{
    _laptopsBloc.add(GetLaptopsList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _laptopsBloc.close();
  }

}
