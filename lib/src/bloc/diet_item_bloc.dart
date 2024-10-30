import 'package:fittr_network_module/src/repositories/diet_tool_repository.dart';
import 'package:fittr_network_module/src/usecases/get_item_details_usecase.dart';
import 'package:fittr_network_module/src/usecases/get_item_list_usecase.dart';
import 'package:fittr_network_module/src/models/diet_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'diet_item_event.dart';

class DietItemBloc extends Bloc<ItemEvent, ItemState> {
  final GetItemListUseCase getItemListUseCase;
  final GetItemDetailsUseCase getItemDetailsUseCase;

  int currentPage = 1; // Track the current page
  bool _isFetching = false; // Track if a fetch operation is in progress
  bool hasMoreItems = true;

  DietItemBloc(this.getItemListUseCase, this.getItemDetailsUseCase)
      : super(ItemInitial()) {
    on<FetchItemList>(_onFetchItemList);
    on<FetchItemDetails>(_onFetchItemDetails);
    on<ResetItemList>(_onResetItemList);
  }

  Future<void> _onFetchItemList(
      FetchItemList event, Emitter<ItemState> emit) async {
    try {
      // Show loading state only for the first page
      if (currentPage == 1) {
        emit(ItemLoading());
      }

      // Fetch the new items based on the current page
      final newItems = await getItemListUseCase(pageNumber: currentPage);

      // Check the current state to get existing items
      List<DietItem> updatedItems = [];
      if (state is ItemLoaded) {
        updatedItems =
            List.from((state as ItemLoaded).items); // Copy existing items
      }

      // Append the newly fetched items to the list
      updatedItems.addAll(newItems);

      // Emit the updated list of items with the new page appended
      emit(ItemLoaded(updatedItems));

      // Increment the page counter only if new items were loaded
      if (newItems.isNotEmpty) {
        currentPage++;
      } else {
        // Stop pagination if no new items are returned
        hasMoreItems = false;
      }
    } catch (error) {
      emit(ItemError(error.toString()));
    }
  }

  Future<void> _onFetchItemDetails(
      FetchItemDetails event, Emitter<ItemState> emit) async {
    emit(ItemLoading()); // Emit loading state
    try {
      final itemDetails = await getItemDetailsUseCase(event.id);
      emit(ItemDetailsLoaded(itemDetails)); // Emit details loaded state
    } catch (error) {
      emit(ItemError(error.toString())); // Emit error state
    }
  }

  Future<void> _onResetItemList(
      ResetItemList event, Emitter<ItemState> emit) async {
    currentPage = 1; // Reset the current page
    emit(ItemInitial()); // Reset state

    // Optionally, fetch the first page immediately
    add(FetchItemList()); // Fetch the first page of items
  }
}
