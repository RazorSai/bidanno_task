part of 'phones_bloc.dart';

abstract class PhonesState extends Equatable {
  const PhonesState();
}

class PhonesInitial extends PhonesState {
  @override
  List<Object> get props => [];
}

class PhonesDataLoading extends PhonesState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class PhonesDataLoaded extends PhonesState{

  final List<ProductsModel> productsList;

  const PhonesDataLoaded(this.productsList);

  @override
  // TODO: implement props
  List<Object> get props => [this.productsList];
}

class PhonesDataError extends PhonesState{

  final int errorCode;
  final String errorMessage;
  const PhonesDataError(this.errorCode, this.errorMessage);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
