/// The DTO used to store the configuration information from the server
/// loaded once on startup
class DTOConfiguration {
  bool? darkmode;
  bool? zoom;
  double? zoomPosition;
  bool? scrollbar;
  double? scrollbarPosition;
  bool? fonts;
  String? fontsValue;
  bool? headers;
  int? headerIndex;
  bool? sharing;
  List<String>? sharingProviders;
  bool? pageLink;
  bool? pollingUpdates;
  int? pollingFrequency;

  DTOConfiguration.empty();

  DTOConfiguration(
      this.darkmode,
      this.zoom,
      this.zoomPosition,
      this.scrollbar,
      this.scrollbarPosition,
      this.fonts,
      this.fontsValue,
      this.headers,
      this.headerIndex,
      this.sharing,
      this.sharingProviders,
      this.pageLink,
      this.pollingUpdates,
      this.pollingFrequency);
}
