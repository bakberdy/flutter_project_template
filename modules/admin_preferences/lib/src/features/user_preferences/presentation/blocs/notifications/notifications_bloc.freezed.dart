// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsEvent()';
}


}

/// @nodoc
class $NotificationsEventCopyWith<$Res>  {
$NotificationsEventCopyWith(NotificationsEvent _, $Res Function(NotificationsEvent) __);
}



/// @nodoc


class NotificationsStarted implements NotificationsEvent {
  const NotificationsStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationsEvent.started()';
}


}




/// @nodoc


class NotificationsChanged implements NotificationsEvent {
  const NotificationsChanged({required this.type, required this.enabled});
  

 final  UserPreferencesNotificationType type;
 final  bool enabled;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsChangedCopyWith<NotificationsChanged> get copyWith => _$NotificationsChangedCopyWithImpl<NotificationsChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsChanged&&(identical(other.type, type) || other.type == type)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,type,enabled);

@override
String toString() {
  return 'NotificationsEvent.changed(type: $type, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class $NotificationsChangedCopyWith<$Res> implements $NotificationsEventCopyWith<$Res> {
  factory $NotificationsChangedCopyWith(NotificationsChanged value, $Res Function(NotificationsChanged) _then) = _$NotificationsChangedCopyWithImpl;
@useResult
$Res call({
 UserPreferencesNotificationType type, bool enabled
});




}
/// @nodoc
class _$NotificationsChangedCopyWithImpl<$Res>
    implements $NotificationsChangedCopyWith<$Res> {
  _$NotificationsChangedCopyWithImpl(this._self, this._then);

  final NotificationsChanged _self;
  final $Res Function(NotificationsChanged) _then;

/// Create a copy of NotificationsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,Object? enabled = null,}) {
  return _then(NotificationsChanged(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as UserPreferencesNotificationType,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$NotificationsState {

 UserPreferences? get preferences; UserPreferencesNotificationType? get updatingType; StateStatus get status;
/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationsStateCopyWith<NotificationsState> get copyWith => _$NotificationsStateCopyWithImpl<NotificationsState>(this as NotificationsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationsState&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.updatingType, updatingType) || other.updatingType == updatingType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,preferences,updatingType,status);

@override
String toString() {
  return 'NotificationsState(preferences: $preferences, updatingType: $updatingType, status: $status)';
}


}

/// @nodoc
abstract mixin class $NotificationsStateCopyWith<$Res>  {
  factory $NotificationsStateCopyWith(NotificationsState value, $Res Function(NotificationsState) _then) = _$NotificationsStateCopyWithImpl;
@useResult
$Res call({
 UserPreferences? preferences, UserPreferencesNotificationType? updatingType, StateStatus status
});


$StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._self, this._then);

  final NotificationsState _self;
  final $Res Function(NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferences = freezed,Object? updatingType = freezed,Object? status = null,}) {
  return _then(_self.copyWith(
preferences: freezed == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as UserPreferences?,updatingType: freezed == updatingType ? _self.updatingType : updatingType // ignore: cast_nullable_to_non_nullable
as UserPreferencesNotificationType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}
/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}



/// @nodoc


class _NotificationsState implements NotificationsState {
  const _NotificationsState({this.preferences, this.updatingType, this.status = const StateStatus.initial()});
  

@override final  UserPreferences? preferences;
@override final  UserPreferencesNotificationType? updatingType;
@override@JsonKey() final  StateStatus status;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationsStateCopyWith<_NotificationsState> get copyWith => __$NotificationsStateCopyWithImpl<_NotificationsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationsState&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.updatingType, updatingType) || other.updatingType == updatingType)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,preferences,updatingType,status);

@override
String toString() {
  return 'NotificationsState(preferences: $preferences, updatingType: $updatingType, status: $status)';
}


}

/// @nodoc
abstract mixin class _$NotificationsStateCopyWith<$Res> implements $NotificationsStateCopyWith<$Res> {
  factory _$NotificationsStateCopyWith(_NotificationsState value, $Res Function(_NotificationsState) _then) = __$NotificationsStateCopyWithImpl;
@override @useResult
$Res call({
 UserPreferences? preferences, UserPreferencesNotificationType? updatingType, StateStatus status
});


@override $StateStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$NotificationsStateCopyWithImpl<$Res>
    implements _$NotificationsStateCopyWith<$Res> {
  __$NotificationsStateCopyWithImpl(this._self, this._then);

  final _NotificationsState _self;
  final $Res Function(_NotificationsState) _then;

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferences = freezed,Object? updatingType = freezed,Object? status = null,}) {
  return _then(_NotificationsState(
preferences: freezed == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as UserPreferences?,updatingType: freezed == updatingType ? _self.updatingType : updatingType // ignore: cast_nullable_to_non_nullable
as UserPreferencesNotificationType?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as StateStatus,
  ));
}

/// Create a copy of NotificationsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get status {
  
  return $StateStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
