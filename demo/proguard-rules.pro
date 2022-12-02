# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
# JSR 305 annotations are for embedding nullability information.
-ignorewarnings

#======================基础类不混淆=======================
-keep public class * extends com.ted.framework.base.BaseViewModel{*;}
#======================RxJave混淆规则=======================

#======================RxJave混淆规则=======================
-dontwarn java.util.concurrent.Flow*
#======================okhttp混淆规则=======================
-dontwarn javax.annotation.**
# A resource is loaded with a relative path so the package of this class must be preserved.
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*
# OkHttp platform used only on JVM and when Conscrypt dependency is available.
-dontwarn okhttp3.internal.platform.ConscryptPlatform
-dontwarn org.conscrypt.ConscryptHostnameVerifier
# Animal Sniffer compileOnly dependency to ensure APIs are compatible with older versions of Java.
-dontwarn org.codehaus.mojo.animal_sniffer.*


#======================Retrofit混淆规则=======================
# Retrofit does reflection on generic parameters. InnerClasses is required to use Signature and
# EnclosingMethod is required to use InnerClasses.
-keepattributes Signature, InnerClasses, EnclosingMethod
# Retrofit does reflection on method and parameter annotations.
-keepattributes RuntimeVisibleAnnotations, RuntimeVisibleParameterAnnotations
# Retain service method parameters when optimizing.
-keepclassmembers,allowshrinking,allowobfuscation interface * {
    @retrofit2.http.* <methods>;
}
# Ignore annotation used for build tooling.
-dontwarn org.codehaus.mojo.animal_sniffer.IgnoreJRERequirement
# Ignore JSR 305 annotations for embedding nullability information.
-dontwarn javax.annotation.**
# Guarded by a NoClassDefFoundError try/catch and only used when on the classpath.
-dontwarn kotlin.Unit
# Top-level functions that can only be used by Kotlin.
-dontwarn retrofit2.KotlinExtensions
-dontwarn retrofit2.KotlinExtensions$*
# With R8 full mode, it sees no subtypes of Retrofit interfaces since they are created with a Proxy
# and replaces all potential values with null. Explicitly keeping the interfaces prevents this.
-if interface * { @retrofit2.http.* <methods>; }
-keep,allowobfuscation interface <1>


#======================mmkv混淆规则=======================
-renamesourcefileattribute SourceFile
-keepattributes Exceptions,InnerClasses,Signature,Deprecated,SourceFile,LineNumberTable,EnclosingMethod
# Preserve all annotations.
-keepattributes *Annotation*
# Preserve all public classes, and their public and protected fields and
# methods.
-keep public class * {
    public protected *;
}
# Preserve all .class method names.
-keepclassmembernames class * {
    java.lang.Class class$(java.lang.String);
    java.lang.Class class$(java.lang.String, boolean);
}
# Preserve all native method names and the names of their classes.
-keepclasseswithmembernames class * {
    native <methods>;
}
# Preserve the special static methods that are required in all enumeration
# classes.
-keepclassmembers class * extends java.lang.Enum {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
# Explicitly preserve all serialization members. The Serializable interface
# is only a marker interface, so it wouldn't save them.
# You can comment this out if your library doesn't use serialization.
# If your code contains serializable classes that have to be backward
# compatible, please refer to the manual.
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

#======================Arouter=======================
-keep public class com.alibaba.android.arouter.routes.**{*;}
-keep public class com.alibaba.android.arouter.facade.**{*;}
-keep class * implements com.alibaba.android.arouter.facade.template.ISyringe{*;}

# If you use the byType method to obtain Service, add the following rules to protect the interface:
-keep interface * implements com.alibaba.android.arouter.facade.template.IProvider

# If single-type injection is used, that is, no interface is defined to implement IProvider, the following rules need to be added to protect the implementation
# -keep class * implements com.alibaba.android.arouter.facade.template.IProvider


#======================glide=======================
-keep public class * implements com.bumptech.glide.module.GlideModule
-keep class * extends com.bumptech.glide.module.AppGlideModule {
 <init>(...);
}
-keep public enum com.bumptech.glide.load.ImageHeaderParser$** {
  **[] $VALUES;
  public *;
}
-keep class com.bumptech.glide.load.data.ParcelFileDescriptorRewinder$InternalRewinder {
  *** rewind();
}

# for DexGuard only
#-keepresourcexmlelements manifest/application/meta-data@value=GlideModule

#======================项目配置=======================

#这在JSON实体映射时非常重要，比如fastJson
-keepattributes Signature
#保留所有的本地native方法不被混淆
-keepclasseswithmembernames class *{
    native <methods>;
 }

 #保留继承自Activity、Application这些类的子类
 -keep public class * extends android.app.Activity
 -keep public class * extends android.app.Application
 -keep public class * extends android.app.Application
 -keep public class * extends android.app.Service
 -keep public class * extends android.content.BroadcastReceiver
 -keep public class * extends android.content.ContentProvider
 -keep public class * extends android.app.backup.BackupAgentHelper
 -keep public class * extends android.preference.Preference
 -keep public class * extends android.view.View

#如果有引用android-support-v4.jar包，可以添加下面这行


#保留在Activity中的方法参数是view的方法
#从而我们在layout里面编写onClick就不会被影响
-keepclassmembers class * extends android.app.Activity{
	public void *(android.view.View);
	}

 -keep public class * extends android.database.sqlite.SQLiteOpenHelper{*;}
 -keepnames class * extends android.view.View
 -keep class * extends android.app.Fragment {
     public void setUserVisibleHint(boolean);
     public void onHiddenChanged(boolean);
     public void onResume();
     public void onPause();
 }
 -keep class androidx.fragment.app.Fragment {
     public void setUserVisibleHint(boolean);
     public void onHiddenChanged(boolean);
     public void onResume();
     public void onPause();
 }
 -keep class * extends androidx.fragment.app.Fragment {
     public void setUserVisibleHint(boolean);
     public void onHiddenChanged(boolean);
     public void onResume();
     public void onPause();
 }


 #如果引用v4或者v7包
 -dontwarn android.support.**
 #以防onClick不被影响，保留Activity中包含view的方法
 -keepclasseswithmembers class * extends android.app.Activity{
    public void * (android.view.View);
 }
 #枚举类不能被混淆
 -keepclassmembers enum *{
    public static **[] values();
    public static ** valueOf(java.lang.String);
    }

 #保留自定义控件不能被混淆(即继承自View)不能被混淆
 -keep public class * extends android.view.View{
    public <init> (android.content.Context);
    public <init> (android.content.Context,android.util.AttributeSet);
    public <init>(android.content.Context,android.util.AttributeSet,int);
    public void set*(***);
    *** get*();
    }

  #保留Parcelable序列化的类不能被混淆
  -keep class * implements android.os.Parcelable{
    public static final android.os.Parcelable$Creator *;
    }

  #保留Serializable序列化的类不能被混淆
  -keepclassmembers class * implements java.io.Serializable{
    static final long serialVersionUID;
    private static final java.io.ObjectStreamFiled[] serialPersistentFields;
    !static !transient <fields>;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}
   #对R文件下的所有类及其方法都不能混淆
#   -keep class class **.R$*{
#        *;
#   }

   #对于回调函数onXXEvent的，不能被混淆
   -keepclassmembers class * {
   void *(**Event);
   }

#livedatabus
-dontwarn com.jeremyliao.liveeventbus.**
-keep class com.jeremyliao.liveeventbus.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep class androidx.arch.core.** { *; }


#实体类混淆
-keep class **Bean* { *;}
-keep class **Entity* { *;}
-keep class **Model { *;}
-keep class **Event { *;}
-keep class **Item { *;}
-keep class **Data {*;}
-keep class **Constant {*;}
-keep class **Info {*;}
-keep public class com.tde.app.R$*


#权限
-keepclasseswithmembers class * {
    @com.ninetripods.aopermission.permissionlib.annotation.NeedPermission <methods>;
}

-keepclasseswithmembers class * {
    @com.ninetripods.aopermission.permissionlib.annotation.PermissionCanceled <methods>;
}

-keepclasseswithmembers class * {
    @com.ninetripods.aopermission.permissionlib.annotation.PermissionDenied <methods>;
}

#--------buggly--------
-dontwarn com.tencent.bugly.**
-keep public class com.tencent.bugly.**{*;}

#--------push--------
-keep class com.xiaomi.* {*;}
-keep class com.jdb.npush.xiaomi.MiPushMessageReceiver {*;}
-keep class com.jdb.npush.xiaomi.XiaomiPushProvider {*;}
-keep class com.huawei.* {*;}
-keep class com.jdb.npush.huawei.HuaweiPushProvider {*;}
-keep public class * extends android.app.Service
-keep class com.jdb.npush.oppo.OppoPushProvider {*;}
-keep class com.umeng.* {*;}
-keep class com.jdb.npush.umeng.UmengPushProvider {*;}
-keep class org.android.spdy.* {*;}
-dontwarn com.vivo.push.**
-keep class com.vivo.push.*{*; }
-keep class com.vivo.vms.*{*; }
-keep class com.jdb.npush.vivo.VivoMessageReceiverImpl{*;}
-keep public class * extends android.app.Service
-keep class com.jdb.npush.vivo.VivoPushProvider {*;}

-keep class com.umeng.** {*;}

#--------友盟埋点--------
-keep class com.uc.** {*;}
-keep class com.umeng.analytics.* {*;}
-keepclassmembers class * {
   public <init> (org.json.JSONObject);
}
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
-keep class com.zui.** {*;}
-keep class com.miui.** {*;}
-keep class com.heytap.** {*;}
-keep class a.** {*;}
-keep class com.vivo.** {*;}
-keep class com.umeng.commonsdk.** {*;}
-keep class com.umeng.** {*;}


#--------神策埋点oaid混淆--------
-keep class com.bun.** {*;}
-keep class com.asus.msa.** {*;}
-keep class com.heytap.openid.** {*;}
-keep class com.huawei.android.hms.pps.** {*;}
-keep class com.meizu.flyme.openidsdk.** {*;}
-keep class com.samsung.android.deviceidservice.** {*;}
-keep class com.zui.** {*;}
-keep class com.huawei.hms.ads.** {*; }
-keep interface com.huawei.hms.ads.** {*; }
-keepattributes *Annotation*
-keepattributes *Annotation*
-keep @android.support.annotation.Keep class **{
@android.support.annotation.Keep <fields>;
@android.support.annotation.Keep <methods>;
}

#--------腾讯IM混淆--------
-keep class com.tencent.imsdk.** {*;}
-keep class com.tencent.liteav.** {*;}
-keep class com.tencent.rtmp.** {*;}
-keep class com.tencent.qcloud.** {*;}


#--------PictureSelector混淆--------
#PictureSelector 2.0
-keep class com.luck.picture.lib.** { *; }
#Ucrop
-dontwarn com.yalantis.ucrop**
-keep class com.yalantis.ucrop** { *; }
-keep interface com.yalantis.ucrop** { *; }
#Okio
-dontwarn org.codehaus.mojo.animal_sniffer.*


