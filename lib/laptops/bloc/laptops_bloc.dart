import 'dart:async';
import 'dart:convert';
import 'package:bidanno_task/global/url_paths.dart';
import 'package:http/http.dart' as http;
import 'package:bidanno_task/global/products_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'laptops_event.dart';
part 'laptops_state.dart';

class LaptopsBloc extends Bloc<LaptopsEvent, LaptopsState> {
  LaptopsBloc() : super(LaptopsInitial());

  @override
  Stream<LaptopsState> mapEventToState(
    LaptopsEvent event,
  ) async* {
    if(event is GetLaptopsList){
      yield* getLaptopsList();
    }
  }

  Stream<LaptopsState> getLaptopsList() async*{
    yield LaptopsDataLoading();
    try{
      http.Response response = await http.get(UrlPaths.laptops, headers: {"Content-Type" : "application/json"});

      if(response != null){
        var responseMap = json.decode(response.body);
        List productsJsonArray = responseMap as List;
        List<ProductsModel> productsList = productsJsonArray.map((e) => ProductsModel.fromJson(e)).toList();
        yield LaptopsDataLoaded(productsList);
      }
      else{
        yield LaptopsDataError(400, "Failed to load phones list. Please try again later.");
      }

    }catch(e){
      yield LaptopsDataError(400, "Failed to load phones list. Please try again later.");
    }
  }

}
