import 'package:fittr_network_module/src/models/diet_model.dart';

abstract class ItemState {}

class ItemInitial extends ItemState {} // Initial state, before loading data

class ItemLoading extends ItemState {} // Loading state

class ItemLoaded extends ItemState {
  final List<DietItem> items; // Holds the list of items
  ItemLoaded(this.items); // Constructor to pass the loaded items
}

class ItemDetailsLoaded extends ItemState {
  final DietItem itemDetails; // Holds the details of a specific item
  ItemDetailsLoaded(this.itemDetails); // Constructor to pass the item details
}

class ItemError extends ItemState {
  final String message; // Holds the error message
  ItemError(this.message); // Constructor to pass the error message
}

// Define Events
abstract class ItemEvent {}

class FetchItemList extends ItemEvent {
  final int pageNumber;

  FetchItemList({this.pageNumber = 1});
}

class FetchItemDetails extends ItemEvent {
  final int id;
  FetchItemDetails(this.id);
}

class ResetItemList extends ItemEvent {}