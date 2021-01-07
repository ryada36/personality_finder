import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Map>> _getFriends(pageNo) async {
  var result = await http.get("https://reqres.in/api/users?page=$pageNo");
  Map<dynamic, dynamic> response = json.decode(result.body);
  // print("================ response ================$response");
  return List<Map>.generate(response['data'].length, (int index) {
    return {
      "email": response['data'][index]['email'],
      "first_name": response['data'][index]['first_name'],
      "last_name": response['data'][index]['last_name'],
      "avatar": response['data'][index]['avatar']
    };
  }).toList();
  // return response['data'] as List<Map>;
}

class FriendsModel {
  Stream<List<Map>> stream;
  bool hasMore;
  bool _isLoading;
  List<Map> data;
  StreamController<List<Map>> _controller;

  FriendsModel() {
    data = List<Map>();
    _controller = StreamController<List<Map>>.broadcast();
    stream = _controller.stream;
    hasMore = true;
    _isLoading = false;
    refresh();
  }

  Future<void> refresh() {
    return loadMore(clearCachedData: true);
  }

  Future<void> loadMore({bool clearCachedData = false, int pageNo = 1}) {
    print('load more called with page number $pageNo');
    if (clearCachedData) {
      data = List<Map>();
      hasMore = true;
    }
    if (_isLoading || !hasMore) {
      return Future.value();
    }
    _isLoading = true;

    return _getFriends(pageNo).then((postsData) {
      _isLoading = false;
      data.addAll(postsData);
      print('total data ${data.length}');
      hasMore = (data.length < 12);
      _controller.add(data);
    });
  }
}
