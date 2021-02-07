import 'package:bidanno_task/global/products_model.dart';
import 'package:bidanno_task/phones/bloc/phones_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhonesPage extends StatefulWidget {
  @override
  _PhonesPageState createState() => _PhonesPageState();
}

class _PhonesPageState extends State<PhonesPage> {

  PhonesBloc _phonesBloc;

  List<ProductsModel> productsList = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phonesBloc = PhonesBloc();
    getPhonesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlocProvider(
          create: (_) => _phonesBloc,
          child: BlocListener<PhonesBloc, PhonesState>(
            listener: (_, state){

            },
            child: BlocBuilder<PhonesBloc, PhonesState>(
              builder: (_, state){

                if(state is PhonesDataLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (state is PhonesDataError){
                  return Center(
                    child: Text(
                        state.errorMessage
                    ),
                  );
                }
                else if(state is PhonesDataLoaded){
                  this.productsList = state.productsList;
                }
                return RefreshIndicator(
                  onRefresh: getPhonesList,
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

  Future getPhonesList() async{
    _phonesBloc.add(GetPhonesList());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phonesBloc.close();
  }

}
