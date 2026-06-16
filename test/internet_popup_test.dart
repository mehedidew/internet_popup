// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:internet_popup/internet_popup.dart';

// class MockConnectivity extends Mock implements Connectivity {}
// class MockInternetConnectionChecker extends Mock implements InternetConnectionChecker {}

// void main() {
//   late InternetPopup internetPopup;
//   late MockConnectivity mockConnectivity;
//   late MockInternetConnectionChecker mockInternetConnectionChecker;
//   late StreamController<List<ConnectivityResult>> connectivityStreamController;

//   setUp(() {
//     internetPopup = InternetPopup();
//     mockConnectivity = MockConnectivity();
//     mockInternetConnectionChecker = MockInternetConnectionChecker();
//     connectivityStreamController = StreamController<List<ConnectivityResult>>.broadcast();

//     // Reset internetPopup state
//     internetPopup.connectivity = mockConnectivity;
//     internetPopup.connectionChecker = mockInternetConnectionChecker;
//     internetPopup.isOnline = false;
//     internetPopup.isDialogOn = false;
//   });

//   tearDown(() {
//     connectivityStreamController.close();
//   });

//   group('checkInternet', () {
//     test('returns true when connectivity is wifi and internet connection exists', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.wifi]);
//       when(() => mockInternetConnectionChecker.hasConnection)
//           .thenAnswer((_) async => true);

//       final result = await internetPopup.checkInternet();

//       expect(result, isTrue);
//       verify(() => mockConnectivity.checkConnectivity()).called(1);
//       verify(() => mockInternetConnectionChecker.hasConnection).called(1);
//     });

//     test('returns false when connectivity is none', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.none]);

//       final result = await internetPopup.checkInternet();

//       expect(result, isFalse);
//       verify(() => mockConnectivity.checkConnectivity()).called(1);
//       verifyNever(() => mockInternetConnectionChecker.hasConnection);
//     });

//     test('returns false when connectivity is wifi but no internet connection exists', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.wifi]);
//       when(() => mockInternetConnectionChecker.hasConnection)
//           .thenAnswer((_) async => false);

//       final result = await internetPopup.checkInternet();

//       expect(result, isFalse);
//       verify(() => mockConnectivity.checkConnectivity()).called(1);
//       verify(() => mockInternetConnectionChecker.hasConnection).called(1);
//     });
//   });

//   group('getConnectionType', () {
//     test('returns wifi when connectivity results contains wifi', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.wifi]);

//       final type = await internetPopup.getConnectionType();

//       expect(type, equals('wifi'));
//     });

//     test('returns mobile when connectivity results contains mobile', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.mobile]);

//       final type = await internetPopup.getConnectionType();

//       expect(type, equals('mobile'));
//     });

//     test('returns mobile when connectivity results is empty or none', () async {
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.none]);

//       final type = await internetPopup.getConnectionType();

//       expect(type, equals('mobile'));
//     });
//   });

//   group('initialize widget tests', () {
//     testWidgets('shows warning dialog when offline and dismisses when online', (WidgetTester tester) async {
//       print('=== TEST START ===');
//       // 1. Arrange
//       // Start offline: checkConnectivity returns none, and stream behaves similarly
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.none]);
//       when(() => mockConnectivity.onConnectivityChanged)
//           .thenAnswer((_) => connectivityStreamController.stream);

//       print('=== PUMPING WIDGET ===');
//       // We pump a simple app with a BuildContext
//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     print('=== INITIALIZE CALLED ===');
//                     internetPopup.initialize(
//                       context: context,
//                       customMessage: 'Offline alert',
//                       customDescription: 'Connection lost',
//                     );
//                   },
//                   child: const Text('Initialize Popup'),
//                 );
//               },
//             ),
//           ),
//         ),
//       );

//       print('=== TAPPING BUTTON ===');
//       // Tap to initialize
//       await tester.tap(find.text('Initialize Popup'));
//       print('=== PUMPING AND SETTLING 1 ===');
//       await tester.pumpAndSettle();
//       print('=== VERIFYING DIALOG EXISTS ===');

//       // Verify the offline dialog appears
//       expect(find.text('Offline alert'), findsOneWidget);
//       expect(find.text('Connection lost'), findsOneWidget);

//       print('=== STUBBING ONLINE ===');
//       // Now emit an online event on the stream and mock checker to return true
//       when(() => mockInternetConnectionChecker.hasConnection)
//           .thenAnswer((_) async => true);
//       print('=== ADDING ONLINE EVENT ===');
//       connectivityStreamController.add([ConnectivityResult.wifi]);

//       print('=== PUMPING ONCE ===');
//       // Process the stream event
//       await tester.pump();
//       print('=== WAITING DELAY ===');
//       // Wait for the asynchronous connection check to complete and state to update
//       await Future<void>.delayed(Duration.zero);
//       print('=== PUMPING AND SETTLING 2 ===');
//       await tester.pumpAndSettle();
//       print('=== VERIFYING DIALOG DISMISSED ===');

//       // Dialog should be dismissed
//       expect(find.text('Offline alert'), findsNothing);
//     });

//     testWidgets('shows warning dialog with OK button when onTapPop is true', (WidgetTester tester) async {
//       // Arrange
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.none]);
//       when(() => mockConnectivity.onConnectivityChanged)
//           .thenAnswer((_) => connectivityStreamController.stream);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     internetPopup.initialize(
//                       context: context,
//                       customMessage: 'Offline alert',
//                       customDescription: 'Connection lost',
//                       onTapPop: true,
//                     );
//                   },
//                   child: const Text('Initialize Popup'),
//                 );
//               },
//             ),
//           ),
//         ),
//       );

//       // Initialize
//       await tester.tap(find.text('Initialize Popup'));
//       await tester.pumpAndSettle();

//       // Verify dialog and 'Ok' button are present
//       expect(find.text('Offline alert'), findsOneWidget);
//       expect(find.text('Ok'), findsOneWidget);

//       // Tap the OK button to dismiss
//       await tester.tap(find.text('Ok'));
//       await tester.pumpAndSettle();

//       // Verify dialog is gone
//       expect(find.text('Offline alert'), findsNothing);
//     });
//   });

//   group('initializeCustomWidget widget tests', () {
//     testWidgets('shows custom widget when offline and dismisses when online', (WidgetTester tester) async {
//       // Arrange
//       when(() => mockConnectivity.checkConnectivity())
//           .thenAnswer((_) async => [ConnectivityResult.none]);
//       when(() => mockConnectivity.onConnectivityChanged)
//           .thenAnswer((_) => connectivityStreamController.stream);

//       await tester.pumpWidget(
//         MaterialApp(
//           home: Scaffold(
//             body: Builder(
//               builder: (context) {
//                 return ElevatedButton(
//                   onPressed: () {
//                     internetPopup.initializeCustomWidget(
//                       context: context,
//                       widget: const Text('Custom Offline View'),
//                     );
//                   },
//                   child: const Text('Initialize Custom'),
//                 );
//               },
//             ),
//           ),
//         ),
//       );

//       // Tap to initialize
//       await tester.tap(find.text('Initialize Custom'));
//       await tester.pumpAndSettle();

//       // Verify custom widget appears
//       expect(find.text('Custom Offline View'), findsOneWidget);

//       // Move online
//       when(() => mockInternetConnectionChecker.hasConnection)
//           .thenAnswer((_) async => true);
//       connectivityStreamController.add([ConnectivityResult.wifi]);

//       await tester.pump();
//       await Future<void>.delayed(Duration.zero);
//       await tester.pumpAndSettle();

//       // Verify custom widget is dismissed
//       expect(find.text('Custom Offline View'), findsNothing);
//     });
//   });
// }
