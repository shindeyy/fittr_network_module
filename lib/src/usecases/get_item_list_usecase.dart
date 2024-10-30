import '../models/diet_model.dart';
import '../repositories/diet_tool_repository.dart';

class GetItemListUseCase {
  final DietItemRepository repository;

  GetItemListUseCase(this.repository);

  Future<List<DietItem>> call({int pageNumber = 1}) async {
    return await repository.getItems(pageNumber: pageNumber);
  }
}
