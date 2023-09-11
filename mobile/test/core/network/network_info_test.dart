import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([DataConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfoImpl;
  late MockDataConnectionChecker mockDataConnectionChecker;

  setUp(() {
    mockDataConnectionChecker = MockDataConnectionChecker();
    networkInfoImpl = NetworkInfoImpl(mockDataConnectionChecker);
  });

  group("is connected", () {
    test("Should forward the call to DataConnectionChecker.hasConnection",
        () async {
      final tHasConnectionFuture = Future.value(true);

      when(mockDataConnectionChecker.hasConnection)
          .thenAnswer((_) => tHasConnectionFuture);

      final result = networkInfoImpl.isConnected;

      verify(mockDataConnectionChecker.hasConnection).called(1);
      expect(result, tHasConnectionFuture);
    });
  });
}
