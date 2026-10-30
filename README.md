# 小刻食堂 Flutter

## Android 开发环境

- FVM 管理的 Flutter **3.19.4**（见 `.fvmrc`）。
- JDK 17、Android SDK 35、NDK 27.0.12077973。
- Gradle 8.9、Android Gradle Plugin 8.7.3、Kotlin 2.1.0。

```powershell
fvm install
fvm use 3.19.4
Copy-Item lib/request/config.example.dart lib/request/config.dart
fvm flutter pub get
fvm flutter run
```

Windows 的 SDK 链接需要启用开发者模式或具备创建符号链接的权限。VS Code 使用 `.fvm/flutter_sdk`，命令行使用 `fvm flutter`，避免混用全局 SDK。

`config.dart` 为本地配置，不提交到 Git；示例默认使用正式服务。`pubspec.lock` 随应用提交，保持 Dart 依赖版本一致。

## 验证与正式构建

```powershell
fvm flutter analyze
fvm flutter test
fvm flutter build apk --release
```

正式包支持 armeabi-v7a、arm64-v8a 和 x86_64，输出为 `build/app/outputs/flutter-apk/app-release.apk`。

构建前在本地准备 `android/key.properties`，配置 `storePassword`、`keyPassword`、`keyAlias`、`storeFile`。`storeFile` 相对于 `android/app` 解析；例如密钥位于 `android/release.jks` 时填写 `../release.jks`。密钥和密码文件不得提交。覆盖升级必须使用与已发布版本相同的签名。

回归测试覆盖接口 HTTP 500、异常响应、更多页面降级、重复加载、漫画加载失败、版本比较、日期解析及懒加载页面索引边界。
