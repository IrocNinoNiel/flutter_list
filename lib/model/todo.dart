class Todo {
  int _id;
  String _title;
  bool _status;

  Todo({int id, String title, bool status}) {
    setID(id);
    setTitle(title);
    setStatus(status);
  }

  setID(id) => this._id = id;
  setTitle(title) => this._title = title;
  setStatus(status) => this._status = status;

  getId() => this._id;
  getTitle() => this._title;
  getStatus() => this._status;

  Map<String, dynamic> toMap() {
    return {'id': getId(), 'title': getTitle(), 'status': getStatus()};
  }
}
