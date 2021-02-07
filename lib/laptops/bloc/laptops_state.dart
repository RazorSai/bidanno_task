part of 'laptops_bloc.dart';

abstract class LaptopsState extends Equatable {
  const LaptopsState();
}

class LaptopsInitial extends LaptopsState {
  @override
  List<Object> get props => [];
}

class LaptopsDataLoading extends LaptopsState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LaptopsDataLoaded extends LaptopsState{

  final List<ProductsModel> productsList;

  const LaptopsDataLoaded(this.productsList);

  @override
  // TODO: implement props
  List<Object> get props => [this.productsList];
}

class LaptopsDataError extends LaptopsState{

  final int errorCode;
  final String errorMessage;
  const LaptopsDataError(this.errorCode, this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

