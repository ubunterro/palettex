part of 'xpalette_cubit.dart';

abstract class XpaletteState extends Equatable {
  const XpaletteState();
}

class XpaletteInitialState extends XpaletteState {
  XpaletteInitialState();

  @override
  List<Object?> get props => [];
}


// библиотека загружена, отображается библиотека
class XpaletteLibraryLoadedState extends XpaletteState{
  const XpaletteLibraryLoadedState();

  @override
  List<Object?> get props => [];
}

// открыта камера
class XpaletteCameraActiveState extends XpaletteState{
  const XpaletteCameraActiveState(this.cameras);
  final List<CameraDescription> cameras;

  @override
  List<Object?> get props => [cameras];
}

// загружается результат
class XpaletteResultLoadingState extends XpaletteState {
  @override
  List<Object?> get props => [];
}

// отображается загруженное изображение с палитрой
class XpaletteResultState extends XpaletteState {
  final ProcessedImage image;
  bool showSavedPopup;

  XpaletteResultState({required this.image, this.showSavedPopup : false});

  @override
  List<Object?> get props => [image, showSavedPopup];
}

// отображается онбординг
class XpaletteOnboardingShownState extends XpaletteState {
  XpaletteOnboardingShownState();

  @override
  List<Object?> get props => [];
}
