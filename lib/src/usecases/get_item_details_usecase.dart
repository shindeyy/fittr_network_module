import '../models/diet_model.dart';
import '../repositories/diet_tool_repository.dart';

class GetItemDetailsUseCase {
  final DietItemRepository repository;

  GetItemDetailsUseCase(this.repository);

  Future<DietItem> call(int id) async {
    return await repository.getItemDetails(id);
  }
}