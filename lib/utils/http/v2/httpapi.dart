import 'package:ices_live_viewer/model/liveroom.dart';
import 'package:ices_live_viewer/utils/http/v2/douyu.dart';
import 'package:ices_live_viewer/utils/http/v2/huya.dart';

///the api interface
class HttpApi {
  static Future<SingleRoom> getLiveInfo(SingleRoom singleRoom) {
    switch (singleRoom.platform) {
      case 'huya':
        return HuyaApi.getLiveInfo(singleRoom.link);
      case 'douyu':
        print('douyu');
        return DouyuApi.getRoomFullInfo(singleRoom);
      default:
        return Future(() => singleRoom);
    }
  }
}
