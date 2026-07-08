// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'core_navigation_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CoreNavigationCommand {

 int get id;
/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreNavigationCommandCopyWith<CoreNavigationCommand> get copyWith => _$CoreNavigationCommandCopyWithImpl<CoreNavigationCommand>(this as CoreNavigationCommand, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreNavigationCommand&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'CoreNavigationCommand(id: $id)';
}


}

/// @nodoc
abstract mixin class $CoreNavigationCommandCopyWith<$Res>  {
  factory $CoreNavigationCommandCopyWith(CoreNavigationCommand value, $Res Function(CoreNavigationCommand) _then) = _$CoreNavigationCommandCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class _$CoreNavigationCommandCopyWithImpl<$Res>
    implements $CoreNavigationCommandCopyWith<$Res> {
  _$CoreNavigationCommandCopyWithImpl(this._self, this._then);

  final CoreNavigationCommand _self;
  final $Res Function(CoreNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}



/// @nodoc


class PushNavigationCommand extends CoreNavigationCommand {
  const PushNavigationCommand({required this.id, required this.route}): super._();
  

@override final  int id;
 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PushNavigationCommandCopyWith<PushNavigationCommand> get copyWith => _$PushNavigationCommandCopyWithImpl<PushNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PushNavigationCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,id,route);

@override
String toString() {
  return 'CoreNavigationCommand.push(id: $id, route: $route)';
}


}

/// @nodoc
abstract mixin class $PushNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $PushNavigationCommandCopyWith(PushNavigationCommand value, $Res Function(PushNavigationCommand) _then) = _$PushNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, PageRouteInfo<dynamic> route
});




}
/// @nodoc
class _$PushNavigationCommandCopyWithImpl<$Res>
    implements $PushNavigationCommandCopyWith<$Res> {
  _$PushNavigationCommandCopyWithImpl(this._self, this._then);

  final PushNavigationCommand _self;
  final $Res Function(PushNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? route = null,}) {
  return _then(PushNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class ReplaceNavigationCommand extends CoreNavigationCommand {
  const ReplaceNavigationCommand({required this.id, required this.route}): super._();
  

@override final  int id;
 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplaceNavigationCommandCopyWith<ReplaceNavigationCommand> get copyWith => _$ReplaceNavigationCommandCopyWithImpl<ReplaceNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplaceNavigationCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,id,route);

@override
String toString() {
  return 'CoreNavigationCommand.replace(id: $id, route: $route)';
}


}

/// @nodoc
abstract mixin class $ReplaceNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $ReplaceNavigationCommandCopyWith(ReplaceNavigationCommand value, $Res Function(ReplaceNavigationCommand) _then) = _$ReplaceNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, PageRouteInfo<dynamic> route
});




}
/// @nodoc
class _$ReplaceNavigationCommandCopyWithImpl<$Res>
    implements $ReplaceNavigationCommandCopyWith<$Res> {
  _$ReplaceNavigationCommandCopyWithImpl(this._self, this._then);

  final ReplaceNavigationCommand _self;
  final $Res Function(ReplaceNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? route = null,}) {
  return _then(ReplaceNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class ReplaceAllNavigationCommand extends CoreNavigationCommand {
  const ReplaceAllNavigationCommand({required this.id, required final  List<PageRouteInfo<dynamic>> routes}): _routes = routes,super._();
  

@override final  int id;
 final  List<PageRouteInfo<dynamic>> _routes;
 List<PageRouteInfo<dynamic>> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReplaceAllNavigationCommandCopyWith<ReplaceAllNavigationCommand> get copyWith => _$ReplaceAllNavigationCommandCopyWithImpl<ReplaceAllNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReplaceAllNavigationCommand&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other._routes, _routes));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(_routes));

@override
String toString() {
  return 'CoreNavigationCommand.replaceAll(id: $id, routes: $routes)';
}


}

/// @nodoc
abstract mixin class $ReplaceAllNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $ReplaceAllNavigationCommandCopyWith(ReplaceAllNavigationCommand value, $Res Function(ReplaceAllNavigationCommand) _then) = _$ReplaceAllNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, List<PageRouteInfo<dynamic>> routes
});




}
/// @nodoc
class _$ReplaceAllNavigationCommandCopyWithImpl<$Res>
    implements $ReplaceAllNavigationCommandCopyWith<$Res> {
  _$ReplaceAllNavigationCommandCopyWithImpl(this._self, this._then);

  final ReplaceAllNavigationCommand _self;
  final $Res Function(ReplaceAllNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? routes = null,}) {
  return _then(ReplaceAllNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,routes: null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<PageRouteInfo<dynamic>>,
  ));
}


}

/// @nodoc


class PopNavigationCommand extends CoreNavigationCommand {
  const PopNavigationCommand({required this.id, this.result}): super._();
  

@override final  int id;
 final  Object? result;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopNavigationCommandCopyWith<PopNavigationCommand> get copyWith => _$PopNavigationCommandCopyWithImpl<PopNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopNavigationCommand&&(identical(other.id, id) || other.id == id)&&const DeepCollectionEquality().equals(other.result, result));
}


@override
int get hashCode => Object.hash(runtimeType,id,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'CoreNavigationCommand.pop(id: $id, result: $result)';
}


}

/// @nodoc
abstract mixin class $PopNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $PopNavigationCommandCopyWith(PopNavigationCommand value, $Res Function(PopNavigationCommand) _then) = _$PopNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, Object? result
});




}
/// @nodoc
class _$PopNavigationCommandCopyWithImpl<$Res>
    implements $PopNavigationCommandCopyWith<$Res> {
  _$PopNavigationCommandCopyWithImpl(this._self, this._then);

  final PopNavigationCommand _self;
  final $Res Function(PopNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? result = freezed,}) {
  return _then(PopNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,result: freezed == result ? _self.result : result ,
  ));
}


}

/// @nodoc


class PopUntilNavigationCommand extends CoreNavigationCommand {
  const PopUntilNavigationCommand({required this.id, required this.route}): super._();
  

@override final  int id;
 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopUntilNavigationCommandCopyWith<PopUntilNavigationCommand> get copyWith => _$PopUntilNavigationCommandCopyWithImpl<PopUntilNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopUntilNavigationCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,id,route);

@override
String toString() {
  return 'CoreNavigationCommand.popUntil(id: $id, route: $route)';
}


}

/// @nodoc
abstract mixin class $PopUntilNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $PopUntilNavigationCommandCopyWith(PopUntilNavigationCommand value, $Res Function(PopUntilNavigationCommand) _then) = _$PopUntilNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, PageRouteInfo<dynamic> route
});




}
/// @nodoc
class _$PopUntilNavigationCommandCopyWithImpl<$Res>
    implements $PopUntilNavigationCommandCopyWith<$Res> {
  _$PopUntilNavigationCommandCopyWithImpl(this._self, this._then);

  final PopUntilNavigationCommand _self;
  final $Res Function(PopUntilNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? route = null,}) {
  return _then(PopUntilNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,route: null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class OpenDeepLinkNavigationCommand extends CoreNavigationCommand {
  const OpenDeepLinkNavigationCommand({required this.id, required this.uri}): super._();
  

@override final  int id;
 final  Uri uri;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OpenDeepLinkNavigationCommandCopyWith<OpenDeepLinkNavigationCommand> get copyWith => _$OpenDeepLinkNavigationCommandCopyWithImpl<OpenDeepLinkNavigationCommand>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OpenDeepLinkNavigationCommand&&(identical(other.id, id) || other.id == id)&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,id,uri);

@override
String toString() {
  return 'CoreNavigationCommand.openDeepLink(id: $id, uri: $uri)';
}


}

/// @nodoc
abstract mixin class $OpenDeepLinkNavigationCommandCopyWith<$Res> implements $CoreNavigationCommandCopyWith<$Res> {
  factory $OpenDeepLinkNavigationCommandCopyWith(OpenDeepLinkNavigationCommand value, $Res Function(OpenDeepLinkNavigationCommand) _then) = _$OpenDeepLinkNavigationCommandCopyWithImpl;
@override @useResult
$Res call({
 int id, Uri uri
});




}
/// @nodoc
class _$OpenDeepLinkNavigationCommandCopyWithImpl<$Res>
    implements $OpenDeepLinkNavigationCommandCopyWith<$Res> {
  _$OpenDeepLinkNavigationCommandCopyWithImpl(this._self, this._then);

  final OpenDeepLinkNavigationCommand _self;
  final $Res Function(OpenDeepLinkNavigationCommand) _then;

/// Create a copy of CoreNavigationCommand
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? uri = null,}) {
  return _then(OpenDeepLinkNavigationCommand(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

/// @nodoc
mixin _$CoreNavigationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreNavigationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CoreNavigationEvent()';
}


}

/// @nodoc
class $CoreNavigationEventCopyWith<$Res>  {
$CoreNavigationEventCopyWith(CoreNavigationEvent _, $Res Function(CoreNavigationEvent) __);
}



/// @nodoc


class _PushRequested implements CoreNavigationEvent {
  const _PushRequested(this.route);
  

 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PushRequestedCopyWith<_PushRequested> get copyWith => __$PushRequestedCopyWithImpl<_PushRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PushRequested&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,route);

@override
String toString() {
  return 'CoreNavigationEvent.push(route: $route)';
}


}

/// @nodoc
abstract mixin class _$PushRequestedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$PushRequestedCopyWith(_PushRequested value, $Res Function(_PushRequested) _then) = __$PushRequestedCopyWithImpl;
@useResult
$Res call({
 PageRouteInfo<dynamic> route
});




}
/// @nodoc
class __$PushRequestedCopyWithImpl<$Res>
    implements _$PushRequestedCopyWith<$Res> {
  __$PushRequestedCopyWithImpl(this._self, this._then);

  final _PushRequested _self;
  final $Res Function(_PushRequested) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,}) {
  return _then(_PushRequested(
null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class _ReplaceRequested implements CoreNavigationEvent {
  const _ReplaceRequested(this.route);
  

 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplaceRequestedCopyWith<_ReplaceRequested> get copyWith => __$ReplaceRequestedCopyWithImpl<_ReplaceRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplaceRequested&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,route);

@override
String toString() {
  return 'CoreNavigationEvent.replace(route: $route)';
}


}

/// @nodoc
abstract mixin class _$ReplaceRequestedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$ReplaceRequestedCopyWith(_ReplaceRequested value, $Res Function(_ReplaceRequested) _then) = __$ReplaceRequestedCopyWithImpl;
@useResult
$Res call({
 PageRouteInfo<dynamic> route
});




}
/// @nodoc
class __$ReplaceRequestedCopyWithImpl<$Res>
    implements _$ReplaceRequestedCopyWith<$Res> {
  __$ReplaceRequestedCopyWithImpl(this._self, this._then);

  final _ReplaceRequested _self;
  final $Res Function(_ReplaceRequested) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,}) {
  return _then(_ReplaceRequested(
null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class _ReplaceAllRequested implements CoreNavigationEvent {
  const _ReplaceAllRequested(final  List<PageRouteInfo<dynamic>> routes): _routes = routes;
  

 final  List<PageRouteInfo<dynamic>> _routes;
 List<PageRouteInfo<dynamic>> get routes {
  if (_routes is EqualUnmodifiableListView) return _routes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routes);
}


/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReplaceAllRequestedCopyWith<_ReplaceAllRequested> get copyWith => __$ReplaceAllRequestedCopyWithImpl<_ReplaceAllRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReplaceAllRequested&&const DeepCollectionEquality().equals(other._routes, _routes));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_routes));

@override
String toString() {
  return 'CoreNavigationEvent.replaceAll(routes: $routes)';
}


}

/// @nodoc
abstract mixin class _$ReplaceAllRequestedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$ReplaceAllRequestedCopyWith(_ReplaceAllRequested value, $Res Function(_ReplaceAllRequested) _then) = __$ReplaceAllRequestedCopyWithImpl;
@useResult
$Res call({
 List<PageRouteInfo<dynamic>> routes
});




}
/// @nodoc
class __$ReplaceAllRequestedCopyWithImpl<$Res>
    implements _$ReplaceAllRequestedCopyWith<$Res> {
  __$ReplaceAllRequestedCopyWithImpl(this._self, this._then);

  final _ReplaceAllRequested _self;
  final $Res Function(_ReplaceAllRequested) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? routes = null,}) {
  return _then(_ReplaceAllRequested(
null == routes ? _self._routes : routes // ignore: cast_nullable_to_non_nullable
as List<PageRouteInfo<dynamic>>,
  ));
}


}

/// @nodoc


class _PopRequested implements CoreNavigationEvent {
  const _PopRequested({this.result});
  

 final  Object? result;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopRequestedCopyWith<_PopRequested> get copyWith => __$PopRequestedCopyWithImpl<_PopRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopRequested&&const DeepCollectionEquality().equals(other.result, result));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(result));

@override
String toString() {
  return 'CoreNavigationEvent.pop(result: $result)';
}


}

/// @nodoc
abstract mixin class _$PopRequestedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$PopRequestedCopyWith(_PopRequested value, $Res Function(_PopRequested) _then) = __$PopRequestedCopyWithImpl;
@useResult
$Res call({
 Object? result
});




}
/// @nodoc
class __$PopRequestedCopyWithImpl<$Res>
    implements _$PopRequestedCopyWith<$Res> {
  __$PopRequestedCopyWithImpl(this._self, this._then);

  final _PopRequested _self;
  final $Res Function(_PopRequested) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = freezed,}) {
  return _then(_PopRequested(
result: freezed == result ? _self.result : result ,
  ));
}


}

/// @nodoc


class _PopUntilRequested implements CoreNavigationEvent {
  const _PopUntilRequested(this.route);
  

 final  PageRouteInfo<dynamic> route;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopUntilRequestedCopyWith<_PopUntilRequested> get copyWith => __$PopUntilRequestedCopyWithImpl<_PopUntilRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopUntilRequested&&(identical(other.route, route) || other.route == route));
}


@override
int get hashCode => Object.hash(runtimeType,route);

@override
String toString() {
  return 'CoreNavigationEvent.popUntil(route: $route)';
}


}

/// @nodoc
abstract mixin class _$PopUntilRequestedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$PopUntilRequestedCopyWith(_PopUntilRequested value, $Res Function(_PopUntilRequested) _then) = __$PopUntilRequestedCopyWithImpl;
@useResult
$Res call({
 PageRouteInfo<dynamic> route
});




}
/// @nodoc
class __$PopUntilRequestedCopyWithImpl<$Res>
    implements _$PopUntilRequestedCopyWith<$Res> {
  __$PopUntilRequestedCopyWithImpl(this._self, this._then);

  final _PopUntilRequested _self;
  final $Res Function(_PopUntilRequested) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? route = null,}) {
  return _then(_PopUntilRequested(
null == route ? _self.route : route // ignore: cast_nullable_to_non_nullable
as PageRouteInfo<dynamic>,
  ));
}


}

/// @nodoc


class _DeepLinkReceived implements CoreNavigationEvent {
  const _DeepLinkReceived(this.uri);
  

 final  Uri uri;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeepLinkReceivedCopyWith<_DeepLinkReceived> get copyWith => __$DeepLinkReceivedCopyWithImpl<_DeepLinkReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeepLinkReceived&&(identical(other.uri, uri) || other.uri == uri));
}


@override
int get hashCode => Object.hash(runtimeType,uri);

@override
String toString() {
  return 'CoreNavigationEvent.deepLinkReceived(uri: $uri)';
}


}

/// @nodoc
abstract mixin class _$DeepLinkReceivedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$DeepLinkReceivedCopyWith(_DeepLinkReceived value, $Res Function(_DeepLinkReceived) _then) = __$DeepLinkReceivedCopyWithImpl;
@useResult
$Res call({
 Uri uri
});




}
/// @nodoc
class __$DeepLinkReceivedCopyWithImpl<$Res>
    implements _$DeepLinkReceivedCopyWith<$Res> {
  __$DeepLinkReceivedCopyWithImpl(this._self, this._then);

  final _DeepLinkReceived _self;
  final $Res Function(_DeepLinkReceived) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? uri = null,}) {
  return _then(_DeepLinkReceived(
null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as Uri,
  ));
}


}

/// @nodoc


class _CommandHandled implements CoreNavigationEvent {
  const _CommandHandled(this.commandId);
  

 final  int commandId;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CommandHandledCopyWith<_CommandHandled> get copyWith => __$CommandHandledCopyWithImpl<_CommandHandled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CommandHandled&&(identical(other.commandId, commandId) || other.commandId == commandId));
}


@override
int get hashCode => Object.hash(runtimeType,commandId);

@override
String toString() {
  return 'CoreNavigationEvent.commandHandled(commandId: $commandId)';
}


}

/// @nodoc
abstract mixin class _$CommandHandledCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$CommandHandledCopyWith(_CommandHandled value, $Res Function(_CommandHandled) _then) = __$CommandHandledCopyWithImpl;
@useResult
$Res call({
 int commandId
});




}
/// @nodoc
class __$CommandHandledCopyWithImpl<$Res>
    implements _$CommandHandledCopyWith<$Res> {
  __$CommandHandledCopyWithImpl(this._self, this._then);

  final _CommandHandled _self;
  final $Res Function(_CommandHandled) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? commandId = null,}) {
  return _then(_CommandHandled(
null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _StackSynchronized implements CoreNavigationEvent {
  const _StackSynchronized(final  List<PageRouteInfo<dynamic>> stack): _stack = stack;
  

 final  List<PageRouteInfo<dynamic>> _stack;
 List<PageRouteInfo<dynamic>> get stack {
  if (_stack is EqualUnmodifiableListView) return _stack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stack);
}


/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StackSynchronizedCopyWith<_StackSynchronized> get copyWith => __$StackSynchronizedCopyWithImpl<_StackSynchronized>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StackSynchronized&&const DeepCollectionEquality().equals(other._stack, _stack));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stack));

@override
String toString() {
  return 'CoreNavigationEvent.stackSynchronized(stack: $stack)';
}


}

/// @nodoc
abstract mixin class _$StackSynchronizedCopyWith<$Res> implements $CoreNavigationEventCopyWith<$Res> {
  factory _$StackSynchronizedCopyWith(_StackSynchronized value, $Res Function(_StackSynchronized) _then) = __$StackSynchronizedCopyWithImpl;
@useResult
$Res call({
 List<PageRouteInfo<dynamic>> stack
});




}
/// @nodoc
class __$StackSynchronizedCopyWithImpl<$Res>
    implements _$StackSynchronizedCopyWith<$Res> {
  __$StackSynchronizedCopyWithImpl(this._self, this._then);

  final _StackSynchronized _self;
  final $Res Function(_StackSynchronized) _then;

/// Create a copy of CoreNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stack = null,}) {
  return _then(_StackSynchronized(
null == stack ? _self._stack : stack // ignore: cast_nullable_to_non_nullable
as List<PageRouteInfo<dynamic>>,
  ));
}


}

/// @nodoc
mixin _$CoreNavigationState {

 List<PageRouteInfo<dynamic>> get stack; List<CoreNavigationCommand> get pendingCommands; Uri? get lastDeepLink;
/// Create a copy of CoreNavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CoreNavigationStateCopyWith<CoreNavigationState> get copyWith => _$CoreNavigationStateCopyWithImpl<CoreNavigationState>(this as CoreNavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CoreNavigationState&&const DeepCollectionEquality().equals(other.stack, stack)&&const DeepCollectionEquality().equals(other.pendingCommands, pendingCommands)&&(identical(other.lastDeepLink, lastDeepLink) || other.lastDeepLink == lastDeepLink));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(stack),const DeepCollectionEquality().hash(pendingCommands),lastDeepLink);

@override
String toString() {
  return 'CoreNavigationState(stack: $stack, pendingCommands: $pendingCommands, lastDeepLink: $lastDeepLink)';
}


}

/// @nodoc
abstract mixin class $CoreNavigationStateCopyWith<$Res>  {
  factory $CoreNavigationStateCopyWith(CoreNavigationState value, $Res Function(CoreNavigationState) _then) = _$CoreNavigationStateCopyWithImpl;
@useResult
$Res call({
 List<PageRouteInfo<dynamic>> stack, List<CoreNavigationCommand> pendingCommands, Uri? lastDeepLink
});




}
/// @nodoc
class _$CoreNavigationStateCopyWithImpl<$Res>
    implements $CoreNavigationStateCopyWith<$Res> {
  _$CoreNavigationStateCopyWithImpl(this._self, this._then);

  final CoreNavigationState _self;
  final $Res Function(CoreNavigationState) _then;

/// Create a copy of CoreNavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stack = null,Object? pendingCommands = null,Object? lastDeepLink = freezed,}) {
  return _then(_self.copyWith(
stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as List<PageRouteInfo<dynamic>>,pendingCommands: null == pendingCommands ? _self.pendingCommands : pendingCommands // ignore: cast_nullable_to_non_nullable
as List<CoreNavigationCommand>,lastDeepLink: freezed == lastDeepLink ? _self.lastDeepLink : lastDeepLink // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}

}



/// @nodoc


class _CoreNavigationState implements CoreNavigationState {
  const _CoreNavigationState({final  List<PageRouteInfo<dynamic>> stack = const <PageRouteInfo<dynamic>>[], final  List<CoreNavigationCommand> pendingCommands = const <CoreNavigationCommand>[], this.lastDeepLink}): _stack = stack,_pendingCommands = pendingCommands;
  

 final  List<PageRouteInfo<dynamic>> _stack;
@override@JsonKey() List<PageRouteInfo<dynamic>> get stack {
  if (_stack is EqualUnmodifiableListView) return _stack;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stack);
}

 final  List<CoreNavigationCommand> _pendingCommands;
@override@JsonKey() List<CoreNavigationCommand> get pendingCommands {
  if (_pendingCommands is EqualUnmodifiableListView) return _pendingCommands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingCommands);
}

@override final  Uri? lastDeepLink;

/// Create a copy of CoreNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CoreNavigationStateCopyWith<_CoreNavigationState> get copyWith => __$CoreNavigationStateCopyWithImpl<_CoreNavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CoreNavigationState&&const DeepCollectionEquality().equals(other._stack, _stack)&&const DeepCollectionEquality().equals(other._pendingCommands, _pendingCommands)&&(identical(other.lastDeepLink, lastDeepLink) || other.lastDeepLink == lastDeepLink));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_stack),const DeepCollectionEquality().hash(_pendingCommands),lastDeepLink);

@override
String toString() {
  return 'CoreNavigationState(stack: $stack, pendingCommands: $pendingCommands, lastDeepLink: $lastDeepLink)';
}


}

/// @nodoc
abstract mixin class _$CoreNavigationStateCopyWith<$Res> implements $CoreNavigationStateCopyWith<$Res> {
  factory _$CoreNavigationStateCopyWith(_CoreNavigationState value, $Res Function(_CoreNavigationState) _then) = __$CoreNavigationStateCopyWithImpl;
@override @useResult
$Res call({
 List<PageRouteInfo<dynamic>> stack, List<CoreNavigationCommand> pendingCommands, Uri? lastDeepLink
});




}
/// @nodoc
class __$CoreNavigationStateCopyWithImpl<$Res>
    implements _$CoreNavigationStateCopyWith<$Res> {
  __$CoreNavigationStateCopyWithImpl(this._self, this._then);

  final _CoreNavigationState _self;
  final $Res Function(_CoreNavigationState) _then;

/// Create a copy of CoreNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stack = null,Object? pendingCommands = null,Object? lastDeepLink = freezed,}) {
  return _then(_CoreNavigationState(
stack: null == stack ? _self._stack : stack // ignore: cast_nullable_to_non_nullable
as List<PageRouteInfo<dynamic>>,pendingCommands: null == pendingCommands ? _self._pendingCommands : pendingCommands // ignore: cast_nullable_to_non_nullable
as List<CoreNavigationCommand>,lastDeepLink: freezed == lastDeepLink ? _self.lastDeepLink : lastDeepLink // ignore: cast_nullable_to_non_nullable
as Uri?,
  ));
}


}

// dart format on
