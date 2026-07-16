import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flowery/config/base_response/base_response.dart';
import 'package:flowery/modules/profile/domain/entities/upload_profile_photo_entity.dart';
import 'package:flowery/modules/profile/domain/use_cases/upload_profile_photo_use_case.dart';
import 'package:flowery/modules/profile/presentation/view_models/cubit/uplaod_profile_photo_view_model.dart';
import 'package:flowery/modules/profile/presentation/view_models/events/upload_profile_photo_event.dart';
import 'package:flowery/modules/profile/presentation/view_models/states/upload_profile_photo_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUploadProfilePhotoUseCase extends Mock
    implements UploadProfilePhotoUseCase {}

class FakeFile extends Fake implements File {}

void main() {
  late MockUploadProfilePhotoUseCase mockUseCase;
  late File testFile;

  setUpAll(() {
    registerFallbackValue(FakeFile());
  });

  setUp(() {
    mockUseCase = MockUploadProfilePhotoUseCase();
    testFile = File('test_photo.png');
  });

  UplaodProfilePhotoViewModel buildCubit() =>
      UplaodProfilePhotoViewModel(mockUseCase);

  group('UplaodProfilePhotoViewModel', () {
    test('initial state has null pickedFile, file, and errorMessage', () {
      final cubit = buildCubit();
      expect(cubit.state.pickedFile, isNull);
      expect(cubit.state.file, isNull);
      expect(cubit.state.errorMessage, isNull);
      cubit.close();
    });

    blocTest<UplaodProfilePhotoViewModel, UploadProfilePhotoState>(
      'emits pickedFile then uploaded file when upload succeeds',
      build: () {
        when(() => mockUseCase.call(any())).thenAnswer(
          (_) async =>
              Success(data: UploadProfilePhotoEntity(message: 'Uploaded')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(UploadProfilePhoto(testFile)),
      expect: () => [
        isA<UploadProfilePhotoState>()
            .having((s) => s.pickedFile, 'pickedFile', testFile)
            .having((s) => s.file, 'file', isNull)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
        isA<UploadProfilePhotoState>()
            .having((s) => s.pickedFile, 'pickedFile', testFile)
            .having((s) => s.file?.message, 'file.message', 'Uploaded')
            .having((s) => s.errorMessage, 'errorMessage', isNull),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(testFile)).called(1);
      },
    );

    blocTest<UplaodProfilePhotoViewModel, UploadProfilePhotoState>(
      'emits pickedFile then errorMessage when upload fails',
      build: () {
        when(() => mockUseCase.call(any())).thenAnswer(
          (_) async => Error(exception: Exception('Upload failed')),
        );
        return buildCubit();
      },
      act: (cubit) => cubit.doEvent(UploadProfilePhoto(testFile)),
      expect: () => [
        isA<UploadProfilePhotoState>()
            .having((s) => s.pickedFile, 'pickedFile', testFile)
            .having((s) => s.file, 'file', isNull)
            .having((s) => s.errorMessage, 'errorMessage', isNull),
        isA<UploadProfilePhotoState>()
            .having((s) => s.pickedFile, 'pickedFile', testFile)
            .having((s) => s.file, 'file', isNull)
            .having(
              (s) => s.errorMessage,
              'errorMessage',
              contains('Upload failed'),
            ),
      ],
      verify: (_) {
        verify(() => mockUseCase.call(testFile)).called(1);
      },
    );
  });
}