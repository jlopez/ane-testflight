package com.testflightapp.sdk {
  import flash.desktop.NativeApplication;
  import flash.events.Event;
  import flash.events.StatusEvent;
  import flash.external.ExtensionContext;
  import flash.utils.getQualifiedClassName;

  /**
   * TestFlight extension
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
    private static var _instance:TestFlight;
    private static var _objectPool:Object = {};
    private static var _objectPoolId:int = 0;
    private static var _initialized:Boolean;

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

    public static function init():void {
      if (_initialized)
        return;

      if (!context)
        return;

      var nativeApplication:NativeApplication = NativeApplication.nativeApplication;
      nativeApplication.addEventListener(Event.ACTIVATE, onActivate);
      _initialized = true;

      function onActivate(event:Event):void { context.call("onActivate"); }
    }

    public static function crash(message:String):void {
      if (context)
        context.call("crash", message);
      else
        throw new Error(message);
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
      context = ExtensionContext.createExtensionContext(EXTENSION_ID, EXTENSION_ID + ".TestFlightLib");
      if (context) {
        try {
          context.addEventListener(StatusEvent.STATUS, context_statusEventHandler);
          context.call("setActionScriptThis", _instance);
        } catch (e:ArgumentError) {
          context = null;
        }
      }
    }
  }
}
