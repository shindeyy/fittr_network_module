import 'package:fittr_network_module/src/api/api_service.dart';
import 'package:fittr_network_module/src/models/diet_model.dart';

import '../models/root_data.dart';

class DietItemRepository {
  final ApiService _apiService;

  DietItemRepository(this._apiService);

  Future<List<DietItem>> getItems({int pageNumber = 1}) async {
    final rootData = await _apiService.getItemList(pageNumber: pageNumber);
    return rootData.data;
  }

  Future<DietItem> getItemDetails(int id) async {
    final data = await _apiService.getItemDetails(id);
    return DietItem.fromJson(data);
  }
}