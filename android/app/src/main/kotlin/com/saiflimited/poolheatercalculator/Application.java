package com.georgeabdelnour.poolheatercalculator;

import android.content.Context;

import androidx.multidex.MultiDex;

import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class Application extends FlutterApplication implements PluginRegistrantCallback {
    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }

    @Override
    public void onCreate() {
        super.onCreate();

    }

    @Override
    public void registerWith(PluginRegistry registry) {

    }
}