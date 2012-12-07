package com.cyanogenmod.settings.device;

import android.app.ActivityManagerNative;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
//import android.content.SharedPreferences;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.preference.PreferenceManager;
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.FileNotFoundException;
//import java.io.IOException;

public class U8160PartsStartup extends BroadcastReceiver
{
    // Apply process limit
    public int processLimit;

    @Override
    public void onReceive(final Context context, final Intent bootintent) {

    try {
        processLimit = Integer.valueOf(Command.getprop(DeviceSettings.PROP_PROCESSLIMIT));
    } catch (NumberFormatException e) {
        processLimit = -1;
    }

    try {
        ActivityManagerNative.getDefault().setProcessLimit(processLimit);
    } catch (RemoteException e) {
    }

    System.exit(0);
    }
}
