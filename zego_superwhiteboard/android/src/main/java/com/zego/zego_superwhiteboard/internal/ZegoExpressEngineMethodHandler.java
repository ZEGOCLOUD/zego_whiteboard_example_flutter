//
//  android
//  com.zego.zego_superwhiteboard
//
//  Created by Patrick Fu on 2020-03-31.
//  Copyright © 2020 Zego. All rights reserved.
//

package com.zego.zego_superwhiteboard.internal;

import android.app.Application;
import android.graphics.Bitmap;
import android.graphics.Rect;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;

import androidx.annotation.NonNull;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.lang.*;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;


import im.zego.superboard.callback.IZegoSuperBoardApiCalledCallback;
import im.zego.superboard.callback.IZegoSuperBoardCreateCallback;
import im.zego.superboard.callback.IZegoSuperBoardDestroyCallback;
import im.zego.superboard.callback.IZegoSuperBoardInitCallback;
import im.zego.superboard.callback.IZegoSuperBoardQueryListCallback;
import im.zego.superboard.callback.IZegoSuperBoardSwitchCallback;
import im.zego.superboard.model.ZegoCreateFileConfig;
import im.zego.superboard.model.ZegoSuperBoardSubViewModel;
import im.zego.zegoexpress.constants.ZegoScenario;
import im.zego.superboard.enumType.ZegoSuperBoardTool;
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.view.TextureRegistry;

import im.zego.superboard.ZegoSuperBoardManager;
import im.zego.superboard.constant.ZegoSuperBoardError;
import im.zego.superboard.model.ZegoSuperBoardInitConfig;
import im.zego.superboard.model.ZegoCreateWhiteboardConfig;


public class ZegoExpressEngineMethodHandler {

    private static Registrar registrar = null;

    private static FlutterPluginBinding pluginBinding = null;

    private static Application application = null;

    private static TextureRegistry textureRegistry = null;

    private static boolean enablePlatformView = false;

    private static boolean pluginReported = false;

    public static void init(MethodCall call, Result result, Registrar reg, FlutterPluginBinding binding, EventChannel.EventSink sink) {
        if (binding != null) {
            application = (Application) binding.getApplicationContext();
            textureRegistry = binding.getTextureRegistry();
        } else {
            application = (Application) reg.context();
            textureRegistry = reg.textures();
        }

        registrar = reg;
        pluginBinding = binding;

        // Set eventSink for ZegoExpressEngineEventHaZegoSuperwhiteboardPluginndler
        if (sink == null) {

        }
        ZegoExpressEngineEventHandler.getInstance().sink = sink;

        HashMap<String, Object> configMap = call.argument("config");
        long appID = ZegoUtils.longValue((Number) configMap.get("appID"));
        String appSign = (String) configMap.get("appSign");
        String token = (String) configMap.get("token");
        String userID = (String) configMap.get("userID");

        ZegoSuperBoardInitConfig config = new ZegoSuperBoardInitConfig();
        config.appID = appID;
        if (appSign != null) {
            config.appSign = appSign;
        }
        config.token = token;
        config.userID = userID;

        ZegoSuperBoardManager.getInstance().init(application, config, new IZegoSuperBoardInitCallback() {
            @Override
            public void onInit(int errorCode) {
                HashMap<String, Object> map = new HashMap<>();
                map.put("errorCode", errorCode);

                ZegoSuperBoardManager.getInstance().setManagerListener(ZegoExpressEngineEventHandler.getInstance().managerListener);

                result.success(map);
            }
        });

    }

    @SuppressWarnings("unused")
    public static void uninit(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().unInit();

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void getSDKVersion(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getSDKVersion());
    }

    @SuppressWarnings("unused")
    public static void clearCache(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().clearCache();

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void clear(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().clear();

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void renewToken(MethodCall call, Result result) {
        String token = call.argument("token");
        ZegoSuperBoardManager.getInstance().renewToken(token);

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void enableRemoteCursorVisible(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().enableRemoteCursorVisible(ZegoUtils.boolValue((Boolean) call.argument("visible")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void isCustomCursorEnabled(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isCustomCursorEnabled());
    }

    @SuppressWarnings("unused")
    public static void isEnableResponseScale(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isEnableResponseScale());
    }

    @SuppressWarnings("unused")
    public static void isEnableSyncScale(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isEnableSyncScale());
    }

    @SuppressWarnings("unused")
    public static void isRemoteCursorVisibleEnabled(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isRemoteCursorVisibleEnabled());
    }

    @SuppressWarnings("unused")
    public static void setCustomizedConfig(MethodCall call, Result result) {
        String key = call.argument("key");
        String value = call.argument("value");
        ZegoSuperBoardManager.getInstance().setCustomizedConfig(key, value);

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void createWhiteboardView(MethodCall call, Result result) {
        HashMap<String, Object> configMap = call.argument("config");

        ZegoCreateWhiteboardConfig config = new ZegoCreateWhiteboardConfig();
        config.name = (String) configMap.get("name");
        config.perPageWidth = ZegoUtils.intValue((Number) configMap.get("perPageWidth"));
        config.perPageHeight = ZegoUtils.intValue((Number) configMap.get("perPageHeight"));
        config.pageCount = ZegoUtils.intValue((Number) configMap.get("pageCount"));

        ZegoSuperBoardManager.getInstance().createWhiteboardView(config, new IZegoSuperBoardCreateCallback() {
            @Override
            public void onViewCreated(int errorCode, ZegoSuperBoardSubViewModel subViewModel) {
                HashMap<String, Object> map = new HashMap<>();

                map.put("errorCode", errorCode);
                map.put("subViewModel", mapFromSubViewModel(subViewModel));

                result.success(map);
            }
        });
    }

    @SuppressWarnings("unused")
    public static void createFileView(MethodCall call, Result result) {
        HashMap<String, Object> configMap = call.argument("config");
        ZegoCreateFileConfig config = new ZegoCreateFileConfig();
        config.fileID = (String) configMap.get("fileID");
        ZegoSuperBoardManager.getInstance().createFileView(config, new IZegoSuperBoardCreateCallback() {
            @Override
            public void onViewCreated(int errorCode, ZegoSuperBoardSubViewModel subViewModel) {

                HashMap<String, Object> map = new HashMap<>();

                map.put("errorCode", errorCode);
                map.put("subViewModel", mapFromSubViewModel(subViewModel));

                result.success(map);
            }
        });
    }

    @SuppressWarnings("unused")
    public static void destroySuperBoardSubView(MethodCall call, Result result) {
        String uniqueID = call.argument("uniqueID");
        ZegoSuperBoardManager.getInstance().destroySuperBoardSubView(uniqueID, new IZegoSuperBoardDestroyCallback() {
            @Override
            public void onViewDestroyed(int errorCode) {
                HashMap<String, Object> map = new HashMap<>();
                map.put("errorCode", errorCode);

                result.success(map);
            }
        });
    }

    @SuppressWarnings("unused")
    public static void querySuperBoardSubViewList(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().querySuperBoardSubViewList(
                new IZegoSuperBoardQueryListCallback() {
                    @Override
                    public void onQuery(int errorCode, ZegoSuperBoardSubViewModel[] subViewModelList, HashMap<String, String> extraInfo) {

                        HashMap<String, Object> map = new HashMap<>();

                        ArrayList<ZegoSuperBoardSubViewModel> subViewModelArray = new ArrayList<>();
                        Collections.addAll(subViewModelArray, subViewModelList);

                        map.put("errorCode", errorCode);
                        map.put("subViewModelList", ZegoUtils.mapListFromSubViewModelList(subViewModelArray));
                        map.put("extraInfo", extraInfo);

                        result.success(map);
                    }
                }
        );
    }

    @SuppressWarnings("unused")
    public static void getSuperBoardSubViewModelList(MethodCall call, Result result) {
        List<ZegoSuperBoardSubViewModel> subViewModelList = ZegoSuperBoardManager.getInstance().getSuperBoardSubViewModelList();

        ArrayList<HashMap<String, Object>> subViewModelListMap = new ArrayList<>();
        for (ZegoSuperBoardSubViewModel subViewModel : subViewModelList) {
            subViewModelListMap.add(mapFromSubViewModel(subViewModel));
        }

        result.success(subViewModelListMap);
    }

//    @SuppressWarnings("unused")
//    public static void getSuperBoardView(MethodCall call, Result result) {
//        result.success(ZegoSuperBoardManager.getInstance().getSuperBoardView());
//    }
//
//    @SuppressWarnings("unused")
//    public static void getSuperBoardSubView(MethodCall call, Result result) {
//        result.success(ZegoSuperBoardManager.getInstance().getSuperBoardSubView(call.argument("uniqueID")));
//    }

//    public static void getCurrentSuperBoardSubView(MethodCall call, Result result) {
//        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView();
//    }


    public static void switchSuperBoardSubView(MethodCall call, Result result) {
        String uniqueID = call.argument("uniqueID");
        ZegoSuperBoardManager.getInstance().getSuperBoardView().switchSuperBoardSubView(
                uniqueID,
                new IZegoSuperBoardSwitchCallback() {
                    @Override
                    public void onViewSwitched(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);

                        result.success(map);
                    }
                });
    }

    public static void switchSuperBoardSubExcelView(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().switchSuperBoardSubView(
                call.argument("uniqueID"),
                ZegoUtils.intValue((Number) call.argument("sheetIndex")),
                new IZegoSuperBoardSwitchCallback() {
                    @Override
                    public void onViewSwitched(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);

                        result.success(map);
                    }
                });
    }


    @SuppressWarnings("unused")
    public static void enableSyncScale(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().enableSyncScale(ZegoUtils.boolValue((Boolean) call.argument("enable")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void enableResponseScale(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().enableResponseScale(ZegoUtils.boolValue((Boolean) call.argument("enable")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void setToolType(MethodCall call, Result result) {
        ZegoSuperBoardTool tool = getSuperBoardTool(ZegoUtils.intValue((Number) call.argument("tool")));
        ZegoSuperBoardManager.getInstance().setToolType(tool);

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void getToolType(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getToolType().getToolType());
    }

    @SuppressWarnings("unused")
    public static void setFontBold(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().setFontBold(ZegoUtils.boolValue((Boolean) call.argument("bold")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void isFontBold(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isFontBold());
    }

    @SuppressWarnings("unused")
    public static void setFontItalic(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().setFontItalic(ZegoUtils.boolValue((Boolean) call.argument("italic")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void isFontItalic(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().isFontItalic());
    }

    @SuppressWarnings("unused")
    public static void setFontSize(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().setFontSize(ZegoUtils.intValue((Number) call.argument("size")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void getFontSize(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getFontSize());
    }

    @SuppressWarnings("unused")
    public static void setBrushSize(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().setBrushSize(ZegoUtils.intValue((Number) call.argument("width")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void getBrushSize(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getBrushSize());
    }

    @SuppressWarnings("unused")
    public static void setBrushColor(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().setBrushColor(ZegoUtils.intValue((Number) call.argument("color")));

        result.success(null);
    }

    @SuppressWarnings("unused")
    public static void getBrushColor(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getBrushColor());
    }

    /////   ZegoSuperBoardSubView
    public static void getThumbnailUrlList(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().getThumbnailUrlList());
    }

    public static void getModel(MethodCall call, Result result) {
        result.success(ZegoUtils.mapFromSubViewModel(ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().getModel()));
    }

    public static void inputText(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().inputText(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void addText(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().addText(
                call.argument("text"),
                ZegoUtils.intValue((Number) call.argument("positionX")),
                ZegoUtils.intValue((Number) call.argument("positionY")),
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void undo(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().undo();
        result.success(null);
    }

    public static void redo(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().redo();
        result.success(null);
    }

    public static void clearCurrentPage(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().clearCurrentPage(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void clearAllPage(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().clearAllPage(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void setOperationMode(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().setOperationMode(
                ZegoUtils.intValue((Number) call.argument("mode"))
        );
        result.success(null);
    }

    public static void flipToPage(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().flipToPage(
                ZegoUtils.intValue((Number) call.argument("targetPage")),
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void flipToPrePage(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().flipToPrePage(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void flipToNextPage(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().flipToNextPage(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void getCurrentPage(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().getCurrentPage());
    }

    public static void getPageCount(MethodCall call, Result result) {
        result.success(ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().getPageCount());
    }

    public static void getVisibleSize(MethodCall call, Result result) {
        result.success(ZegoUtils.mapFromSize(ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().getVisibleSize()));
    }

    public static void clearSelected(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().clearSelected(
                new IZegoSuperBoardApiCalledCallback() {
                    @Override
                    public void onApiCalledResult(int errorCode) {
                        HashMap<String, Object> map = new HashMap<>();
                        map.put("errorCode", errorCode);
                        result.success(map);
                    }
                }
        );
    }

    public static void setWhiteboardBackgroundColor(MethodCall call, Result result) {
        ZegoSuperBoardManager.getInstance().getSuperBoardView().getCurrentSuperBoardSubView().setWhiteboardBackgroundColor(
                ZegoUtils.intValue((Number) call.argument("color"))
        );
    }

    ////////

    public static ZegoSuperBoardTool getSuperBoardTool(int value) {
        try {
            if (ZegoSuperBoardTool.None.getToolType() == value) {
                return ZegoSuperBoardTool.None;
            } else if (ZegoSuperBoardTool.Pen.getToolType() == value) {
                return ZegoSuperBoardTool.Pen;
            } else if (ZegoSuperBoardTool.Text.getToolType() == value) {
                return ZegoSuperBoardTool.Text;
            } else if (ZegoSuperBoardTool.Line.getToolType() == value) {
                return ZegoSuperBoardTool.Line;
            } else if (ZegoSuperBoardTool.Rect.getToolType() == value) {
                return ZegoSuperBoardTool.Rect;
            } else if (ZegoSuperBoardTool.Ellipse.getToolType() == value) {
                return ZegoSuperBoardTool.Ellipse;
            } else if (ZegoSuperBoardTool.Selector.getToolType() == value) {
                return ZegoSuperBoardTool.Selector;
            } else if (ZegoSuperBoardTool.Eraser.getToolType() == value) {
                return ZegoSuperBoardTool.Eraser;
            } else if (ZegoSuperBoardTool.Laser.getToolType() == value) {
                return ZegoSuperBoardTool.Laser;
            } else if (ZegoSuperBoardTool.Click.getToolType() == value) {
                return ZegoSuperBoardTool.Click;
            } else if (ZegoSuperBoardTool.CustomImage.getToolType() == value) {
                return ZegoSuperBoardTool.CustomImage;
            }
        } catch (Exception e) {
            throw new RuntimeException("The ZegoSuperBoardTool enumeration cannot be found");
        }
        return null;
    }

    private static HashMap<String, Object> mapFromSubViewModel(ZegoSuperBoardSubViewModel subViewModel) {
        HashMap<String, Object> subViewModelMap = new HashMap<>();
        subViewModelMap.put("name", subViewModel.name);
        subViewModelMap.put("createTime", subViewModel.createTime);
        subViewModelMap.put("fileID", subViewModel.fileID);
        subViewModelMap.put("fileType", subViewModel.fileType.getFileType());
        subViewModelMap.put("uniqueID", subViewModel.uniqueID);
        subViewModelMap.put("whiteboardIDList", subViewModel.whiteboardIDList);
        return subViewModelMap;
    }
}
