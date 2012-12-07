package com.cyanogenmod.settings.device;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.os.SystemProperties;
import android.preference.Preference;
import com.cyanogenmod.settings.device.R;

final class CacheSize implements Preference.OnPreferenceClickListener {

    Context context = DeviceSettings.mContext;
    int selected = 1;

    CacheSize(DeviceSettings arg0) {
    }

    public final boolean onPreferenceClick(final Preference preference) {

        String currentSetting = Command.getprop(DeviceSettings.PROP_CACHESIZE);
        if (currentSetting.length() > 0) {
            selected = Integer.parseInt(currentSetting);
        }

        AlertDialog.Builder dialog = new AlertDialog.Builder(context)
                .setTitle(context.getText(R.string.cache_size))
                .setSingleChoiceItems(DeviceSettings.cachesize, selected, new OnClickListener() {

                    public void onClick(DialogInterface arg0, int arg1) {

                        SystemProperties.set(DeviceSettings.PROP_CACHESIZE, ""
                                + (Integer.valueOf(arg1)));
                        
                        preference.setSummary(context
                                .getText(R.string.current_setting) + " " + DeviceSettings.cachesize[arg1].toString());

                        arg0.dismiss();

                    }

                })

                .setNegativeButton(context.getText(R.string.cancel), null);
        dialog.show();
        return false;

    }
}
