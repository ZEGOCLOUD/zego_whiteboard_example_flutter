//
//  android
//  com.zego.zego_superwhiteboard
//
//  Created by Patrick Fu on 2020-03-31.
//  Copyright © 2020 Zego. All rights reserved.
//

package com.zego.zego_superwhiteboard.internal;

import org.json.JSONObject;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import im.zego.superboard.enumType.ZegoSuperBoardFileType;
import im.zego.superboard.model.ZegoSuperBoardSubViewModel;
import io.flutter.plugin.common.EventChannel;

import android.os.Handler;
import android.os.Looper;
import android.util.Size;

import im.zego.superboard.callback.IZegoSuperBoardApiCalledCallback;
import im.zego.superboard.callback.IZegoSuperBoardCacheFileListener;
import im.zego.superboard.callback.IZegoSuperBoardCreateCallback;
import im.zego.superboard.callback.IZegoSuperBoardDestroyCallback;
import im.zego.superboard.callback.IZegoSuperBoardInitCallback;
import im.zego.superboard.callback.IZegoSuperBoardManagerListener;
import im.zego.superboard.callback.IZegoSuperBoardQueryFileCachedListener;
import im.zego.superboard.callback.IZegoSuperBoardQueryListCallback;
import im.zego.superboard.callback.IZegoSuperBoardSwitchCallback;
import im.zego.superboard.callback.IZegoSuperBoardViewListener;
import im.zego.superboard.callback.IZegoSuperBoardUploadFileListener;

public class ZegoExpressEngineEventHandler {

    private volatile static ZegoExpressEngineEventHandler instance;

    public static ZegoExpressEngineEventHandler getInstance() {
        if (instance == null) {
            synchronized (ZegoExpressEngineEventHandler.class) {
                if (instance == null) {
                    instance = new ZegoExpressEngineEventHandler();
                }
            }
        }
        return instance;
    }

    private Handler mUIHandler = null;

    public ZegoExpressEngineEventHandler() {
        if (mUIHandler == null) {
            mUIHandler = new Handler(Looper.getMainLooper());
        }
    }

    EventChannel.EventSink sink;

    private boolean guardSink() {
        if (sink == null) {
            return true;
        }
        return false;
    }

    IZegoSuperBoardApiCalledCallback apiCalledCallback = new IZegoSuperBoardApiCalledCallback() {
        @Override
        public void onApiCalledResult(int errorCode) {

            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onApiCalledResult");
            map.put("errorCode", errorCode);

            sink.success(map);
        }
    };


//    IZegoSuperBoardInitCallback superBoardInitCallback = new IZegoSuperBoardInitCallback() {
//        @Override
//        public void onInit(int errorCode) {
//
//            if (guardSink()) {
//                return;
//            }
//
//            HashMap<String, Object> map = new HashMap<>();
//
//            map.put("method", "onInit");
//            map.put("errorCode", errorCode);
//
//            sink.success(map);
//        }
//    };

//    IZegoSuperBoardQueryListCallback queryListCallback = new IZegoSuperBoardQueryListCallback() {
//        @Override
//        public void onQuery(int errorCode, ZegoSuperBoardSubViewModel[] subViewModelList, HashMap<String, String> extraInfo) {
//
//            if (guardSink()) {
//                return;
//            }
//
//            HashMap<String, Object> map = new HashMap<>();
//
//            ArrayList<ZegoSuperBoardSubViewModel> subViewModelArray = new ArrayList<>();
//            Collections.addAll(subViewModelArray, subViewModelList);
//
//            map.put("method", "onQuery");
//            map.put("errorCode", errorCode);
//            map.put("subViewModelList", mapListFromSubViewModelList(subViewModelArray));
//            map.put("extraInfo", extraInfo);
//
//            sink.success(map);
//        }
//    };


//    IZegoSuperBoardCreateCallback createCallback = new IZegoSuperBoardCreateCallback() {
//        @Override
//        public void onViewCreated(int errorCode, ZegoSuperBoardSubViewModel subViewModel) {
//
//            if (guardSink()) {
//                return;
//            }
//
//            HashMap<String, Object> map = new HashMap<>();
//
//            map.put("method", "onViewCreated");
//            map.put("errorCode", errorCode);
//            map.put("subViewModel", mapFromSubViewModel(subViewModel));
//
//            sink.success(map);
//        }
//    };

//    IZegoSuperBoardDestroyCallback destroyCallback = new IZegoSuperBoardDestroyCallback() {
//        @Override
//        public void onViewDestroyed(int errorCode) {
//
//            if (guardSink()) {
//                return;
//            }
//
//            HashMap<String, Object> map = new HashMap<>();
//
//            map.put("method", "onViewDestroyed");
//            map.put("errorCode", errorCode);
//
//            sink.success(map);
//        }
//    };

    IZegoSuperBoardSwitchCallback switchCallback = new IZegoSuperBoardSwitchCallback() {
        @Override
        public void onViewSwitched(int errorCode) {

            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onViewSwitched");
            map.put("errorCode", errorCode);

            sink.success(map);
        }
    };


    IZegoSuperBoardViewListener viewListener = new IZegoSuperBoardViewListener() {
        @Override
        public void onScrollChange(int currentPage, int pageCount, ZegoSuperBoardSubViewModel subViewModel) {

            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onScrollChange");
            map.put("currentPage", currentPage);
            map.put("pageCount", pageCount);
            map.put("subViewModel", ZegoUtils.mapFromSubViewModel(subViewModel));

            sink.success(map);
        }

        @Override
        public void onSizeChange(Size visibleSize, ZegoSuperBoardSubViewModel subViewModel) {

            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onSizeChange");
            map.put("visibleSize", mapFromSize(visibleSize));
            map.put("subViewModel", ZegoUtils.mapFromSubViewModel(subViewModel));

            sink.success(map);
        }
    };

    private HashMap<String, Object> mapFromSize(Size size) {
        HashMap<String, Object> subViewModelMap = new HashMap<>();
        subViewModelMap.put("width", size.getWidth());
        subViewModelMap.put("height", size.getHeight());
        return subViewModelMap;
    }

}
