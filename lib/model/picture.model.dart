import 'dart:convert';

class Picture {
  String id;
  String author;
  int width;
  int height;
  Uri url;
  Uri downloadUrl;

  Picture(
      {this.id,
      this.author,
      this.width,
      this.height,
      this.url,
      this.downloadUrl});

  Picture.fromJson(String json) {
    Picture.fromMap(jsonDecode(json));
  }

  Picture.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    author = map['author'];
    width = map['width'];
    height = map['height'];
    url = Uri.tryParse(map['url']);
    downloadUrl = Uri.tryParse(map['download_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['author'] = this.author;
    data['width'] = this.width;
    data['height'] = this.height;
    data['url'] = this.url.toString();
    data['download_url'] = this.downloadUrl.toString();
    return data;
  }
}
