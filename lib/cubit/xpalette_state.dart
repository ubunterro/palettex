part of 'xpalette_cubit.dart';

abstract class XpaletteState extends Equatable {
  const XpaletteState();
}

class XpaletteInitialState extends XpaletteState {
  XpaletteInitialState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class XpaletteLoadingState extends XpaletteState {
  XpaletteLoadingState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}


class XpaletteLibraryLoadedState extends XpaletteState{


  const XpaletteLibraryLoadedState();

  @override
  List<Object?> get props => [];

}

class XpaletteResultLoadingState extends XpaletteState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class XpaletteResultState extends XpaletteState {
  final ProcessedImage image;

  const XpaletteResultState({required this.image});

  @override
  List<Object?> get props => [image];


}
