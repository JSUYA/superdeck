// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slide_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SlideData _$$_SlideDataFromJson(Map<String, dynamic> json) => _$_SlideData(
      content: json['content'] as String?,
      options: json['options'] == null
          ? const SlideOptions()
          : SlideOptions.fromJson(json['options'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SlideDataToJson(_$_SlideData instance) =>
    <String, dynamic>{
      'content': instance.content,
      'options': instance.options,
    };
