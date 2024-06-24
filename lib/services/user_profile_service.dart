import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myapp/features/user/data/user_profile_data.dart';
import 'package:myapp/model/base-response-model.dart';
import 'package:myapp/services/api_service.dart';
import 'package:myapp/services/end_point.dart';

class UserProfileService {
  final apiService = ApiService(Endpoints.baseURL, baseUrl: Endpoints.baseURL);

  Future<ProfileResponse?> getUserProfile() async {
    try {
      final response = await apiService.get(Endpoints.profileURL);
      final result = BaseResponse.fromJson(response, ProfileResponse.fromJson);
      if (result.statusCode == 200) {
        return result.data;
      } else {
        throw Exception(result.message);
      }
    } catch (error) {
      print('Error fetching data: $error');
      return null;
    }
  }
}

final profileProvider =
    Provider<UserProfileService>((ref) => UserProfileService());
