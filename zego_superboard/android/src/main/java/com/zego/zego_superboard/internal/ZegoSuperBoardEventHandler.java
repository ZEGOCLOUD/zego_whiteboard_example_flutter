//
//  android
//  com.zego.zego_superboard
//
//  Created by Patrick Fu on 2020-03-31.
//  Copyright © 2020 Zego. All rights reserved.
//

package com.zego.zego_superboard.internal;

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
import android.util.Log;
import android.util.Size;

import androidx.annotation.NonNull;

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

public class ZegoSuperBoardEventHandler {

    private volatile static ZegoSuperBoardEventHandler instance;

    public static ZegoSuperBoardEventHandler getInstance() {
        if (instance == null) {
            synchronized (ZegoSuperBoardEventHandler.class) {
                if (instance == null) {
                    instance = new ZegoSuperBoardEventHandler();
                }
            }
        }
        return instance;
    }

    private Handler mUIHandler = null;

    public ZegoSuperBoardEventHandler() {
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
            map.put("visibleSize", ZegoUtils.mapFromSize(visibleSize));
            map.put("subViewModel", ZegoUtils.mapFromSubViewModel(subViewModel));

            sink.success(map);
        }
    };

    IZegoSuperBoardManagerListener managerListener = new IZegoSuperBoardManagerListener() {
        @Override
        public void onError(int errorCode) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onError");
            map.put("errorCode", errorCode);

            sink.success(map);
        }

        @Override
        public void onRemoteSuperBoardSubViewAdded(@NonNull ZegoSuperBoardSubViewModel subViewModel) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onRemoteSuperBoardSubViewAdded");
            map.put("subViewModel", ZegoUtils.mapFromSubViewModel(subViewModel));

            sink.success(map);
        }

        @Override
        public void onRemoteSuperBoardSubViewRemoved(@NonNull ZegoSuperBoardSubViewModel subViewModel) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onRemoteSuperBoardSubViewRemoved");
            map.put("subViewModel", ZegoUtils.mapFromSubViewModel(subViewModel));

            sink.success(map);
        }

        @Override
        public void onRemoteSuperBoardSubViewSwitched(@NonNull String uniqueID) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onRemoteSuperBoardSubViewSwitched");
            map.put("uniqueID", uniqueID);

            sink.success(map);
        }

        @Override
        public void onRemoteSuperBoardAuthChanged(@NonNull HashMap<String, Integer> authInfo) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onRemoteSuperBoardAuthChanged");
            map.put("authInfo", authInfo);

            sink.success(map);
        }

        @Override
        public void onRemoteSuperBoardGraphicAuthChanged(@NonNull HashMap<String, Integer> authInfo) {
            if (guardSink()) {
                return;
            }

            HashMap<String, Object> map = new HashMap<>();

            map.put("method", "onRemoteSuperBoardGraphicAuthChanged");
            map.put("authInfo", authInfo);

            sink.success(map);
        }
    };


}
