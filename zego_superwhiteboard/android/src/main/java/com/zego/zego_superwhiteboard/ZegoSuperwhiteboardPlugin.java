package com.zego.zego_superwhiteboard;

import androidx.annotation.NonNull;

import com.zego.zego_superwhiteboard.internal.ZegoPlatformViewFactory;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.HashMap;

import io.flutter.Log;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** ZegoSuperwhiteboardPlugin */
public class ZegoSuperwhiteboardPlugin implements FlutterPlugin, MethodCallHandler, EventChannel.StreamHandler  {
  private Registrar registrar;
  private FlutterPluginBinding pluginBinding;

  private EventChannel eventChannel;
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel methodChannel;

  private EventChannel.EventSink sink;

  private final Class<?> manager;
  private final HashMap<String, Method> methodHashMap = new HashMap<>();

  public ZegoSuperwhiteboardPlugin() {
    try {
      this.manager = Class.forName("com.zego.zego_superwhiteboard.internal.ZegoExpressEngineMethodHandler");
    } catch (ClassNotFoundException e) {
      throw new RuntimeException(e);
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    MethodChannel methodChannel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "plugins.zego.im/zego_superwhiteboard");
    EventChannel eventChannel = new EventChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "plugins.zego.im/zego_superwhiteboard_event_handler");

    // Register platform view factory
    flutterPluginBinding.getPlatformViewRegistry().registerViewFactory("plugins.zego.im/zego_superwhiteboard_view", ZegoPlatformViewFactory.getInstance());

    this.setupPlugin(null, flutterPluginBinding, methodChannel, eventChannel);
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    this.methodChannel.setMethodCallHandler(null);
    this.methodChannel = null;

    this.eventChannel.setStreamHandler(null);
    this.eventChannel = null;

    this.pluginBinding = null;
  }

  /* Adapt to Flutter versions before 1.12 */

  // V1 embedding

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  @SuppressWarnings("unused")
  public static void registerWith(Registrar registrar) {

    MethodChannel methodChannel = new MethodChannel(registrar.messenger(), "plugins.zego.im/zego_express_engine");
    EventChannel eventChannel = new EventChannel(registrar.messenger(), "plugins.zego.im/zego_express_event_handler");

    // Register platform view factory
    registrar.platformViewRegistry().registerViewFactory("plugins.zego.im/zego_express_view", ZegoPlatformViewFactory.getInstance());

    ZegoSuperwhiteboardPlugin plugin = new ZegoSuperwhiteboardPlugin();
    plugin.setupPlugin(registrar, null, methodChannel, eventChannel);
  }

  /* Setup Plugin */
  private void setupPlugin(Registrar registrar, FlutterPluginBinding pluginBinding, MethodChannel methodChannel, EventChannel eventChannel) {
    this.registrar = registrar;
    this.pluginBinding = pluginBinding;

    this.methodChannel = methodChannel;
    this.methodChannel.setMethodCallHandler(this);

    this.eventChannel = eventChannel;
    this.eventChannel.setStreamHandler(this);
  }

  /* EventChannel.StreamHandler Interface */

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    this.sink = events;
  }

  @Override
  public void onCancel(Object arguments) {
    this.sink = null;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    Log.i("---- onMethodCall, ", call.method);

    try {
      Method method = methodHashMap.get(call.method);
      if (method == null) {
        if (call.method.equals("init")) {
          method = this.manager.getMethod(call.method, MethodCall.class, Result.class, Registrar.class, FlutterPluginBinding.class, EventChannel.EventSink.class);
        } else {
          method = this.manager.getMethod(call.method, MethodCall.class, Result.class);
        }
        methodHashMap.put(call.method, method);
      }

      if (call.method.equals("init")) {
        method.invoke(null, call, result, this.registrar, this.pluginBinding, this.sink);
      } else {
        method.invoke(null, call, result);
      }
    } catch (NoSuchMethodException e) {
      result.notImplemented();
    } catch (IllegalAccessException e) {
      result.error("IllegalAccessException", String.format("[%s] %s", call.method, e.getMessage()), null);
    } catch (InvocationTargetException e) {
      Throwable t = e.getTargetException();
      result.error("InvocationTargetException", String.format("[%s] %s", call.method, t.getMessage()), null);
    }
  }
}
