---
section: 3
title: Methodology
---

### Architecture

This application was developed using the latest version of the standard iOS development toolkit provided by Apple, including Xcode 6.3 (with Swift 1.2) and iOS SDK 8.3.  The newer Swift language was preferred over its predecessor, Objective-C, for its modern features and familiar syntax.

#### Dependencies

All third-party dependencies were managed using the open-source [CocoaPods](http://cocoapods.org) dependency manager, version 0.36.1.  This seems to be the de facto standard for managing dependencies in Cocoa projects, besides [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) and plain copy-and-pasting.  The dependencies for this application are listed in a text file named `Podfile` in the project's root, which is analyzed by the CocoaPods command line tool:

{% highlight ruby %}
pod 'Async', git: 'https://github.com/duemunk/Async.git', branch: 'feature/Swift_1.2'
pod 'SDCloudUserDefaults'
pod 'Realm'
pod 'SSDynamicText', :head 
pod 'UIImage+Additions'
{% endhighlight %}

These frameworks were already discussed in the background section. Without specifying a version number, CocoaPods uses the latest version of each pod when installing or updating dependencies.  This had the potential to quickly break the application if a pod released an update with API changes, but due to the short development cycle and continuous updates to the Swift language itself, I found it beneficial to stay on the latest version of each dependency.

#### Extensions

One of the most powerful features of the Swift programming language is the ability to extend types, including built-in classes, with new methods and computed properties.  I used this feature extensively throughout the project for two main purposes: to add functionality to core Cocoa abstractions like `NSDate` (for working with dates and times) and to create helper "factory" methods for application-specific constants.  The latter is a design pattern fully endorsed by Apple's official documentation; instead of specifying global `UIColor` constants for project-specific theme colors:

{% highlight swift %}
public let blueColor = UIColor(r: 82, g: 173, b: 204)
{% endhighlight %}

the company recommends extending the UIColor class directly with factory methods:

{% highlight swift %}
extension UIColor {
	class func applicationBlueColor() -> UIColor {
		return UIColor(r: 82, g: 173, b: 204)
	}
}
{% endhighlight %}

which can then be accessed through `UIColor.applicationBlueColor()`.  Though theme coloring is an admittedly simple example, it's easy to see how elegant this design pattern becomes when considering more complex objects such as reusable `UILabel` styles:

{% highlight swift %}
extension UILabel {
	class func applicationHeaderLabel(shadow: Bool = true, thin: Bool = false) -> UILabel {
		let label = SSDynamicLabel(font: thin ? "HelveticaNeue-Light" : "HelveticaNeue", baseSize: 23.0)
		label.numberOfLines = 0
		label.textAlignment = .Center
		
		if (shadow) {
			label.layer.shadowOffset = CGSize(width: 0, height: 3)
			label.layer.shadowRadius = 4
			label.layer.shadowColor = UIColor.blackColor().CGColor
			label.layer.shadowOpacity = 0.1
			label.layer.shouldRasterize = true
			label.layer.rasterizationScale = UIScreen.mainScreen().scale
		}
	
		return label
	}
}
{% endhighlight %}

I used this design pattern whenever possible, resorting to subclasses for only the most complex scenarios when method overrides were required.

#### Models

The only true database-backed model in this application was `Reflection`, a simple Realm-based class containing properties for a positive event, its reason, and the date it occurred (defaulting to the current time):

{% highlight swift %}
class Reflection: RLMObject {
	dynamic var event = ""
	dynamic var reason = ""
	dynamic var date = NSDate()
}
{% endhighlight %}

This class was used exclusively in the Reflect tab; the scrolling timeline fetches all entries within the previous month and the new reflection screen creates a new `Reflection` object based the user's input.  Other sources of persistent data, like the readings in the Learn tab, are stored in files rather than the Realm database.

#### Views

In iOS development it seems quite common to delegate all view creation/manipulation responsibilities to the controllers rather than subclass `UIView` directly.  I'm not keen on this pattern; controllers can very easily grow to thousands of lines this way, making it hard to distinguish between view/layout code and actual business logic.  I found it much simpler to abstract complex views into their own `UIView` subclasses with accompanying public APIs and delegate protocols for interaction with controllers.  This also drastically simplified the 