import 'package:freezed_annotation/freezed_annotation.dart';

import './slide_options.model.dart';

part 'slide_data.model.freezed.dart';
part 'slide_data.model.g.dart';

@freezed
class SlideData with _$SlideData {
  const SlideData._();
  const factory SlideData({
    required String id,
    String? content,
    @Default(SlideOptions()) SlideOptions options,
  }) = _SlideData;

  factory SlideData.fromJson(Map<String, dynamic> json) =>
      _$SlideDataFromJson(json);
}
