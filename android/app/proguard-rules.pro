# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/chenmengjia/Library/Android/sdk/tools/proguard/proguard-rules.pro
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-dontwarn com.meizu.**
-keep class com.mob.**{*;}
-dontwarn com.mob.**

#xiaomi
-keep class com.xiaomi.{*;}
-dontwarn com.xiaomi.
-keep class org.apache.thrift.**{*;}
-keep class android.os.SystemProperties
-dontwarn android.os.SystemProperties

#FCM
-keep class com.google.{*;}
-dontwarn com.google.

#VIVO
-keep class com.vivo.push.{*; }
-keep class com.vivo.vms.{*; }
-dontwarn com.vivo.push.**

#OPPO
-keep class com.coloros.** {*;}
-dontwarn com.coloros.**