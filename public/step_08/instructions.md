# Single Source of Truth for Styling

Let's reintroduce the concept of helper classes that consolidate all style changes we want to apply at the different supported breakpoints by our application while implementing the following feature depicted in the image below:

![LayoutBuilder](http://localhost:8080/images/flutterair2.gif)

Notice how the font size changes as the screen dimensions match the supported breakpoints, and pay specific attention to the side menu widget (i.e. ```Drawer```) that when it is on a larger screen, its background is white and with a bit of content, but when it is on a smaller screen (i.e. mobile) the background changes to purple and more content appears.

This is so that we can provide a tailored experience depending on the device in which our users are consuming the same application. This also makes styling each breakpoint in a streamlined fashion, avoiding the ill-fated amount of "if-else" clauses polluting the UI.

Let's tackle this widget, shall we?

## Creating a Helper Class

The first thing that we do is: determine which are the values in our widget that we want to change and apply programmatically, as opposed to have them hard-coded in the widget or all over the place.

For example, from this widget, we want to change the following properties upon hitting the supported breakpoints:
- ```backgroundColor``` (type ```Color?```): we want the background to change depending on the experience we want to give our users between mobile and desktop
- ```labelColor``` (type ```Color?```): we want to provide a constrast between the background and the colors of the label
- ```iconBgColor``` (type ```Color?```): the icons should match the labels, so we need to have a separate property for them
- ```iconSize``` (type ```double?```): the size of the icon should change depending on the screen size
- ```labelSize``` (type ```double?```): same with the size of the labels

Then, with that figured out, create a class called ```FlutterAirSideMenuStyles``` that encapsulates all of the properties above.

```dart

// TODO: add the custom helper class
// that encapsulates the styles

class FlutterAirSideMenuStyles {
  // TODO: add all properties defined above:
  // backgroundColor, labelColor, iconBgColor, iconSize and labelSize

  FlutterAirSideMenuStyles({
    // add all named constructor parameters
    // for each of the properties defined above
  });
}

```

Next, go to the ```Utils``` class and create a ```Map``` of type ```<DeviceBreakpoints, FlutterAirSideMenuStyles>```, and for every device breakpoint, define the corresponding properties for each, following these specs:

For mobile:
- ```backgroundColor```: Utils.secondaryThemeColor
- ```labelColor```: Colors.white
- ```iconSize```: 20
- ```labelSize```: 20
- ```iconBgColor```: Utils.mainThemeColor

For all others (tablet, laptop, desktop and tv):
- ```backgroundColor```: Colors.white,
- ```labelColor```: Utils.darkThemeColor
- ```iconSize```: 30
- ```labelSize```: 20
- ```iconBgColor```: Utils.secondaryThemeColor

```dart

// TODO: Add the mappings in the Utils class,
// called "sideMenuStyles", per supported breakpoint

static Map<DeviceBreakpoints, FlutterAirSideMenuStyles> sideMenuStyles = {
    // for mobile:
    DeviceBreakpoints.mobile: FlutterAirSideMenuStyles(
      backgroundColor: Utils.secondaryThemeColor,
      labelColor: Colors.white,
      iconSize: 20,
      labelSize: 20,
      iconBgColor: Utils.mainThemeColor
    ),
    // TODO: add the mapping for tablet

    // TODO: add the mapping for laptop

    // TODO: add the mapping for desktop

    // TODO: add the mapping for tv
};

```

Now let's build out the widget that will hold our side menu.

### Create the FlutterAirSideMenu class

In the image below, notice how for screen sizes larger than mobile we only have two menu items available, while for mobile only we show all menu items available. This is the strategy we're following of showing content when space allows but still having an alternative on how to access it.

![SideMenu](http://localhost:8080/images/step8_1.png)

Create a class called ```FlutterAirSideMenu``` that extends ```StatelessWidget``` and override its ```build``` method.

```dart

// TODO: create a class called "FlutterAirSideMenu"
// that extends "StatelessWidget", and override its build method

```

We'll proceed by creating a method inside this class that will streamline the creation of our menu items. The method will be called ```getMenuItems``` with the following specs:

- return a ```List<Widget>``` so we can arrange its children as we please
- take in two parameters:
    - ```items```: type ```List<FlutterAirSideBarItem>```, which represents the menu items to show. We'll use two pre-built lists we've already created for you (for the sake of this tutorial): ```Utils.sideBarItems``` and ```Utils.sideMenuItems```
    - ```styles```: type ```FlutterAirSideMenuStyles``` so that we can apply the styles programmatically as we build the menu items according to the corresponding style mapping per supported screen

Internally this method will just return a list of widgets having the following structure:

```dart

- Padding
    - Row
        - Icon
        - Text

```

The final method should look like below:

```dart

// TODO: insert this method inside the FlutterAirSideMenu class

// ... rest of the code omitted for brevity

List<Widget> getMenuItems(
  List<FlutterAirSideBarItem> items,
  FlutterAirSideMenuStyles styles) {

  return List.generate(items.length, (index) {
    var menuItem = items[index];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Icon(
              menuItem.icon, 
              color: styles.labelColor, 
              size: styles.iconSize
          ),
          const SizedBox(width: 20),
          Text(menuItem.label!, 
            style: TextStyle(
              color: styles.labelColor,
              fontSize: styles.labelSize
            )
          )
        ],
      ),
    );
  });
}

```

Now, inside its ```build``` method, start by fetching the side menu styles corresponding to the current app's breakpoint, and store them in a local variable called ```menuStyles```, as in:

```dart

// TODO: add this at the top of the FlutterAirSideMenu's build method

DeviceBreakpoints deviceBreakpoint = Utils.getDeviceType(context);
FlutterAirSideMenuStyles? menuStyles = Utils.sideMenuStyles[deviceBreakpoint];

```

Proceed to utilize our newly created method ```getMenuItems``` to generate the menu items to display accordingly, starting from the main menu items (```sideBarItems```), which are the same ones on the side bar, but only when the supported breakpoint is ```mobile```, otherwise return an empty list and storing that on a local property called ```mainMenuItems```.

```dart

// TODO: next, if the current breakpoint is for 'mobile',
// then get the Utils.sideBarItems as menu items, otherwise
// return an empty list

List<Widget> mainMenuItems = deviceBreakpoint == DeviceBreakpoints.mobile ? 
    getMenuItems(Utils.sideBarItems, menuStyles!) : [];

```

Next, let's populate the ones that will be default menu items (```sideMenuItems```) - always showing on the side menu bar, then merge them all if applicable, so as to consider them a single list:

```dart

// TODO: populate the default menu items
List<Widget> defaultMenuItems = getMenuItems(Utils.sideMenuItems, menuStyles!);
mainMenuItems.addAll(defaultMenuItems);

```

With all of our menu item widgets pre-populated and ready to be rendered, let's build out the structure that will encapsulate these widgets, starting from a ```Container``` widget with the following specs:

- ```color```: set a background color to this container, leveraging the ```menuStyles``` styles retrieved above, pulling the ```backgroundColor``` property out of it
- ```padding```: 30px of padding all around
- ```child```: a ```Column``` widget as its direct child


Your structure should look like this:

```dart

// TODO: return this as the main wrapper 
// structure from this widget:

// ... rest of the code omitted for brevity

return Container(
    color: menuStyles.backgroundColor,
    padding: const EdgeInsets.all(30),
    child: Column(
        children: []
    )
);

```

Let's focus our sole attention now to this child ```Column```, which we'll split into two regions: the top portion will display the menu items, and occupy most of the real estate in this column, while the bottom part will just be a decorative piece so we'll add some sort of badge / icon, as follows:

![SideMenu](http://localhost:8080/images/step8_2.png)

Let's make the items on our column to be left aligned, and have as its two immediate children an ```Expanded``` widget and a ```Container``` widget:

```dart

// TODO: make the contents left-aligned (CrossAlignment.start)
// and add an Expanded and a Container widget

// ... rest of the code omitted for brevity

Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
        Expanded(
            // rest of the code here
        ),
        Container(
            // rest of the code here
        ),
    ],
)

```

On the top region (i.e. the ```Expanded``` widget), add yet another ```Column``` widget and simply feed the ```mainMenuItems``` property to its ```children``` property, as such:


```dart

// TODO: add the 'mainMenuItems' to the
// Column's children property

Expanded(
    child: Column(
        children: mainMenuItems,
    ),
)

```

And to wrap things up, make the ```Container``` match the design by following these specs:

- make it 70px by 70px ```width``` and ```height``` respectively
- color ```menuStyles.iconBgColor``` and a border radius of 35px using a ```BoxDecoration``` instance
- add as its direct child an ```Icon``` widget:
    - Icns.flight_takeoff
    - color: Colors.white
    - size: 40px 

Your ```Container``` should look like this:

```dart

// TODO: add the Container widget

Container(
    width: 70,
    height: 70,
    decoration: BoxDecoration(
        color: menuStyles.iconBgColor,
        borderRadius: BorderRadius.circular(35)
    ),
    child: const Icon(
        Icons.flight_takeoff, 
        color: Colors.white,
        size: 40
    )
)

```

Now, put this newly created widget in place by going up to the ```FlutterAirWelcome``` page widget and feed it to the ```Scaffold```'s drawer, setting its instance as the ```Drawer```'s ```child``` property:

```dart

// TODO: add the created FlutterAirSideMenu 
// as a child of the Drawer widget;
// don't forget to remove the 'const' from the Drawer widget

```

It's time to take this for a spin by opening up the ```Drawer``` by clicking on the hamburger menu on the top left corner, and stretching the ```UI Output``` panel by the sides.

Notice how the side menu widget changes color for the background, icons and font sizes based on the breakpoint mappings we configured, as well as showing and hiding the content appropriately based on the logic for displaying the content.

## Further exploration

You can check out also how I built the ```FlutterAirAppBar``` widget, which pretty much follows the same "single-source-of-truth" style approach when styling it, and notice how the app bar changes color as we move from mobile to larger screens.

These are some approaches you can utilize in your own apps in order to bring responsiveness in a clean and efficient way.