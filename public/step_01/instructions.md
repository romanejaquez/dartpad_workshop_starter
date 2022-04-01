<!-- Suggestion: I'd choose one of these as the primary title, and use the other as a subtitle. -->
# Responsive UIs in Flutter / Creating Fluid User Interfaces

## What is Responsive Design?

<!-- I've had beginners tell me self-referencing definitions are hard to understand (e.g. "Responsive means respond to"), so I try to add additional words or context these days. -->
Responsive Design is the approach that suggests that design and development should adapt or "respond" to the user’s screen size, device orientation, and platform, in the hopes of achieving a fluid user interface that satisfies the needs of users and delivers a seamless experience.

When a Flutter app is ***responsive***, the widgets adjust based on the size of screen they are presented on - they automatically change to fit the device you’re reading it on based on a set of rules given to the rendering platform.

Flutter provides a set of widgets and constructs to achieve responsiveness in our apps out of the box, starting from the ```MediaQuery``` widget.

# Using the MediaQuery Widget

The ```MediaQuery``` widget is for a higher level view of your app's screen size and can provide more detailed information about user layout preferences.

If you want to learn the size of the current media (e.g., the window containing your app), you can read the ```MediaQueryData.size``` property from the ```MediaQueryData``` returned by ```MediaQuery.of```.

Querying the current media using ```MediaQuery.of``` will cause your widget to rebuild automatically whenever the ```MediaQueryData``` changes (e.g., if the user rotates their device, or stretches the containing window).

## Extracting MediaQueryData

In the code on the right, locate the ***TODO*** in the ```TestMediaQueryWidget``` custom widget we created, and insert the following:

```dart
// Put this code in the build() method
// of the TestMediaQueryWidget

// Suggestion: Have them pass the data.size.width and data.size.height to the widgets instead? Otherwise all they have to do is copy + paste here, instead of working with the MediaQuery object.
MediaQueryData data = MediaQuery.of(context);

```

This extracts the [```MediaQueryData```](https://api.flutter.dev/flutter/widgets/MediaQueryData-class.html) which contains information about the width and height of the current window, as well as other useful information such as orientation.

Go ahead now and hit ```Run``` on DartPad to execute the code, and then resize the **UI Output** window to the right from both sides by dragging from the divider controls, so you can see that as soon as you resize the containing window, your widget will be scheduled to be rebuilt, thus causing the ```MediaQuery``` to be queried, retrieving the width and height values of the containing window as it changes dimensions and keeping your widget up-to-date.

You should see a couple of cool widgets representing arrows indicating the measurements of the **UI Output** containing window, and in real-time, as you resize, you should see the values changing. Pretty neat!

![Media Query](http://localhost:8080/images/s1-1.png)