import 'package:dun_cookie_flutter/common/browser/main.dart';
import 'package:dun_cookie_flutter/common/tool/color_theme.dart';
import 'package:dun_cookie_flutter/common/tool/dun_toast.dart';
import 'package:dun_cookie_flutter/common/tool/open_app_or_browser.dart';
import 'package:dun_cookie_flutter/model/ceobecanteen_data.dart';
import 'package:dun_cookie_flutter/model/source_info.dart';
import 'package:dun_cookie_flutter/provider/common_event_bus.dart';
import 'package:dun_cookie_flutter/provider/setting_provider.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class ToolLink extends StatefulWidget {
  ToolLink(this.linkInfo, {Key? key});

  dynamic linkInfo;

  @override
  State<ToolLink> createState() => _ToolLinkState();
}

class _ToolLinkState extends State<ToolLink> {
  late String url;
  late String image;
  late String title;
  late bool hasShortcut;
  String? jumpApp;

  @override
  void initState() {
    if (widget.linkInfo is SourceInfo) {
      url = widget.linkInfo.jumpUrl;
      image = widget.linkInfo.icon;
      title = widget.linkInfo.title;
      jumpApp = widget.linkInfo.jumpApp;
    }

    if (widget.linkInfo is QuickJump) {
      url = widget.linkInfo.url;
      image = widget.linkInfo.img;
      title = widget.linkInfo.name;
    }

    var settingData = Provider.of<SettingProvider>(context, listen: false);
    hasShortcut = settingData.appSetting.shortcutList!.contains(title);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10),
        child: Stack(
          alignment:Alignment.centerLeft,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    child: Image.asset(
                      image,
                      width: 30,
                    ),
                    borderRadius: BorderRadius.circular(4)),
                const SizedBox(
                  width: 5,
                ),
                Text(title)
              ],
            ),
            Positioned(
              child: hasShortcut
                  ? const Icon(
                      Icons.menu_open,
                      size: 16,
                      color: DunColors.DunColor,
                    )
                  : Container(),
              top: 3,
              right: 3,
            )
          ],
        ),
      ),
      onLongPress: () {
        if (widget.linkInfo is QuickJump) {
          _handleShortcut(title, !hasShortcut);
        }
      },
      onTap: () {
        _openApp(url: url, jumpApp: jumpApp);
      },
    );
  }

  _openApp({url, jumpApp}) async {
    OpenAppOrBrowser.openUrl(url, context, appUrlScheme: jumpApp);
  }

  _handleShortcut(title, isAdd) async {
    setState(() {
      hasShortcut = isAdd;
    });
    var settingData = Provider.of<SettingProvider>(context, listen: false);
    if (isAdd) {
      settingData.appSetting.shortcutList!.add(title);
    } else {
      settingData.appSetting.shortcutList!.remove(title);
    }
    eventBus.fire(ChangeMenu());
    settingData.saveAppSetting();
    var hasAmplitude = await Vibration.hasAmplitudeControl();
    if (hasAmplitude != null && hasAmplitude) {
      Vibration.vibrate(duration: 100,amplitude: 100);
    }
  }
}
