Testflight ANE
==============
Allows you to use TestFlight from within an AIR application.

You may download binary builds from the [wiki](https://github.com/jlopez/ane-testflight/wiki). Latest build can be downloaded from [here](ane-testflight/wiki/testflight-1.0.ane)

Usage
-----
The library follows the [TestFlight SDK](https://testflightapp.com/sdk/)
as closely as possible. Please read its
[documentation](https://testflightapp.com/sdk/doc/1.0/) for further
details.

Here's some sample code:

    import com.testflightapp.sdk.TestFlight;

    // Optional setup
    TestFlight.addCustomEnvironmentInformation("user", userId);

    // Optional submission of device identifier
    // Will send UDID if this function is called
    TestFlight.setDeviceIdentifier();

    // Only required function, but see below...
    TestFlight.takeOff(TEAM_TOKEN);

    // You may register checkpoint
    TestFlight.passCheckpoint("Main Menu");

    // Or launch the feedback view
    TestFlight.openFeedbackView();

    // Alternatively, supply your own feedback string
    TestFlight.submitFeedback(feedbackField.text);

    // You can tweak TestFlight internal settings
    TestFlight.setOptions({ logToConsole: false });

    // You can use the TFLog function
    // Unfortuntately, no varargs are allowed for now
    TestFlight.log("All your bases are belong to us");

When building an .ipa, you must:

* Extract the libNativeLibrary.a found inside the .ane at
/META-INF/ANE/iPhone-ARM-lib.
* Move this library into the Flex SDK at lib/aot/lib

Otherwise, linker errors will ensue. Alternatively, you can build
your .ipa using the air-mk makefiles which will do this automatically.

Also be sure to include the `-extdir` option when invoking adt,
pointing at a directory where the testflight.ane resdies.

Look ma, no hands
-----------------
If you define a `TFTeamToken` property in your Info.plist, the
TestFlight ANE will automatically call .takeOff() upon application
startup. You may also declare a `TFSetDeviceIdentifier` boolean,
which if set to `true` will call .setDeviceIdentifier() with
the iDevice UDID.

Finally, you can define a boolean property `ANEDebug` to debug
the extension, hopefully you'll never have to.

Building the .ANE yourself
--------------------------
In order to build, you'll need the following:

* Xcode command line tools
* Flex SDK with bin/ directory in your PATH
* [XMLStarlet](http://xmlstar.sourceforge.net)

Go to the `dist` directory and run:

    make ane

This will create a testflight.ane in the current directory.
