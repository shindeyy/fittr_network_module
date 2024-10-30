import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../api/api_service.dart';
import '../api/api_service_diet_tool.dart';
import '../api/endpoints.dart';
import '../bloc/diet_item_bloc.dart';
import '../usecases/get_item_details_usecase.dart';
import '../usecases/get_item_list_usecase.dart';
import '../../core/logger/print_responce.dart';
import 'diet_tool_repository.dart';
import 'item_repository_impl.dart';

class RegisterDependencies {
  static final RegisterDependencies _instance =
      RegisterDependencies._internal();
  factory RegisterDependencies() => _instance;
  RegisterDependencies._internal();

  void setupDependencies(String environment) {
    final getIt = GetIt.instance;

// headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTY5NzQiLCJjcmVhdGVkX2F0Ijp7ImRhdGUiOiIyMDI0LTEwLTI0IDExOjQzOjEwLjA2NTY5MCIsInRpbWV6b25lX3R5cGUiOjMsInRpbWV6b25lIjoiVVRDIn0sImVtYWlsIjoieW9nZXNoQGZpdHRyLmNvbSIsInByb3ZpZGVyIjoiREVGQVVMVCIsImlzX2FkbWluIjowLCJpc19jb2FjaCI6MCwiaXNfdHJhaW5lciI6MCwibG9naW5faGlzdG9yeV9pZCI6NTgwNywiaXNfY29ycG9yYXRlX3VzZXIiOjAsImNvcnBvcmF0ZV9pZCI6MH0.0lPYCRmG1CvNLl0XVdVyGyA0wtoeKufYfWBA_C7oc_s', // Add your auth token or any other default headers
//       'device-type':'android',
//       'app-code': '8.8.5',
//       'app-ver': '405',
//       'device-udid':'fdssfssfsfs21214',
//       'package-name':'com.squats.fittr',
//       'timestamp': '',
//       'timezone': '',
//       'devicetype': 'android',
//       'deviceudid': 'fdssfssfsfs21214',
//       'version': '8.8.5',
//       'source': 'fittr_app'
//     }

    // Initialize Dio with base URL and add default headers
    Dio dio = Dio(BaseOptions(
      baseUrl: Endpoints.getBaseUrl(environment),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTY5NzQiLCJjcmVhdGVkX2F0Ijp7ImRhdGUiOiIyMDI0LTEwLTI4IDA0OjM5OjIxLjQ1MjcxOCIsInRpbWV6b25lX3R5cGUiOjMsInRpbWV6b25lIjoiVVRDIn0sImVtYWlsIjoieW9nZXNoQGZpdHRyLmNvbSIsInByb3ZpZGVyIjoiREVGQVVMVCIsImlzX2FkbWluIjowLCJpc19jb2FjaCI6MCwiaXNfdHJhaW5lciI6MCwibG9naW5faGlzdG9yeV9pZCI6MTg2LCJpc19jb3Jwb3JhdGVfdXNlciI6MCwiY29ycG9yYXRlX2lkIjowfQ.J4ETIIs6est-i2ARVHYziAk4XYMCKyDY-BFsXI-gJoo', // Add your auth token or any other default headers
        'device-type': 'android',
        'devicetype': 'android',
      },
    ));

    // Set up interceptors to log request and response details
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request information
        PrintResponse.instance.logMessage(
            'Request [${options.method}] => URL: ${options.baseUrl}${options.path} \n Headers: ${options.headers} \n Request Data: ${options.data}',
            Level.info);
        return handler.next(options); // Continue the request
      },
      onResponse: (response, handler) {
        PrintResponse.instance.logResponse(response.data, Level.info);
        //PrintResponse.printSuccessResponse(response, PrintResponse.greenColor);
        return handler.next(response); // Continue with the response
      },
      onError: (error, handler) {
        // Log error information
        if (error.response != null) {
          PrintResponse.instance.logErrorResponse(error);
        } else {
          PrintResponse.instance.logResponse(error.response?.data, Level.error);
        }
        return handler.next(error); // Continue with the error
      },
    ));

// Initialize Dio with base URL and add default headers
    Dio dioDietTool = Dio(BaseOptions(
      baseUrl: Endpoints.getDietToolBaseUrl(environment),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoiMTY5NzQiLCJjcmVhdGVkX2F0Ijp7ImRhdGUiOiIyMDI0LTEwLTI4IDA0OjM5OjIxLjQ1MjcxOCIsInRpbWV6b25lX3R5cGUiOjMsInRpbWV6b25lIjoiVVRDIn0sImVtYWlsIjoieW9nZXNoQGZpdHRyLmNvbSIsInByb3ZpZGVyIjoiREVGQVVMVCIsImlzX2FkbWluIjowLCJpc19jb2FjaCI6MCwiaXNfdHJhaW5lciI6MCwibG9naW5faGlzdG9yeV9pZCI6MTg2LCJpc19jb3Jwb3JhdGVfdXNlciI6MCwiY29ycG9yYXRlX2lkIjowfQ.J4ETIIs6est-i2ARVHYziAk4XYMCKyDY-BFsXI-gJoo', // Add your auth token or any other default headers
        'device-type': 'android',
        'devicetype': 'android',
      },
    ));

    // Set up interceptors to log request and response details
    dioDietTool.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log request information
        PrintResponse.instance.logMessage(
            'Request [${options.method}] => URL: ${options.baseUrl}${options.path} \n Headers: ${options.headers} \n Request Data: ${options.data}',
            Level.info);
        return handler.next(options); // Continue the request
      },
      onResponse: (response, handler) {
        PrintResponse.instance.logResponse(response.data, Level.info);
        return handler.next(response); // Continue with the response
      },
      onError: (error, handler) {
        // Log error information
        if (error.response != null) {
          PrintResponse.instance.logErrorResponse(error);
        } else {
          PrintResponse.instance.logResponse(error.response?.data, Level.error);
        }
        return handler.next(error); // Continue with the error
      },
    ));

    // Register both Dio instances in GetIt with different names
    getIt.registerSingleton<Dio>(dio, instanceName: 'baseDio');
    getIt.registerSingleton<Dio>(dioDietTool, instanceName: 'dietToolDio');

    // Register ApiService with their respective Dio clients
    getIt.registerSingleton<ApiService>(
        ApiService(getIt<Dio>(instanceName: 'baseDio')));
    getIt.registerSingleton<ApiServiceDietTool>(
        ApiServiceDietTool(getIt<Dio>(instanceName: 'dietToolDio')));

    // Register the repository
    getIt.registerLazySingleton<DietItemRepository>(
        () => ItemRepositoryImpl(getIt<ApiService>()));

    // Register use cases
    getIt.registerLazySingleton<GetItemListUseCase>(
        () => GetItemListUseCase(getIt<DietItemRepository>()));
    getIt.registerLazySingleton<GetItemDetailsUseCase>(
        () => GetItemDetailsUseCase(getIt<DietItemRepository>()));

    // Register the BLoC
    getIt.registerFactory<DietItemBloc>(() => DietItemBloc(
          getIt<GetItemListUseCase>(),
          getIt<GetItemDetailsUseCase>(),
        ));
  }
}
