//
//  android
//  com.zego.zego_superwhiteboard
//
//  Created by Patrick Fu on 2020-04-03.
//  Copyright © 2020 Zego. All rights reserved.
//

package com.zego.zego_superwhiteboard.internal;

import android.content.Context;
import android.view.SurfaceView;
import android.view.View;

import io.flutter.plugin.platform.PlatformView;

public class ZegoPlatformView implements PlatformView {

    private SurfaceView surfaceView;

    ZegoPlatformView(Context context) {
        this.surfaceView = new SurfaceView(context);
    }

    public SurfaceView getSurfaceView() {
        return this.surfaceView;
    }

    @Override
    public View getView() {
        return this.surfaceView;
    }

    @Override
    public void dispose() {
        this.surfaceView = null;
    }
}
