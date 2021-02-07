import 'dart:async';
import 'package:bidanno_task/global/url_paths.dart';
import 'package:http/http.dart' as http;
import 'package:bidanno_task/global/products_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';

part 'phones_event.dart';
part 'phones_state.dart';

class PhonesBloc extends Bloc<PhonesEvent, PhonesState> {
  PhonesBloc() : super(PhonesInitial());

  @override
  Stream<PhonesState> mapEventToState(
    PhonesEvent event,
  ) async* {
    if(event is GetPhonesList){
      yield* getPhonesList();
    }
  }
  
  Stream<PhonesState> getPhonesList() async*{
    yield PhonesDataLoading();
    try{
      http.Response response = await http.get(UrlPaths.phones, headers: {"Content-Type" : "application/json"});
      
      if(response != null){
        var responseMap = json.decode(response.body);
        List productsJsonArray = responseMap as List;
        List<ProductsModel> productsList = productsJsonArray.map((e) => ProductsModel.fromJson(e)).toList();
        yield PhonesDataLoaded(productsList);
      }
      else{
        yield PhonesDataError(400, "Failed to load phones list. Please try again later.");
      }
      
    }catch(e){
      yield PhonesDataError(400, "Failed to load phones list. Please try again later.");
    }
  }
  
}
