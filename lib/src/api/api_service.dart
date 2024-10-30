import 'package:dio/dio.dart';
import 'package:fittr_network_module/src/models/diet_model.dart';
import 'package:fittr_network_module/src/models/root_data.dart';

import '../utils/error_handler.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<RootData<List<DietItem>>> getItemList({int pageNumber = 1}) async {
    try {
      final response = await _dio.post('/diettoolms/v1/fooditem/search', data: {"pageNumber": pageNumber,"pageSize":10,"type":"all","query":""});
      // Parse response data into a RootData object with List<DietItem>
      return RootData.fromJson(response.data,(dataJson) => (dataJson['list'] as List).map((item) => DietItem.fromJson(item)).toList(),);
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.handleError(e);
      print("Error occurred: $errorMessage");
      throw Exception(errorMessage); // Throw the handled error
    } catch (e) {
      print("Unexpected error occurred: $e");
      throw Exception("Unexpected error occurred: $e");
    }
  }

  Future<Map<String, dynamic>> getItemDetails(int id) async {
    try {
      final response = await _dio.get('/items/$id');
      return response.data;
    } on DioException catch (e) {
      final errorMessage = DioErrorHandler.handleError(e);
      print("Error occurred: $errorMessage");
      throw Exception(errorMessage); // Throw the handled error
    } catch (e) {
      print("Unexpected error occurred: $e");
      throw Exception("Unexpected error occurred: $e");
    }
  }
}