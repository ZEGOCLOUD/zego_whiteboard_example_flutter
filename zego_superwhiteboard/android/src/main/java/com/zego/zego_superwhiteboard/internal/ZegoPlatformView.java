//
//  android
//  com.zego.zego_superwhiteboard
//
//  Created by Patrick Fu on 2020-04-03.
//  Copyright © 2020 Zego. All rights reserved.
//

package com.zego.zego_superwhiteboard.internal;

import android.content.Context;
import android.view.View;

import im.zego.superboard.ZegoSuperBoardManager;
import io.flutter.plugin.platform.PlatformView;

public class ZegoPlatformView implements PlatformView {
    ZegoPlatformView(Context context) {
    }

    @Override
    public View getView() {
        return ZegoSuperBoardManager.getInstance().getSuperBoardView();
    }

    @Override
    public void dispose() {
    }
}
