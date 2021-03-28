import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const String SERVER_URL = "http://127.0.0.1:3000/graphql";

class HelperServer {
  static String getHeaders() {
    return """query{
    headers{
  name
  content
}
}""";
  }
  static String getBodies() {
    return """query{
    bodies{
  name
  content
}
}""";
  }
  static String getFooters() {
    return """query{
    footers{
  name
  content
}
}""";
  }
}
