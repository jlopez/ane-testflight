Testflight ANE
==============
This library provides support for TestFlight/HockeyApp crash reporting,
update notifications.

Usage
-----
For iOS add the following to your Info.plist additions:

        <key>TFTeamToken</key><string>@TESTFLIGHT_TEAM_TOKEN@</string>
        <key>TFSetDeviceIdentifier</key><true/>

For Android, add the following to your Manifest additions:

        <manifest android:installLocation="auto">
          <uses-permission android:name="android.permission.INTERNET"/>
          <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE"/>
          <application android:enabled="true" @ANDROID_DEBUGGABLE@>
            <meta-data android:name="HAAppID" android:value="@HOCKEY_APP_APP_ID"/>
            <meta-data android:name="HAEnableUpdates" android:value="true"/>
            <meta-data android:name="HAShowCrashDialog" android:value="false"/>
            <meta-data android:name="HADisableAutoSend" android:value="false"/>
            <activity android:name="com.jesusla.ane.CustomActivity"/>
            <activity android:name="net.hockeyapp.android.UpdateActivity"/>
          </application>
        </manifest>

Both `WRITE_EXTERNAL_STORAGE` and `UpdateActivity` may be omitted if update
functionality is not desired.

Then just call `TestFlight.init()` to install.
