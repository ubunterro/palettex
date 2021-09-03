part of 'xpalette_cubit.dart';

abstract class XpaletteState extends Equatable {
  const XpaletteState();
}

class XpaletteInitialState extends XpaletteState {
  XpaletteInitialState();

  @override
  List<Object?> get props => [];
}

class XpaletteLoadingState extends XpaletteState {
  XpaletteLoadingState();

  @override
  List<Object?> get props => [];
}


class XpaletteLibraryLoadedState extends XpaletteState{
  const XpaletteLibraryLoadedState();

  @override
  List<Object?> get props => [];
}

class XpaletteCameraActiveState extends XpaletteState{
  const XpaletteCameraActiveState();

  @override
  List<Object?> get props => [];
}

class XpaletteResultLoadingState extends XpaletteState {
  @override
  List<Object?> get props => [];
}

class XpaletteResultState extends XpaletteState {
  final ProcessedImage image;

  const XpaletteResultState({required this.image});

  @override
  List<Object?> get props => [image];
}

class XpaletteOnboardingShownState extends XpaletteState {
  XpaletteOnboardingShownState();

  @override
  List<Object?> get props => [];
}
