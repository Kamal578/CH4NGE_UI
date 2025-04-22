import 'package:ch4nge/features/layers/domain/entities/activity_entity.dart';
import 'package:ch4nge/features/layers/domain/repositories/activity_repository.dart';

class GetFriendsActivitiesUseCase {
  final ActivityRepository repository;

  GetFriendsActivitiesUseCase(this.repository);
  Future<List<ActivityEntity>> call(List<String> userIds) async {
    return await repository.getFriendsActivities(userIds);
  }
}
