import 'package:dio/dio.dart';

import '../Resources/ap_url.dart';

class CheckInOutApiService {
  final Dio dio = Dio(); // Dio instance
  final String baseUrl = Endpoint.checkInOut;

  Future<Map<String, dynamic>> checkInOut({
    required int organizationId,
    required int branchId,
    required int loginUserId,
    required String checkInOutType,
  }) async {
    final String url =
        "$baseUrl?OrganizationId=$organizationId&BranchId=$branchId&LoginUserId=$loginUserId";

    final Map<String, dynamic> body = {
      "checkInOutType": checkInOutType,
      "timestamp": DateTime.now().toIso8601String(),
    };

    try {
      final response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception(
            "Failed to send data. Status code: ${response.statusCode}");
      }
    } catch (error) {
      throw Exception("Error: $error");
    }
  }
}
