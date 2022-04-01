<!-- Overall, this is great content. I'd consider breaking it up into 2 or 3 
steps to make it easier to follow: Define the Sizes & Enum, Convert from Constraints 
into Enum, Use Enum Values to change layout. I'd also consider letting them 
change the layout themselves based on the enum, rather than providing all of
that code for them. To help with this, it might be a good idea to only have 3 
different sizes: mobile, tablet, desktop. -->
# Responsive UIs in Flutter / Handling Multiple Screen Sizes

With the increasing amount of devices coming into the market, we're getting to the point in which we're unable to keep up with their resolutions and sizes.

It would result not only cumbersome but impractical to create a version for the multiple platforms Flutter lets you publish your app.

For that, designers and developers have come up with conventions based on user patterns in media consumption from the most popular devices, target audience, etc.

Enter the **breakpoints**!

## What's a Breakpoint?

In responsive design, a breakpoint is the screen size at which a website or app's content and design will adjust in a certain way in order to provide the best possible user experience. 

Essentially, breakpoints are pixel values that a developer/designer can define in code. When a responsive app reaches those pixel values, a transformation occurs so that the website offers an optimal user experience for the screen dimensions in pixels in which it renders.

Let's represent that in our code.

Find the **Utils** class in our code and let's start by adding the most common breakpoints that our app should handle based on the devices in which our users will consume our app, randing from mobile, tablet, laptop, and desktop, as an set of ```const``` values:

```dart

// Step #1: add the device screen size breakpoints
static const int mobileMaxSize = 480;
static const int tabletMaxSize = 768;
static const int laptopMaxSize = 1024;
static const int desktopMaxSize = 1200;

```

These values are to be used as a guideline, using the maximum size available for the device category in which the screen dimensions falls under, that way we can establish a range between them and be a bit more flexible.

Now let's define an ```enum``` that will map to the corresponding device screen size that we're supporting. Place the following code above the ```Utils``` class:

```dart

// Step #2: Add the enum for the supported device screen sizes

enum DeviceBreakpoints {
  mobile,
  tablet,
  laptop,
  desktop,
  tv
}

```

Now it is time to establish the relationship between the multiple screen sizes supported by our app and the values queried by the ```MediaQuery.of```, available in ```MediaQueryData.size```.

Let's add an additional ```static``` method to our ```Utils``` class, that takes in a ```BuildContext``` reference, through which we'll pull the ```MediaQuery``` reference inherited by the inquiring widget. Let's call the method ```getDeviceType```, and return the corresponding enum value created earlier:

```dart

static DeviceBreakpoints getDeviceType(BuildContext context) {

    // extract the media query information for this screen
    MediaQueryData data = MediaQuery.of(context);

    // default value is mobile
    DeviceBreakpoints bk = DeviceBreakpoints.mobile;

    // if the screen is rendered in devices with tablet screen size...
    if (data.size.width > Utils.mobileMaxSize 
      && data.size.width <= Utils.tabletMaxSize) {
      bk = DeviceBreakpoints.tablet;
    }

    // if the screen is rendered in devices with laptop screen size...
    else if (data.size.width > Utils.tabletMaxSize 
      && data.size.width <= Utils.laptopMaxSize) {
      bk = DeviceBreakpoints.laptop;
    }

    // if the screen is rendered in devices with desktop screen size...
    else if (data.size.width > Utils.laptopMaxSize &&
            data.size.width <= Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.desktop;
    }
    
    // if the screen is rendered in devices larger than desktop...
    else if (data.size.width > Utils.desktopMaxSize) {
      bk = DeviceBreakpoints.tv;
    }

    return bk;
  }

```

Great! Now it's all a matter of consuming this method inside the widget that requires this information. We've already set it up for you, therefore locate a widget called ```DeviceScreenIndicator``` widget, and add the following missing line at the top of the widget's ```build``` method:

```dart

DeviceBreakpoints deviceBreakpoint = Utils.getDeviceType(context);

```

As you notice, we are feeding the **BuildContext** provided to this widget down to the ```Utils.getDeviceType``` method, which internally determines the corresponding device screen size, and returns the corresponding enum for us to do further processing.

Go ahead now an run this on **DartPad** and if you've replaced all code well, you should see in the **UI Output** panel window to the right that, as you stretch vertically, you will see an icon and a label at the top left corner of the panel the corresponding breakpoints that the screen falls under as we resize. Very useful!

![Breakpoints](http://localhost:8080/images/s2-1.png)



***Suggestion***: don't go by device-specific screen size breakpoints. Instead of forcing your design into a specific size, you should let your content flow, for the sake of delivering a great user experience and content consumption by your users.

You should start with the most common device-screen breakpoints, but should always strive for "Content-based" breakpoints, where you set a breakpoint at each point where content layout is not meeting the expectations of your consumers. This method greatly simplifies the implementation along with easing the management of media queries.