enum ScreenType { mobile, tablet, desktop }

ScreenType getScreenType(double width) {
  if (width < 600) return ScreenType.mobile;
  if (width < 1024) return ScreenType.tablet;
  return ScreenType.desktop;
}
