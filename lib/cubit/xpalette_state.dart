part of 'xpalette_cubit.dart';

abstract class XpaletteState extends Equatable {
  const XpaletteState();
}

class XpaletteInitialState extends XpaletteState {
  const XpaletteInitialState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class XpaletteResultLoadingState extends XpaletteState{
  @override
  List<Object?> get props => throw UnimplementedError();
}

class XpaletteResultState extends XpaletteState{
  final ImageProvider image;
  final PaletteGenerator palette;

  const XpaletteResultState({required this.image, required this.palette});

  @override
  List<Object?> get props => [image];


}
