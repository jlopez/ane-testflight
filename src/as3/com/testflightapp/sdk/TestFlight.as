package com.testflightapp.sdk {
  import flash.events.StatusEvent;
  import flash.external.ExtensionContext;
  import flash.utils.getQualifiedClassName;

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
    private static var context:ExtensionContext;
    private static var _isSupported:Boolean;
    private static var _instance:TestFlight;
    private static var _objectPool:Object = {};
    private static var _objectPoolId:int = 0;

    //---------------------------------------------------------------------
    //
    // Public Methods.
    //
    //---------------------------------------------------------------------
    public function TestFlight() {
      if (_instance)
        throw new Error("Singleton");
      _instance = this;
    }

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

    public static function log(msg:String):void {
      if (isSupported)
        context.call("log", msg);
    }

    public function getQualifiedClassName(obj:Object):String {
      return flash.utils.getQualifiedClassName(obj);
    }

    public function enumerateObjectProperties(obj:Object):Array {
      var keys:Array = [];
      for (var key:String in obj)
        keys.push(key);
      return keys;
    }

    public function __retainObject(obj:Object):int {
      _objectPool[++_objectPoolId] = obj;
      return _objectPoolId;
    }

    public function __getObject(id:int):Object {
      return _objectPool[id];
    }

    //---------------------------------------------------------------------
    //
    // Private Methods.
    //
    //---------------------------------------------------------------------
    private static function context_statusEventHandler(event:StatusEvent):void {
      if (event.level == "TICKET")
        context.call("claimTicket", event.code);
      else if (event.level == "RELEASE")
        delete _objectPool[int(event.code)];
    }

    {
      new TestFlight();
      context = ExtensionContext.createExtensionContext(EXTENSION_ID, "TestFlightLib");
      if (context) {
        _isSupported = context.actionScriptData;
        context.addEventListener(StatusEvent.STATUS, context_statusEventHandler);
        if (_isSupported)
          context.call("setActionScriptThis", _instance);
      }
    }
  }
}
