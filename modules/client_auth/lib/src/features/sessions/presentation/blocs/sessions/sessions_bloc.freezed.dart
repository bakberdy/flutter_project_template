// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sessions_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsEvent()';
}


}

/// @nodoc
class $SessionsEventCopyWith<$Res>  {
$SessionsEventCopyWith(SessionsEvent _, $Res Function(SessionsEvent) __);
}



/// @nodoc


class _Started implements SessionsEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsEvent.started()';
}


}




/// @nodoc


class _Refreshed implements SessionsEvent {
  const _Refreshed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Refreshed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsEvent.refreshed()';
}


}




/// @nodoc


class _SessionRevokeRequested implements SessionsEvent {
  const _SessionRevokeRequested(this.sessionId);
  

 final  String sessionId;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionRevokeRequestedCopyWith<_SessionRevokeRequested> get copyWith => __$SessionRevokeRequestedCopyWithImpl<_SessionRevokeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionRevokeRequested&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId);

@override
String toString() {
  return 'SessionsEvent.sessionRevokeRequested(sessionId: $sessionId)';
}


}

/// @nodoc
abstract mixin class _$SessionRevokeRequestedCopyWith<$Res> implements $SessionsEventCopyWith<$Res> {
  factory _$SessionRevokeRequestedCopyWith(_SessionRevokeRequested value, $Res Function(_SessionRevokeRequested) _then) = __$SessionRevokeRequestedCopyWithImpl;
@useResult
$Res call({
 String sessionId
});




}
/// @nodoc
class __$SessionRevokeRequestedCopyWithImpl<$Res>
    implements _$SessionRevokeRequestedCopyWith<$Res> {
  __$SessionRevokeRequestedCopyWithImpl(this._self, this._then);

  final _SessionRevokeRequested _self;
  final $Res Function(_SessionRevokeRequested) _then;

/// Create a copy of SessionsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,}) {
  return _then(_SessionRevokeRequested(
null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _RevokeAllRequested implements SessionsEvent {
  const _RevokeAllRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RevokeAllRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsEvent.revokeAllRequested()';
}


}




/// @nodoc


class _TransientFailureAcknowledged implements SessionsEvent {
  const _TransientFailureAcknowledged();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransientFailureAcknowledged);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionsEvent.transientFailureAcknowledged()';
}


}




/// @nodoc
mixin _$SessionsState {

 List<Session> get sessions; StateStatus get listStatus; Failure? get transientActionFailure; String? get revokingSessionId; bool get revokingAll; bool get navigateToAuthAfterRevokeAll;
/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionsStateCopyWith<SessionsState> get copyWith => _$SessionsStateCopyWithImpl<SessionsState>(this as SessionsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionsState&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&(identical(other.transientActionFailure, transientActionFailure) || other.transientActionFailure == transientActionFailure)&&(identical(other.revokingSessionId, revokingSessionId) || other.revokingSessionId == revokingSessionId)&&(identical(other.revokingAll, revokingAll) || other.revokingAll == revokingAll)&&(identical(other.navigateToAuthAfterRevokeAll, navigateToAuthAfterRevokeAll) || other.navigateToAuthAfterRevokeAll == navigateToAuthAfterRevokeAll));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sessions),listStatus,transientActionFailure,revokingSessionId,revokingAll,navigateToAuthAfterRevokeAll);

@override
String toString() {
  return 'SessionsState(sessions: $sessions, listStatus: $listStatus, transientActionFailure: $transientActionFailure, revokingSessionId: $revokingSessionId, revokingAll: $revokingAll, navigateToAuthAfterRevokeAll: $navigateToAuthAfterRevokeAll)';
}


}

/// @nodoc
abstract mixin class $SessionsStateCopyWith<$Res>  {
  factory $SessionsStateCopyWith(SessionsState value, $Res Function(SessionsState) _then) = _$SessionsStateCopyWithImpl;
@useResult
$Res call({
 List<Session> sessions, StateStatus listStatus, Failure? transientActionFailure, String? revokingSessionId, bool revokingAll, bool navigateToAuthAfterRevokeAll
});


$StateStatusCopyWith<$Res> get listStatus;

}
/// @nodoc
class _$SessionsStateCopyWithImpl<$Res>
    implements $SessionsStateCopyWith<$Res> {
  _$SessionsStateCopyWithImpl(this._self, this._then);

  final SessionsState _self;
  final $Res Function(SessionsState) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessions = null,Object? listStatus = null,Object? transientActionFailure = freezed,Object? revokingSessionId = freezed,Object? revokingAll = null,Object? navigateToAuthAfterRevokeAll = null,}) {
  return _then(_self.copyWith(
sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<Session>,listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,transientActionFailure: freezed == transientActionFailure ? _self.transientActionFailure : transientActionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,revokingSessionId: freezed == revokingSessionId ? _self.revokingSessionId : revokingSessionId // ignore: cast_nullable_to_non_nullable
as String?,revokingAll: null == revokingAll ? _self.revokingAll : revokingAll // ignore: cast_nullable_to_non_nullable
as bool,navigateToAuthAfterRevokeAll: null == navigateToAuthAfterRevokeAll ? _self.navigateToAuthAfterRevokeAll : navigateToAuthAfterRevokeAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get listStatus {
  
  return $StateStatusCopyWith<$Res>(_self.listStatus, (value) {
    return _then(_self.copyWith(listStatus: value));
  });
}
}



/// @nodoc


class _SessionsState implements SessionsState {
  const _SessionsState({final  List<Session> sessions = const <Session>[], this.listStatus = const StateStatus.initial(), this.transientActionFailure, this.revokingSessionId, this.revokingAll = false, this.navigateToAuthAfterRevokeAll = false}): _sessions = sessions;
  

 final  List<Session> _sessions;
@override@JsonKey() List<Session> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override@JsonKey() final  StateStatus listStatus;
@override final  Failure? transientActionFailure;
@override final  String? revokingSessionId;
@override@JsonKey() final  bool revokingAll;
@override@JsonKey() final  bool navigateToAuthAfterRevokeAll;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionsStateCopyWith<_SessionsState> get copyWith => __$SessionsStateCopyWithImpl<_SessionsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionsState&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.listStatus, listStatus) || other.listStatus == listStatus)&&(identical(other.transientActionFailure, transientActionFailure) || other.transientActionFailure == transientActionFailure)&&(identical(other.revokingSessionId, revokingSessionId) || other.revokingSessionId == revokingSessionId)&&(identical(other.revokingAll, revokingAll) || other.revokingAll == revokingAll)&&(identical(other.navigateToAuthAfterRevokeAll, navigateToAuthAfterRevokeAll) || other.navigateToAuthAfterRevokeAll == navigateToAuthAfterRevokeAll));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sessions),listStatus,transientActionFailure,revokingSessionId,revokingAll,navigateToAuthAfterRevokeAll);

@override
String toString() {
  return 'SessionsState(sessions: $sessions, listStatus: $listStatus, transientActionFailure: $transientActionFailure, revokingSessionId: $revokingSessionId, revokingAll: $revokingAll, navigateToAuthAfterRevokeAll: $navigateToAuthAfterRevokeAll)';
}


}

/// @nodoc
abstract mixin class _$SessionsStateCopyWith<$Res> implements $SessionsStateCopyWith<$Res> {
  factory _$SessionsStateCopyWith(_SessionsState value, $Res Function(_SessionsState) _then) = __$SessionsStateCopyWithImpl;
@override @useResult
$Res call({
 List<Session> sessions, StateStatus listStatus, Failure? transientActionFailure, String? revokingSessionId, bool revokingAll, bool navigateToAuthAfterRevokeAll
});


@override $StateStatusCopyWith<$Res> get listStatus;

}
/// @nodoc
class __$SessionsStateCopyWithImpl<$Res>
    implements _$SessionsStateCopyWith<$Res> {
  __$SessionsStateCopyWithImpl(this._self, this._then);

  final _SessionsState _self;
  final $Res Function(_SessionsState) _then;

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessions = null,Object? listStatus = null,Object? transientActionFailure = freezed,Object? revokingSessionId = freezed,Object? revokingAll = null,Object? navigateToAuthAfterRevokeAll = null,}) {
  return _then(_SessionsState(
sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<Session>,listStatus: null == listStatus ? _self.listStatus : listStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,transientActionFailure: freezed == transientActionFailure ? _self.transientActionFailure : transientActionFailure // ignore: cast_nullable_to_non_nullable
as Failure?,revokingSessionId: freezed == revokingSessionId ? _self.revokingSessionId : revokingSessionId // ignore: cast_nullable_to_non_nullable
as String?,revokingAll: null == revokingAll ? _self.revokingAll : revokingAll // ignore: cast_nullable_to_non_nullable
as bool,navigateToAuthAfterRevokeAll: null == navigateToAuthAfterRevokeAll ? _self.navigateToAuthAfterRevokeAll : navigateToAuthAfterRevokeAll // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of SessionsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StateStatusCopyWith<$Res> get listStatus {
  
  return $StateStatusCopyWith<$Res>(_self.listStatus, (value) {
    return _then(_self.copyWith(listStatus: value));
  });
}
}

// dart format on
