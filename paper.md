---
layout: essay
permalink: /
---

## Background

### Generalized Anxiety Disorder (GAD)

Anxiety in itself is not disorderly.  In fact, as Bourne {% include c.html r=0 a=false %} and other authors have noted, anxiety is often considered inevitable in contemporary society.    Worrying can be a useful, appropriate response to challenging situations in everyday life.  It becomes a diagnosable disorder, however, when a person worries excessively about a variety of everyday problems for at least 6 months {% include c.html r=3 %} in a way that noticeably interferes with their normal lives. Physical symptoms of GAD can include fatigue, headaches, nausea, twitching, muscle aches, and irritability; mentally, patients can’t relax, startle easily, and have difficulty falling asleep.

GAD affects about 3.1% of American adults (aged 18 years or older) in a given year, totaling about 6.8 million with twice as many women as men.  The average age of onset is 31 years old, though it often develops gradually between childhood and middle age.  The goal of this thesis is to develop an interactive self-help iPhone application that offers a comprehensive recovery program for all GAD patients by incorporating principles from some of the most extensively researched treatments available.

#### Treatment

Relapse is a major concern for GAD patients. Treatment options that address one or two contributing causes (biology, upbringing, conditioning, stressors, self-talk and belief, ability to express feelings, etc.) usually only alleviate GAD symptoms temporarily.  According to Bourne {% include c.html r=0 a=false %}, a complete program of recovery from an anxiety disorder must reduce physiological reactivity, eliminate avoidance behavior, and change subjective interpretations or self-talk which perpetuate a state of apprehension and worry. Meta-analyses have already shown computer-based self-help treatments to be effective in these areas {% include c.html r=2 %}.

#### Cognitive-Behavioral Therapy (CBT)

GAD patients tend to view the world as a threatening place, a misperception that can intensify quickly and lead to a downward spiral of anxious responses {% include c.html r=5 %}.  Cognitive-behavioral therapy (CBT), one of the most popular treatment options available for GAD, is based on this observation.  Self-monitoring is foundational to CBT; patients are taught to pay attention to their anxiety level throughout daily activities to catch patterns of worrisome thinking early on and cope with them immediately using a variety of techniques.  These can be personalized from patient to patient, but often include practices like meditation, guided imagery, muscle relaxation, deep breathing, etc.

#### Positive Psychology

Positive psychology is a semi-structured treatment for depression and anxiety that tries to shift patient’s focus towards positive emotions and personal strengths.  Techniques can include daily exercises that emphasize positive experiences or structured journals to record such episodes of wellbeing.  Positive psychology was designed as a complement to more comprehensive methods, like CBT, not a freestanding alternative in its own right.  That being said, studies show that positive psychology (also called Well-Being Therapy) paired with CBT can be more effective at preventing relapse in GAD patients than CBT alone {% include c.html r=1 %}.

### iOS Design

The design of any mobile application is arguably one of the biggest determinants of its overall success and adoption.  Human-computer interaction principles drive an application’s choices of layout, typography, user interface (UI) elements, and even specific shapes and color schemes. This thesis’ application is no exception; due to its unique, specific target audience, the majority of its foundational design decisions will be informed by well-researched principles and documented guidelines rather than personal preference or other influences.  Whenever possible, this application’s design will seek to diminish or at least remain neutral to symptoms of GAD, never contribute to them.  Great care will be taken to ensure its design is easy to follow, unobtrusive, consistent with other platform applications, and immediately helpful.

#### Human-Computer Interaction (HCI)

At a very basic level, every software application performs two essential operations: accepting input from a user and outputting some form of data in return.  An application’s interface is where this transaction takes place, where people apply inputs so the computer can output the data they want. The goal of Human-Computer Interaction (also called “interaction design”, “UI/UX design”, or simply “software design”), quite simply, is to make this transaction as frictionless as possible.

Unsurprisingly, application interfaces vary immensely among the countless operating systems and devices available. Common interface elements exist, of course: buttons usually trigger specific actions, text fields accept keyboard input, checkboxes toggle values on or off, etc. Most platforms rely on some notion of a screen, a unified arrangement of these elements that lets the user focus on a single task at once (i.e. logging in, creating a new calendar event, choosing a song to play, etc.). On the iOS platform, an application’s interface is often little more than a collection of individual screens.  The Weather application, for example, has a screen that lists the locations a user is interested in, a screen to add a new location to this list, and a screen detailing the weather for a specific location.  Because of this emphasis on individual screens, the sequence of actions a user takes to navigate through the application – often called “flow” – becomes crucially important.  One of the key principles of iOS design is to enable users to transition through screens in a way that closely resembles their own thought process for accomplishing their task.

Equally as important as flow, however, is the arrangement of elements on the screens themselves.  Nearly every screen is made up of interface elements with varying degrees of importance to the user’s task. In the new location screen from the Weather application mentioned above, the button to cancel the operation and return to the listing screen should appear less important than the textbox allowing the user to type in a new location, sensibly assuming the user didn’t end up on this screen by accident.  In all fields of design, visual hierarchy refers to the importance users tend to ascribe to certain elements over others.  There are numerous aspects that contribute to a sense of importance: placement on the screen (users often look near the top first, so any elements there will likely receive more attention than those elsewhere), size, color, shape, and more.  A large portion of software design in general, therefore, is establishing a visual hierarchy that most closely maps to the user’s intention in any given screen.

#### iOS Human Interface Guidelines (HIG)

Beyond these foundational HCI principles, operating systems often have their own design standards and interface element libraries so that every application retains a sense of familiarity and intuitiveness for its end users.  iOS is no exception; Apple publishes and maintains the [iOS HIG](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/index.html), a set of documents describing the overreaching design philosophy behind iOS and how developers can best design their applications for the platform.  Beyond specific implementation details like button sizes and navigation patterns for certain screen flows, the latest version of the HIG affirms a few broad principles for iOS interface design.  Most notably, interfaces should never compete with the content they provide.  Excessive decoration on interface elements is seen as a distraction from the application’s content, a sentiment that’s been clearly reflected in the latest versions of the standard UI toolkit.  Buttons have been stripped of almost all styling, elements like tab bars no longer appear glossy, navigation bars no longer try to appear 3-dimensional, etc.  Though some designers have criticized this new direction for its diminished visual hierarchy, interfaces that still rely heavily on such ornamentation now look blatantly outdated.  As such, to stay true to the iOS platform, this thesis’ application will defer to the HIG whenever possible for many major design decisions.

#### Color Psychology

Broadly speaking, color psychology is the study of color as it affects mood, emotions, and behavior.  Though research in this area is sometimes criticized for its inconsistency, some studies undoubtedly make implications for software design.  The reason red is almost always used in error messages or alert dialogs, for example, is because the color has been found to excite more emotion than neutral colors like blue and green {% include c.html r=4 %}. In the latest version of iOS, color is often the only visual cue that distinguishes interactive interface elements from non-interactive elements.  By default, most buttons are now styled identically to normal text, differing only in font color (and sometimes size). Beyond these functional benefits, however, interfaces can also use color as decoration or to influence their users in some way.  An orange headline may draw more attention than a gray one, for example, while a light blue background may look more visually appealing than a white one.  In this thesis’ application, any colors would preferably ease users rather than exacerbate their anxious symptoms, so each color will be considered chosen based on relevant research from this discipline.

### iOS Development

This thesis’ iPhone application will be developed using the official toolchain provided by Apple, Inc.  This includes the Xcode IDE (Integrated Development Environment), which itself contains Interface Builder for laying out the application’s UI components, Instruments for debugging the application, and Simulator for testing the application without a device; the UIKit framework; iTunes Connect for managing provisioning profiles and deploying on actual devices; and the newly released Swift programming language.  The codebase for the application will be version controlled using the popular Git system with a remote copy stored on Github.  In addition to these standard tools, however, several third-party frameworks will be used to save time and avoid unnecessary code duplication.

#### Async

This [small library](https://github.com/duemunk/Async) provides a more elegant API for the Apple-provided Grand Central Dispatch (GCD) framework.  From the [Apple documentation](https://developer.apple.com/library/prerelease/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html):

> Grand Central Dispatch (GCD) comprises language features, runtime libraries, and system enhancements that provide systemic, comprehensive improvements to the support for concurrent code execution on multicore hardware in iOS and OS X.

The library offers simple block chaining as well, a feature sorely missing from GCD's standard API.

#### SDCloudUserDefaults

Traditionally, when developers need to save user preferences in iOS applications they'd rely on Apple's `NSUserDefaults` class, which "provides a programmatic interface for interacting with the defaults system" (according to the [documentation](https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSUserDefaults_Class/index.html)). With the introduction of iCloud, however, it often became desirable to sync some or all of a user's preferences among all their devices automatically. [This library](https://github.com/sdarlington/SDCloudUserDefaults) promises a simple API for doing exactly that.

#### Realm

The [Realm mobile database](http://realm.io) is a replacement for Core Data, Apple's complex object graph and persistence framework. Though Core Data is undoubtedly powerful, it is often criticized as being unwieldy and unforgiving for novice programmers. Realm promises a simpler, thread-safe API with lower overhead and better integration with object-oriented programming constructs.

#### SSDynamicText

iOS 7 introduced a new feature called Dynamic Text that allows users to specify their preferred text size from the Settings application.  Developers who implement the appropriate APIs can use this feature to resize their application's text according to the user's global preference.  Unfortunately, these APIs are slightly cumbersome and often lead to repetitive code.  [SSDynamicText](https://github.com/splinesoft/SSDynamicText) greatly simplifies the process by subclassing `UILabel` and other base classes to incorporate Dynamic Text features directly.

#### UIImage+Additions

[This library](https://github.com/vilanovi/UIImage-Additions) offers numerous extensions to the `UIImage` class for manipulating images within Cocoa applications.  Examples include creating static images for a single color, resizable images with corner radii, tinted images from existing ones, superimposed images, gradient images, and more.

### Related Applications

There are several iOS applications that already address anxiety or at least offer some of the same treatment strategies as this thesis’ application.  A quick search of the App Store for “anxiety” returns 852 results; a small, diverse sample of these will be discussed briefly below along with their respective strengths and weaknesses.

#### Self-help for Anxiety Management (SAM)

{% include f.html f=0 align="left" %}

This [free application](https://appsto.re/us/ljHVN.i) from the University of the West of England offers much of the same functionality as this thesis’ application.  Its default screen, shown below in {% include fr.html f=0 %}, highlights this fact: among the options listed are techniques for relieving anxiety symptoms immediately, a self-monitoring tool that allows users to log their level of anxiety at any time (with an accompanying tracker that shows a graph of these logs), and a “social cloud” that allows users to post comments about their anxiety and reply to other users’ concerns.

SAM clearly hopes to offer a comprehensive treatment program for anxiety patients, and for the most part, it likely succeeds. The relaxation techniques are robust and easy to follow, and all of the application’s features work as advertised.  The app has also received numerous positive reviews on the App Store, which is excellent considering its noble intentions. That being said, one improvement that may help the application better service its users is an improved flow. The grid of options seen in {% include fr.html f=0 %}, for example, is certainly useful, but doesn’t seem to guide users through the anxiety recovery process. Of course, users can tap the first button, “Working with SAM”, to get more information, but it’d be more helpful to incorporate the recovery process into the interface design itself without hiding it behind a button.  The grid also makes all the options look equally as important, even though some, like “Help for Anxiety NOW”, may be far more relevant if the user is currently experiencing an anxious episode (which would be a reasonable explanation for launching SAM in the first place).  Overall, though, SAM likely gets more right than wrong, and it’s encouraging to see another anxiety application having a positive impact on user’s lives.

#### Calm

{% include f.html f=1 align="right" %}

This [free application](https://appsto.re/us/QZpfI.i) by Calm.com, Inc. focuses exclusively on meditation and relaxation techniques. According to the application description5, it includes: 7 guided meditation sessions, 10 “immersive nature scenes”, 16 relaxing music tracks, and 50 additional, purchasable guided meditations.  Its user interface, shown in {% include fr.html f=1 %}, revolves around a user-customizable looping scene, which defaults to a video of rain on leaves.

{% include f.html f=2 align="left" %}

Like SAM, however, Calm’s main screen might benefit from an improved visual hierarchy.  The “Programs” button, which launches a full list of available meditation programs, certainly seems to be the most important tool available on this screen, though it’s given equal visual importance as the “Scenes” button which simply changes the background of the application. Calm’s meditation programs, on the other hand, are well-structured and provide clear starting points for relieving anxiety-related symptoms; the “7 Days of Calm” program shown in {% include fr.html f=2 %} is exemplary.

Unfortunately, Calm also lacks any positive psychology/relapse prevention tools, though it doesn’t claim to target GAD patients in particular, so this choice may have been intentional.  In any case, the application’s limited scope and focused design is commendable and fully deserving of the many positive reviews it’s received on the App Store.

## Methodology

### Ideation

Truthfully, the only thing I knew when starting this thesis was that I wanted to develop an iPhone application.  From here, however, the topic came quite naturally.  Anxiety is a personal issue to me; I've certainly experienced it myself and have learned a great deal while trying to treat it through self-help and other methods (with varying degrees of success).  I knew from firsthand experience how helpful some self-help applications were to me, so I felt this project could be an incredible opportunity to help others recover as well.  It had a far greater sense of meaning to me than any of the other ideas I considered at the time, and as soon as I began researching I felt confident I had made the right choice.

#### Core features 

One of the first steps I took in brainstorming this application was to create a list of essential functions it would need to guide a user through the anxiety recovery process.  Based primarily on the background research I'd conducted, I settled on three core features:

1. ##### Reading materials
This feature was guided more by my own experience coping with anxiety than any of the studies I'd read during my background research.  I've found it incredibly helpful to read objective, somewhat scientific explanations of anxiety and its symptoms; it offers the chance to step back from the unpleasant feelings associated with the disorder and gain a clearer understanding of their origin, which sometimes makes them disappear entirely.  Moreover, I felt any application that would attempt to guide users through an anxiety recovery process would warrant at least a vague description of the actual disorder itself.  This would hopefully instill a sense of confidence in the user about the application's approach to recovery, and make them more likely to keep using it.
1. ##### Immediate symptom relief
This feature was self-explanatory.  Any application claiming to help users recover from anxiety should be expected to alleviate anxious symptoms, including shortness of breath, intense agitation and confusion, and the others mentioned in the background section.  Fortunately, studies on CBT offer a wealth of relaxation techniques, so my job at this point was simply to decide which ones could most benefit from an interactive user experience, then realistically determine how many I would be able to develop within my timeframe.  I eventually settled on the following exercises:
 * Deep breathing
 * Calming scene (i.e. a video/image of a peaceful landscape)
 * Guided meditation
 * Coping statements
1. ##### Long-term shift towards positivity
Since the previous feature covered the CBT aspect of anxiety recovery, I knew I wanted to include a Positive Psychology aspect into my application.  Again, much of the research literature seemed to agree that the most helpful technique for overcoming relapses is to keep a daily journal of positive events, no matter how trivial.  I felt this could easily be incorporated into my application.

Normally, such a list might be subject to change as design and development of the application progresses; features could be deemed unnecessary or priorities could shift to include new ones.  With my extremely limited timeframe, however, I knew I wouldn't want to deal with a growing feature set in the later stages of development, and I felt having such a short list would keep me focused on the most important aspects of the application at all times.  As soon as I felt confident in these features, then, I immediately moved on to the visual design phase.

### Design

I knew before I began that much of the design phase of this application would inevitably overlap with the development phase, as I'd be managing both aspects myself and wouldn't have to rely on a linear process as much as two separate teams dedicated to each task would.  That being said, I did make it a point to perform a few design-related steps before writing any code, as I felt they'd help me focus better during both phases.

#### Goals

Before I started thinking about layout, color palettes, interactions, or any specific detail of the application's visual design, I solidified a few goals to keep in mind over the duration of the design process.

1. ##### Be easy to use
This goal may sound trivial, but I felt it was necessary to keep in mind considering the target audience for the application.  I never wanted to find myself designing something obtuse, or anything that would add an unnecessary burden to the user's experience.  If the user was already in an unpleasant or agitated mental state, a likely possibility given the nature of the disorder, I did not want this application to exacerbate it.
1. ##### Cover the essential aspects of anxiety recovery
Though I wanted to keep the feature set of this application to a bare minimum, I did feel it was important that I provided as complete a self-help anxiety recovery program as possible within my time frame.  I thought it would be ideal if the application could confidently stand on its own as a starting point for relapse-free anxiety treatment, yet easily allow for the possibility of extending it through more specific applications, such as [Headspace](https://www.headspace.com) or [Calm](http://calm.com) for a more comprehensive meditation practice. 
1. ##### Be unobtrusive yet involved
I felt this was the most important balancing act I'd have to perform when designing the application.  On the one hand, I can speak anecdotally about the importance of consistency when attempting to overcome anxious symptoms; it's easy to "forget" to practice relaxation techniques when everything feels like it's going smoothly, though repetition seems to be a key aspect of long-term anxiety recovery.  On the other hand, I didn't want users to start perceiving the application as an annoyance more than an aid, so I wanted to be mindful of this distinction as much as possible.

After I wrote these down I felt I had a clear enough guide to begin laying out the application.

#### User Personas

As an additional aid in the design process I created {{ site.data.personas | size }} personas as representations of my target audience.  Considering I lacked quantitative user research or any sort of analytics that usually serve as reference points, I used my research of GAD symptoms and recurring personality traits as guidelines instead:

<ul class="o-block-list o-box">
	{% for persona in site.data.personas %}
		<li>{% include p.html p=forloop.index %}</li>
	{% endfor %}
</ul>

I found this step crucial when trying to establish a clear direction for the application's design. It was easy in the early stages of the design process to lose focus and plan for too many features, attempting to accommodate unrealistic use cases or planning for features I'd personally enjoy implementing, rather than ones users might like to see.  By putting a face (albeit imaginary) to some exemplary users, I found it easier to establish a visual hierarchy for the application, prioritize certain features over others, and limit the number of overall screens to a bare minimum. It kept me slightly more motivated as well; having a list of users in mind kept me more enthused about the project than when I felt I was designing it exclusively for myself.  I referred to these personas repeatedly throughout the rest of the design process.

#### Wireframes

With the personas, goals, and core features in mind, I began sketching some initial ideas for the application's layout and main screens:

{% include f.html f=6 %}
{% include f.html f=7 %}
{% include f.html f=8 %}

Surprisingly, these were the only wireframes I ever created for this application.  It's possible I was close-minded to other layouts or approaches considering I'd mentally solidified my feature set above, but I'd like to think I had a clear enough direction at this point to move on from the wireframing stage altogether.  In any case, these wireframes served me well for the remainder of the design stage, and it's interesting to note how much the final design resembled these initial sketches.  For that reason, the layout choices visible here will be explained in detail in the section below.

#### Final layout

Traditionally, a designer at this point would likely create a few high-fidelity mockups (and sometimes interactive prototypes) to send to a developer to code into a working application.  As I would be doing the development work myself, however, I skipped this step and designed most of the screens as I coded the application, only using a graphic editing program ([Sketch](http://bohemiancoding.com/sketch/)) to create specific visual assets I needed as I went along.  This is the layout I ultimately arrived at:

<div class="o-layout o-wrapper__wider">
	<div class="o-layout__item o-1/3">
		{% include f.html f=9 %}
	</div><!--
	--><div class="o-layout__item o-1/3">
		{% include f.html f=10 %}
	</div><!--
	--><div class="o-layout__item o-1/3">
		{% include f.html f=11 %}
	</div>
</div>

The application is divided into three primary actions: "Learn", "Relax", and "Reflect", each representing one of the core features described above.  A tab layout was used in accordance to the iOS HIG, which prefers a tab bar “to support a flat information architecture” {% include c.html r=6 a=false p="49" %}.  The tab icons were taken from [the NounProject](https://thenounproject.com), used with permission.

##### Onboarding

When a user launches the app for the first time after downloading they're greeted with the following onboarding tutorial:

<div class="o-layout o-wrapper__wider">
	<div class="o-layout__item o-1/5">
		{% include f.html f=12 %}
	</div><!--
	--><div class="o-layout__item o-1/5">
		{% include f.html f=13 %}
	</div><!--
	--><div class="o-layout__item o-1/5">
		{% include f.html f=5 %}
	</div><!--
	--><div class="o-layout__item o-1/5">
		{% include f.html f=14 %}
	</div><!--
	--><div class="o-layout__item o-1/5">
		{% include f.html f=15 %}
	</div>
</div>

Onboarding tutorials like this are a kind of gray area in iOS app design.  At best, they provide a clearer starting point for new users than, say, an empty screen; at worst, they force the user to read fluffy marketing text and/or sign up for a service before they can begin using the application.  Apple seems divided on the issue as well, advising designers to "think carefully before providing an onboarding experience" {% include c.html r=6 p="36" %}.  I heeded their advice, ultimately deciding a brief welcome/instruction screen would be beneficial considering the nature of this application.  In accordance with one of my goals, I wanted to offer a guided recovery program for these users even from first launch, and felt I could do better than the default screen (the "Relax" tab) in this regard.

The onboarding screen itself was then designed with Apple's guidelines in mind. Specifically, the HIG instructs:

* “**Give users only the information they need to get started**” {% include c.html r=6 a=false y=false p="38" %}  
The screens included in the final application were deemed most important for first launch.  A brief description of GAD, {% include fr.html f=13 %}, was included after the welcome slide to provide a clear understanding of the disorder and who might be affected.  Next, an explanation of the application's three main tabs and how to use them was given in {% include fr.html f=9 %}. The daily reflection reminder preference wasn't shown here, set to a reasonable default of 8p.m. instead, while the relaxation reminder - which ideally would be set to the user's normal waking time - felt more individualized so it was shown in the second to last slide ({% include fr.html f=14 %}). The last slide contained some final words of encouragement, and a button to dismiss the tutorial ({% include fr.html f=15 %}).
* “**Use animation and interactivity to engage users and help them learn by doing**” {% include c.html r=6 a=false p="38" %}  
Admittedly, the onboarding tutorial falls short from a user engagement perspective.  Given more time, some slides could certainly benefit from additional interactivity, especially {% include fr.html f=5 %} which a user might reasonably skip due to its intimidating length.  In any case, the tutorial itself is interactive, using the recommended page control {% include c.html r=6 a=false y=false p="49" %} to allow users to swipe back and forth between slides.
* “**Make it easy to dismiss or skip the onboarding experience**” {% include c.html r=6 a=false y=false p="39" %}  
Apple encourages developers to remember whether a user has viewed the onboarding tutorial to ensure it's only displayed once.  This was implemented during the development phase of the application, discussed in the "Architecture" section below.

Once the user reaches the final slide of the tutorial and taps the "Get Started" button, the tutorial is dismissed and they can begin exploring the application.

##### Learn tab

This tab ({% include fr.html f=9 %}) represents the first core feature from the section above: reading materials.  There are two UI elements on this screen: a button to re-launch the instructions slide from the onboarding tutorial ({% include fr.html f=5 %}) and a table view listing of the available readings.  A table view was selected to display this information per the iOS HIG, which recommends the control to "provide a list of options from which users can select" and "display hierarchical data" {% include c.html r=6 a=false p="337" %}.  The readings are excerpts from [Bourne](#reference-0) and the [National Institute of Mental Health](#reference-3).  When a user taps one of the available readings ({% include fr.html f=16 %}), an expanded reading view opens ({% include fr.html f=17 %}).  As the user scrolls to begin reading, the navigation bar and status bar disappears to support a full-screen presentation ({% include fr.html f=18 %}).  These elements reappear when the user scrolls back up, allowing him/her to return to the Learn tab.

<div class="o-wrapper__wide">
	<div class="c-flow">
		<div class="c-flow__item">
			{% include f.html f=16 %}
		</div>
		<div class="c-flow__item">
			{% include f.html f=17 %}
		</div>
		<div class="c-flow__item">
			{% include f.html f=18 %}
		</div>
	</div>
</div>

The background color of this tab is light blue, chosen for its calming properties {% include c.html r=4 %} and suitability for dark foreground text.

##### Relax tab

Yadda yadda

##### Reflect tab

Yadda yadda 

### Architecture

This application was developed using the latest version of the standard iOS development toolkit provided by Apple, including Xcode 6.3 (with Swift 1.2) and iOS SDK 8.3.  The newer Swift language was preferred over its predecessor, Objective-C, for its modern features and familiar syntax, though I didn't have experience with either language before this project.

#### Dependencies

All third-party dependencies were managed using the open-source [CocoaPods](http://cocoapods.org) dependency manager, version 0.36.1.  This seems to be the de facto standard for managing dependencies in Cocoa projects, besides [Git submodules](http://git-scm.com/book/en/v2/Git-Tools-Submodules) or plain copy-and-pasting.  The dependencies for this application are listed in a text file named `Podfile` in the project's root, which is analyzed by the CocoaPods command line tool:

~~~ ruby
pod 'Async', git: 'https://github.com/duemunk/Async.git', branch: 'feature/Swift_1.2'
pod 'SDCloudUserDefaults'
pod 'Realm'
pod 'SSDynamicText', :head 
pod 'UIImage+Additions'
~~~

These frameworks were already discussed in the background section. Without specifying a version number, CocoaPods uses the latest version of each pod when installing or updating dependencies.  This had the potential to quickly break the application if a pod released an update with API changes, but due to the short development cycle and continuous updates to the Swift language itself, I found it beneficial to stay on the latest version of each dependency.

##### Async

I didn't up using Async nearly as much as I anticipated. In fact, I only used its timeout API in some of the relaxation exercises to hide the instruction prompts after a fixed delay.  If it were a larger library I'd consider removing it for file size reasons, but since it's nicely contained in a single `.swift` file I don't think this is an issue.  It's certainly an improvement over the Grand Central Dispatch API, in any case.

##### SDCloudUserDefaults

Though I only save two pieces of user data in this application - whether the user has seen the welcome tutorial and their previously viewed scene in the Calming Scene relaxation exercise - this library was absolutely painless to incorporate into the application, especially with Swift's extension system discussed below.  If nothing else, it guarantees that a user with iCloud enabled won't view the welcome tutorial more than once, and that's reason enough to include such a small library in my opinion.

##### Realm

I hardly used Realm to its full extent, only relying on it to persistently store one model of data and only querying the database from one controller, but I was thoroughly impressed with its ease of use. I have no experience with Core Data, so I won't bother to compare its API with Realm's, but judging from what I've read in Apple documentation it undoubtedly takes some time to familiarize oneself with Core Data enough to comfortably incorporate it into a project.  With Realm, on the other hand, I was able to create and query a model within minutes of installing the CocoaPod.

##### SSDynamicText

Simply put, nearly every label in this application is either a `SSDynamicLabel` or `SSDynamicTextView`.  This library made Dynamic Text incorporation absolutely trivial, and I never had to adjust my code to account for text size adjustments.  In nearly every case it was simply a matter of using the appropriate `SSDynamicText` subclass instead of the built-in Cocoa equivalent.

##### UIImage+Additions

This library was invaluable for tinting most of the user interface-related images in the application.  In early versions of the application, for example, I included different gradient images for the light blue background on the Learn tab, the blue background on the Relax tab, and the green background on the Reflect tab.  With this library, I was able to ship one version of each image and tint it appropriately before displaying it.  This not only saved countless hours slicing and exporting various versions of the same image, but also saved on file size (resulting from fewer images) and ensured each image was the exact same (besides tint color).

#### Extensions

One of the most powerful features of the Swift programming language is the ability to extend types, including built-in classes, with new methods and computed properties.  I used this feature extensively throughout the project for two main purposes: to add functionality to core Cocoa abstractions like `NSDate` (for working with dates and times) and to create helper "factory" methods for application-specific constants.  The latter is a design pattern fully endorsed by Apple's official documentation; instead of specifying global `UIColor` constants for project-specific theme colors:

~~~ swift
public let blueColor = UIColor(r: 82, g: 173, b: 204)
~~~

the company recommends extending the UIColor class directly with factory methods:

~~~ swift
extension UIColor {
	class func applicationBlueColor() -> UIColor {
		return UIColor(r: 82, g: 173, b: 204)
	}
}
~~~

which can then be accessed through `UIColor.applicationBlueColor()`.  Though theme coloring is an admittedly simple example, it's easy to see how elegant this design pattern becomes when considering more complex objects such as reusable `UILabel` styles:

~~~ swift
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
~~~

I used this design pattern whenever possible, resorting to subclasses for only the most complex scenarios when method overrides were required.

#### Models

The only true database-backed model in this application was `Reflection`, a simple Realm-based class containing properties for a positive event, its reason, and the date it occurred (defaulting to the current time):

~~~ swift
class Reflection: RLMObject {
	dynamic var event = ""
	dynamic var reason = ""
	dynamic var date = NSDate()
}
~~~

This class was used exclusively in the Reflect tab; the scrolling timeline fetches all entries within the previous month and the new reflection screen creates a new `Reflection` object based the user's input.  Other sources of persistent data, like the readings in the Learn tab, are stored in files rather than the Realm database.

#### Views

In iOS development it seems quite common to delegate all view creation/manipulation responsibilities to the controllers rather than subclass `UIView` directly.  I'm not keen on this pattern; controllers can very easily grow to thousands of lines this way, making it hard to distinguish between view/layout code and actual business logic.  I found it more elegant to abstract complex views into their own `UIView` subclasses with accompanying public APIs and delegate protocols for interaction with controllers.  This also drastically encouraged and simplified view re-usage. For example, instead of creating and configuring two separate `UIView`s for the relaxation and reflection reminders, shown in {% include fr.html f=3 %} and {% include fr.html f=4 %} respectively, an abstracted `DailyReminderView` class was created and configured by each tab's view controller.

<div class="o-layout o-wrapper__wide">
	<div class="o-layout__item o-1/2">
		{% include f.html f=3 %}
	</div><!--
	--><div class="o-layout__item o-1/2">
		{% include f.html f=4 %}
	</div>
</div>

This class uses a delegate, `DailyReminderViewDelegate`, with handlers for changes to the toggle switch in the top right and date picker below:

~~~ swift
@objc protocol DailyReminderViewDelegate {
	optional func dailyReminderView(dailyReminderView: DailyReminderView, didToggleReminder reminder: Bool)
	optional func dailyReminderView(dailyReminderView: DailyReminderView, didChangeTime time: NSDate)
}
~~~

Each tab's view controller creates an instance of this view, configures it using the class' public API, implements its protocol, and sets itself as the view's delegate.  In the delegate methods, each controller creates or updates the appropriate global `UILocalNotification` object for each reminder.

#### Controllers

Besides the aforementioned point of separating view-related concerns into their own `UIView` subclasses, I used `UIViewController`s in a seemingly traditional way throughout this application.  Each individual screen, including each tab, the new reflection modal, the relaxation exercises, etc. are represented with one `UIViewController`, which creates and manages its subviews and occasionally interfaces with the Realm database.

Beyond these, I created a custom `UIViewController` subclass named `SlidingViewController` that manages paginated view controllers with a nearly identical API to Apple's own `UITabBarController`. I used this class for the welcome tutorial and the calming scene relaxation exercise shown above.

I also created a protocol named `FullScreenController` that's implemented by almost every controller in the application.  This protocol, and its accompanying global methods, manages various portions of the user interface to accommodate single-color backgrounds.  For example, in each of the three main tabs, this protocol ensures the tab bar background, the status bar background, and (sometimes) the navigation bar background all match the controller's primary color.  This creates the effect that each screen's elements are "floating" atop a solid background color.  Unlike the `SlidingViewController`, I chose to use a protocol instead of a subclass for this feature because I wanted to be able to implement it on any subclass of `UIViewController` I wanted.  If I made `FullScreenController` a subclass, I'd have to also create accompanying `FullScreenTabBarController`s, `FullScreenNavigationController`s, and `FullScreenTableViewController`s, just to name a few.  Unfortunately, Swift lacks mix-in functionality that's found in languages like Ruby, but I saw this "protocol-with-global-methods" pattern used repeatedly on many iOS development sites, and it worked quite well for this scenario.

### Debugging

This application was tested primarily on the iPhone simulator provided by the iOS developer toolkit.  The simulator is generally much faster than using an external device, so I often only tested major versions of the application on my personal iPhone 6.  The simulator makes it trivial to test against the numerous iPhone screen sizes as well, though near the end of the development cycle I tested on the iPhone 4S, iPhone 5, iPhone 5S,  and iPhone 6+ to ensure the resulting product matched the simulator's version.

Xcode includes some incredibly helpful tools to debug applications through the simulator or connected device.  Breakpoints can be toggled and created at any point during execution, and all crashes are usually well-documented with stack traces other information.  There's also a tool to debug layouts visually, which was particularly helpful when first learning the ins-and-outs of the AutoLayout system.  Ultimately, I found no need to look beyond Xcode for any debugging tools, and only experienced a few truly "head-scratching" bugs.

### Version Control

By default, Xcode creates a Git repository for all new projects, so versioning this application was a straightforward process.  Before settling on a single direction I experimented with various approaches in separate Git branches, merging some as I went along until I arrived at a stable `master` branch.  I set up a remote [Github repository](http://github.com/mbarvian/thesis/) as well, which let me work with the same codebase on different computers.  I used the [Github for Mac app](https://mac.github.com) to make commits and keep the repository in sync.

## Testing

After the application was complete, user testing was conducted to measure its perceived usefulness and ease of use. Participants were solicited from North Central College's PSY 100 participant pool via the online research credit management system, SONA.  Two sessions of 4 participants were needed with no further prerequisites for participation.  Participants received 1 research credit in exchange for their participation in the study.

### Method

These studies were carried out with a single researcher in an individualized – rather than traditional focus group – format. Participants were assigned a 15-minute block within the study’s allocated time so that each participant could receive equal attention from the researcher. All participants were first given an [informed consent form](public/informed-consent.pdf) and a brief description of the application they’d be testing.  They were then assigned an identification number and given an iPhone (provided by the researcher) with the thesis’ application pre-installed.  They were asked to first interact with the application naturally without a specific goal in mind. Afterwards, they were asked to perform a variety of tasks with the application, such as “write a reflection” or “change the relaxation reminder time”. Participants were encouraged to voice any suggestions, criticisms, or other feedback during this time, all of which were compiled and selectively incorporated into the application after the studies were complete.  At the end of the study, participants were encouraged to ask any final questions or voice final concerns before being given a full explanation of the application and its intended use and audience.  Before leaving, they were thanked for their participation and given a final [debriefing form](public/debriefing.pdf).

### Results

Pending.

#### Modifications

Pending.

## Conclusion

Overall, I and I'm extremely grateful to have found a topic that felt so meaningful to me.

### Future work

My primary goal at this point is to continue tweaking the application until I feel comfortable publishing it on the App Store and making it available to all English-speaking iPhone users.  As expected, I 
