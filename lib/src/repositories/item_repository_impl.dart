

import '../api/api_service.dart';
import '../models/diet_model.dart';
import 'diet_tool_repository.dart';

class ItemRepositoryImpl implements DietItemRepository {
  final ApiService apiService;

  ItemRepositoryImpl(this.apiService);

  @override
  Future<List<DietItem>> getItems({int pageNumber = 1}) async {
    final rootData = await apiService.getItemList(pageNumber: pageNumber);
    return rootData.data;
  }

  @override
  Future<DietItem> getItemDetails(int id) async {
    final response = await apiService.getItemDetails(id);
    return DietItem.fromJson(response);
  }
}