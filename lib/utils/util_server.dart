const String SERVER_URL = "http://127.0.0.1:3000/graphql";

class UtilServer {
  static String getInitialContent() {
    return """query{
    headers{
  name
  content
}
 Configuration{
  darkmode
  zoom
  zoom_position
  scrollbar
  scrollbar_position
  fonts
  fonts_value
  headers
  header_index
  sharing
  sharing_providers
  page_link
  polling_updates
  polling_frequency
}
}""";
  }
}
