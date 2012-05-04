package com.testflightapp.sdk {
  import flash.external.ExtensionContext;

  /**
   * Simple NativeAlert extension that allows you to
   * Open device specific alerts and recieve information about
   * what button the user pressed to close the alert.
   */
  public class TestFlight {
    //---------------------------------------------------------------------
    //
    // Constants
    //
    //---------------------------------------------------------------------
    private static const EXTENSION_ID:String = "com.testflightapp.sdk";

    //---------------------------------------------------------------------
    //
    // Private Properties.
    //
    //---------------------------------------------------------------------
    private static var context:ExtensionContext = initContext();
    private static var _isSupported:Boolean;

    //---------------------------------------------------------------------
    //
    // Public Methods.
    //
    //---------------------------------------------------------------------
    public static function get isSupported():Boolean {
      return _isSupported;
    }

    public static function addCustomEnvironmentInformation(
      key:String, info:String):void {
      if (isSupported)
        context.call("addCustomEnvironmentInformation", info, key);
    }

    public static function setDeviceIdentifier():void {
      if (isSupported)
        context.call("setDeviceIdentifier");
    }

    public static function takeOff(teamToken:String):void {
      if (isSupported)
        context.call("takeOff", teamToken);
    }

    public static function passCheckpoint(checkpoint:String):void {
      if (isSupported)
        context.call("passCheckpoint", checkpoint);
    }

    public static function openFeedbackView():void {
      if (isSupported)
        context.call("openFeedbackView");
    }

    public static function submitFeedback(feedback:String):void {
      if (isSupported)
        context.call("submitFeedback", feedback);
    }

    public static function setOptions(options:Object):void {
      if (isSupported)
        context.call("setOptions", options);
    }

    //---------------------------------------------------------------------
    //
    // Private Methods.
    //
    //---------------------------------------------------------------------
    private static function initContext():ExtensionContext {
      var context:ExtensionContext =
        ExtensionContext.createExtensionContext(EXTENSION_ID, "TestFlightLib");
      if (context)
        _isSupported = context.actionScriptData;
      return context;
    }
  }
}
