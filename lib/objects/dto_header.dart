/// Represents a header of the page prototype, also used in the header selection list
class DTOHeader {
  String? content;
  String? name;

  DTOHeader(this.content, this.name);

  DTOHeader.dummy();


  bool hasEmail(){
    return content?.contains("email")??false;
  }

  bool hasAddress(){
    return content?.contains("abs")??false;
  }

  bool hasNote(){
    return content?.contains("Bemerkung")??false;//TODO adjust
  }

  bool hasDate(){
    return content?.contains("date")??false;
  }

}
