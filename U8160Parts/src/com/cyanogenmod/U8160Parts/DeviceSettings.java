package com.cyanogenmod.settings.device;

import android.content.Context;
import android.os.Bundle;
import android.os.SystemProperties;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.Preference.OnPreferenceClickListener;
import android.preference.PreferenceActivity;
import android.preference.PreferenceCategory;
import android.preference.PreferenceScreen;
import com.cyanogenmod.settings.device.R;

public class DeviceSettings extends PreferenceActivity {

    public static Context mContext;

    public static String PROP_SWAP = "persist.sys.swap";
    public static String PROP_SPEAKER_ATTN = "persist.sys.speaker-attn";
    public static String PROP_HEADSET_ATTN = "persist.sys.headset-attn";
    public static String PROP_FM_ATTN = "persist.sys.fm-attn";
    public static String PROP_CACHESIZE = "persist.sys.read_ahead_kb";
    public static String PROP_COMPCACHE = "persist.service.zram";
    public static String PROP_COMPCACHE_RO = "ro.zram.default";
    public static String PROP_PROCESSLIMIT = "persist.sys.processlimit";

    public static CharSequence[] attn = { "Disabled", "1 dB",
            "2 dB", "3 dB", "4 dB", "5 dB", "6 dB" };
    public static CharSequence[] cachesize = { "Default (128KB)", "256KB",
            "512KB", "1MB", "2MB", "4MB" };
    public static CharSequence[] processlimit = { "Standard limit", "No background processes",
            "At most 1 processes", "At most 2 processes", "At most 3 processes", "At most 4 processes" };
    
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mContext = this;

        PreferenceScreen PrefScreen = getPreferenceManager()
                .createPreferenceScreen(this);

        PreferenceCategory AudioCat = new PreferenceCategory(this);
        AudioCat.setTitle(getText(R.string.audio_cat));
        PrefScreen.addPreference(AudioCat);

        // ATTENUATION SPEAKER
        Preference AttnS = new Preference(this);
        AttnS.setTitle(getText(R.string.attn_speaker));
        String currentAttnS = Command.getprop(PROP_SPEAKER_ATTN);
        int currentAttnSi = 0;
        if (currentAttnS.length() == 1) {
            currentAttnSi = Integer.parseInt(currentAttnS);
        }
        AttnS.setSummary(getText(R.string.current_setting) + " " + attn[currentAttnSi]);
        AttnS.setEnabled(true);
        AttnS.setOnPreferenceClickListener(new AttnSpeaker(this));
        AudioCat.addPreference(AttnS);

        // ATTENUATION HEADSET
        Preference AttnH = new Preference(this);
        AttnH.setTitle(getText(R.string.attn_headset));
        String currentAttnH = Command.getprop(PROP_HEADSET_ATTN);
        if (currentAttnH.equals("0")) {
            currentAttnH = getText(R.string.disabled).toString();
        }
        int currentAttnHi = 0;
        if (currentAttnH.length() == 1) {
            currentAttnHi = Integer.parseInt(currentAttnH);
        }
        AttnH.setSummary(getText(R.string.current_setting) + " " + attn[currentAttnHi]);
        AttnH.setEnabled(true);
        AttnH.setOnPreferenceClickListener(new AttnHeadset(this));
        AudioCat.addPreference(AttnH);

        // ATTENUATION FM
        Preference AttnFM = new Preference(this);
        AttnFM.setTitle(getText(R.string.attn_fm));
        String currentAttnFM = Command.getprop(PROP_FM_ATTN);
        
        int currentAttnFMi = 0;
        if (currentAttnFM.length() == 1) {
            currentAttnFMi = Integer.parseInt(currentAttnFM);
        }
        AttnFM.setSummary(getText(R.string.current_setting) + " " + attn[currentAttnFMi]);

        AttnFM.setEnabled(true);
        AttnFM.setOnPreferenceClickListener(new AttnFM(this));
        AudioCat.addPreference(AttnFM);

        PreferenceCategory Memory = new PreferenceCategory(this);
        Memory.setTitle(getText(R.string.memory_man));
        PrefScreen.addPreference(Memory);

        // BACKGROUND PROCESS LIMIT
        Preference BackProcessLimit = new Preference(this);
        BackProcessLimit.setTitle(getText(R.string.backprocesslimit));
        String currentBackProcessLimit = Command.getprop(PROP_PROCESSLIMIT);
        
        int currentBackProcessLimiti = -1;
        if (currentBackProcessLimit.length() < 3) {
            currentBackProcessLimiti = (Integer.parseInt(currentBackProcessLimit));
        }
        BackProcessLimit.setSummary(getText(R.string.current_setting) + " " + processlimit[currentBackProcessLimiti+1]);

        BackProcessLimit.setEnabled(true);
        BackProcessLimit.setOnPreferenceClickListener(new BackProcessLimit(this));
        Memory.addPreference(BackProcessLimit);

        // CACHE SIZE
        Preference CacheSize = new Preference(this);
        CacheSize.setTitle(getText(R.string.cache_size));
        String currentCacheSize = Command.getprop(PROP_CACHESIZE);
        int currentCacheSizei = 0;
        if (currentCacheSize.length() == 1) {
            currentCacheSizei = Integer.parseInt(currentCacheSize);
        }
        CacheSize.setSummary(getText(R.string.current_setting) + " " + cachesize[currentCacheSizei]);
        CacheSize.setEnabled(true);
        CacheSize.setOnPreferenceClickListener(new CacheSize(this));
        Memory.addPreference(CacheSize);

        // Swap
        final CheckBoxPreference Swap = new CheckBoxPreference(this);
        Swap.setTitle("Swap");
        Swap.setSummary(getText(R.string.swap_sum));
        String isSwapON = Command.getprop(PROP_SWAP);
        if (isSwapON.equals("1")) {
            Swap.setChecked(true);
        } else {
            Swap.setChecked(false);
        }

        String isCompcacheON = Command.getprop(PROP_COMPCACHE); // persist

        if (isCompcacheON.equals("")) {
            isCompcacheON = Command.getprop(PROP_COMPCACHE_RO); // use read-only prop instead
        }

        if (isCompcacheON.equals("0")) {
            Swap.setEnabled(true);
        } else {
            Swap.setEnabled(false);
            Swap.setSummary(getText(R.string.swap_cce));

        }

        Swap.setOnPreferenceClickListener(new OnPreferenceClickListener() {

            public boolean onPreferenceClick(Preference arg0) {
                if (Swap.isChecked()) {
                    SystemProperties.set(PROP_SWAP, "1");
                } else {
                    SystemProperties.set(PROP_SWAP, "0");

                }

                return false;
            }
        });
        Memory.addPreference(Swap);


        PreferenceCategory LogCat = new PreferenceCategory(this);
        LogCat.setTitle(getText(R.string.log_cat));
        PrefScreen.addPreference(LogCat);
        
        
        Preference Dump = new Preference(this);
        Dump.setTitle(getText(R.string.gen_bug_report));
        Dump.setSummary(getText(R.string.gen_bug_report_summary));
        Dump.setEnabled(true);
        Dump.setOnPreferenceClickListener(new OnPreferenceClickListener() {

            public boolean onPreferenceClick(Preference arg0) {
                new GetLogTask().execute();
                return false;
            }
        });
        LogCat.addPreference(Dump);
        
        setPreferenceScreen(PrefScreen);

    }
}
