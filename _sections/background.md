---
section: 2
title: Background
---

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

#### Realm

The [Realm mobile database](http://realm.io) will be used as a replacement for the Apple-provided Core Data framework.  Realm promises a simpler, thread-safe API with lower overhead and better integration with object-oriented programming constructs.  Every user-generated data object in this thesis’ application that needs to be stored persistently, excluding preferences and other configuration, will use the Realm database and accompanying programming structures.

#### Async

This [small library](https://github.com/duemunk/Async) provides a more elegant API for the Apple-provided Grand Central Dispatch (GCD) framework.  From the [Apple documentation](https://developer.apple.com/library/prerelease/ios/documentation/Performance/Reference/GCD_libdispatch_Ref/index.html):

> Grand Central Dispatch (GCD) comprises language features, runtime libraries, and system enhancements that provide systemic, comprehensive improvements to the support for concurrent code execution on multicore hardware in iOS and OS X.

All calls to asynchronous GCD methods in this thesis’ application will come from this library.

### Related Applications

There are several iOS applications that already address anxiety or at least offer some of the same treatment strategies as this thesis’ application.  A quick search of the App Store for “anxiety” returns 852 results; a small, diverse sample of these will be discussed briefly below along with their respective strengths and weaknesses.

#### Self-help for Anxiety Management (SAM)

This [free application](https://appsto.re/us/ljHVN.i) from the University of the West of England offers much of the same functionality as this thesis’ application.  Its default screen, shown below in Figure 3.1, highlights this fact: among the options listed are techniques for relieving anxiety symptoms immediately, a self-monitoring tool that allows users to log their level of anxiety at any time (with an accompanying tracker that shows a graph of these logs), and a “social cloud” that allows users to post comments about their anxiety and reply to other users’ concerns.

{% include f.html src='/img/sam-home.png' caption='SAM’s home screen' %}

SAM clearly hopes to offer a comprehensive treatment program for anxiety patients, and for the most part, it likely succeeds. The relaxation techniques are robust and easy to follow, and all of the application’s features work as advertised.  The app has also received numerous positive reviews on the App Store, which is excellent considering its noble intentions. That being said, one improvement that may help the application better service its users is an improved flow. The grid of options seen in Figure 2.1, for example, is certainly useful, but doesn’t seem to guide users through the anxiety recovery process. Of course, users can tap the first button, “Working with SAM”, to get more information, but it’d be more helpful to incorporate the recovery process into the interface design itself without hiding it behind a button.  The grid also makes all the options look equally as important, even though some, like “Help for Anxiety NOW”, may be far more relevant if the user is currently experiencing an anxious episode (which would be a reasonable explanation for launching SAM in the first place).  Overall, though, SAM likely gets more right than wrong, and it’s encouraging to see another anxiety application having a positive impact on user’s lives.

#### Calm

This [free application](https://appsto.re/us/QZpfI.i) by Calm.com, Inc. focuses exclusively on meditation and relaxation techniques. According to the application description5, it includes: 7 guided meditation sessions, 10 “immersive nature scenes”, 16 relaxing music tracks, and 50 additional, purchasable guided meditations.  Its user interface, shown in Figure 2.2, revolves around a user-customizable looping scene, which defaults to a video of rain on leaves.

{% include f.html src='/img/calm-home.png' caption='Calm\'s home screen' %}

Like SAM, however, Calm’s main screen might benefit from an improved visual hierarchy.  The “Programs” button, which launches a full list of available meditation programs, certainly seems to be the most important tool available on this screen, though it’s given equal visual importance as the “Scenes” button which simply changes the background of the application. Calm’s meditation programs, on the other hand, are well-structured and provide clear starting points for relieving anxiety-related symptoms; the “7 Days of Calm” program shown in Figure 2.4 is exemplary.

{% include f.html src='/img/calm-program.png' caption='Calm\'s "7 Days of Calm" program' %}

Unfortunately, Calm also lacks any positive psychology/relapse prevention tools, though it doesn’t claim to target GAD patients in particular, so this choice may have been intentional.  In any case, the application’s limited scope and focused design is commendable and fully deserving of the many positive reviews it’s received on the App Store.