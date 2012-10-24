package com.testflightapp.sdk;

import java.lang.Thread.UncaughtExceptionHandler;

import net.hockeyapp.android.CrashManager;
import net.hockeyapp.android.CrashManagerListener;
import net.hockeyapp.android.UpdateManager;
import net.hockeyapp.android.internal.ExceptionHandler;

import com.jesusla.ane.Context;
import com.jesusla.ane.ExceptionListener;
import com.jesusla.ane.ExceptionManager;
import com.jesusla.ane.Extension;

public class TestFlightLib extends Context {
  private String appId;
  private boolean enableUpdates;
  private boolean hideCrashDialog;
  private boolean autoSendCrashes;

  public TestFlightLib() {
    registerFunction("onActivate");
    registerFunction("crash");
    ExceptionManager.getInstance().registerListener(exceptionListener);
  }

  @Override
  protected void initContext() {
    appId = getRequiredProperty("HAAppID");
    enableUpdates = getBooleanProperty("HAEnableUpdates");
    hideCrashDialog = !getBooleanProperty("HAShowCrashDialog");
    autoSendCrashes = !getBooleanProperty("HADisableAutoSend");
    Extension.debug("HockeyApp initialized with AppID: %s, enableUpdates: %s", appId, enableUpdates);
    checkForCrashes();
    checkForUpdates();
  }

  public void onActivate() {
    checkForUpdates();
  }

  public void crash(String message) {
    throw new RuntimeException(message);
  }

  private void checkForCrashes() {
    CrashManager.register(getActivity(), appId, crashManagerListener);
  }

  private void checkForUpdates() {
    if (enableUpdates)
      UpdateManager.register(getActivity(), appId);
  }

  private final ExceptionListener exceptionListener = new ExceptionListener() {
    @Override
    public void notifyException(Throwable e) {
      reportException(e);
    }
  };

  private void reportException(Throwable e) {
    ExceptionHandler handler = getExceptionHandler();
    if (handler == null)
      Extension.warn(e, "Unable to report exception to HockeyApp - Not initialized yet");
    else
      handler.uncaughtException(Thread.currentThread(), e);
  }

  private ExceptionHandler getExceptionHandler() {
    UncaughtExceptionHandler currentHandler = Thread.getDefaultUncaughtExceptionHandler();
    if (currentHandler instanceof ExceptionHandler)
      return (ExceptionHandler)currentHandler;
    return null;
  }

  private final CrashManagerListener crashManagerListener = new CrashManagerListener() {
    @Override
    public Boolean ignoreDefaultHandler() {
      return hideCrashDialog;
    }

    @Override
    public Boolean onCrashesFound() {
      return autoSendCrashes;
    }
  };
}
