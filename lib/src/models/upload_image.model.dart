class UploadFileResponse {
  bool? success;
  String? message;
  int? code;
  FileResponse? file;

  UploadFileResponse({this.success, this.message, this.code, this.file});

  UploadFileResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    code = json['code'];
    if (json['file'] != null) {
      file = FileResponse.fromJson(json['file']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    data['code'] = code;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    return data;
  }
}

class FileResponse {
  String? fieldname;
  String? originalname;
  String? encoding;
  String? mimetype;
  String? destination;
  String? filename;
  String? path;
  int? size;
  String? filePath;

  FileResponse({
    this.fieldname,
    this.originalname,
    this.encoding,
    this.mimetype,
    this.destination,
    this.filename,
    this.path,
    this.size,
    this.filePath,
  });

  FileResponse.fromJson(Map<String, dynamic> json) {
    fieldname = json['fieldname'];
    originalname = json['originalname'];
    encoding = json['encoding'];
    mimetype = json['mimetype'];
    destination = json['destination'];
    filename = json['filename'];
    path = json['path'];
    size = json['size'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['fieldname'] = fieldname;
    data['originalname'] = originalname;
    data['encoding'] = encoding;
    data['mimetype'] = mimetype;
    data['destination'] = destination;
    data['filename'] = filename;
    data['path'] = path;
    data['size'] = size;
    data['filePath'] = filePath;
    return data;
  }
}
