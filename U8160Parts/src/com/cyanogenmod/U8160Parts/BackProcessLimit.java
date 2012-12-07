package com.cyanogenmod.settings.device;

import android.app.ActivityManagerNative;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.os.RemoteException;
import android.os.SystemProperties;
import android.preference.Preference;
import com.cyanogenmod.settings.device.R;

final class BackProcessLimit implements Preference.OnPreferenceClickListener {

    Context context = DeviceSettings.mContext;
    int selected = -1;

    BackProcessLimit(DeviceSettings arg0) {
    }

    public final boolean onPreferenceClick(final Preference preference) {

        String currentSetting = Command.getprop(DeviceSettings.PROP_PROCESSLIMIT);
        if (currentSetting.length() < 3) {
            selected = Integer.parseInt(currentSetting);
        }

        AlertDialog.Builder dialog = new AlertDialog.Builder(context)
                .setTitle(context.getText(R.string.backprocesslimit))
                .setSingleChoiceItems(DeviceSettings.processlimit, (selected+1), new OnClickListener() {

                    public void onClick(DialogInterface arg0, int arg1) {

                        SystemProperties.set(DeviceSettings.PROP_PROCESSLIMIT, ""
                                + Integer.valueOf(arg1-1));

                        int processLimit;
                        try {
                            processLimit = Integer.valueOf(Command.getprop(DeviceSettings.PROP_PROCESSLIMIT));
                        } catch (NumberFormatException e) {
                            processLimit = -1;
                        }

                        try {
                            ActivityManagerNative.getDefault().setProcessLimit(processLimit);
                        } catch (RemoteException e) {
                        }

                        preference.setSummary(context
                                .getText(R.string.current_setting) + " " + DeviceSettings.processlimit[Integer.valueOf(arg1)].toString());

                        arg0.dismiss();

                    }

                })

                .setNegativeButton(context.getText(R.string.cancel), null);
        dialog.show();
        return false;

    }
}
