# EIQStory - iOS

# Requirements
- iOS 12.0+, iPadOS 13.0+
- Xcode 12.5+
- Swift 5+ (Library written in Swift 5.4)

# Installation

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate EIQStory into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://cdn.cocoapods.org/'
source 'https://oauth2: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@github.com/loodos/EIQ-story-ios.git'

platform :ios, '12.0'

use_frameworks!

target '<Your Target Name>' do
    pod 'EIQStory', '1.3.1'
end
```

Then, run the following command:

```bash
$ pod install
```

# Usage

Only **4** steps needed to use `EIQStory`

1️⃣ Import EIQStory in proper place.

```swift
import EIQStory
```

2️⃣ Now, set view for EIQStoryContainerCard. You achieve this in two ways:

### Using Code:
```swift
// Create EIQStoryContainerCard
let storyView = EIQStoryContainerCard()

// Add as subview
storyViewContainer.addSubview(storyView)

storyView.translatesAutoresizingMaskIntoConstraints = false

let heightConstraint = storyView.heightAnchor.constraint(equalToConstant: 80)
heightConstraint.priority = .defaultLow

NSLayoutConstraint.activate([
    storyView.topAnchor.constraint(equalTo: view.topAnchor),
    storyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    storyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    storyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
    heightConstraint
])

```


### Using IB/Storyboards:

Drag a UIView into ViewVontroller's view and set it's type to `EIQStoryContainerCard` from `Identity Inspector`, then set an outlet variable.

```swift
class ViewController: UIViewController {

    @IBOutlet weak var storyView: EIQStoryContainerCard!
}
```

3️⃣ Once you've set the views, now you need to initialize `EIQStoryManager`.

```swift
class ViewController: UIViewController, EIQStoryManagerDelegate {

    // ...

    // MARK: Story Module
    private func prepareStoryModule() {
        EIQStoryManager.initialize(
            containerCard: storyView, 
            delegate: self
        )

        prepareStoryModuleUI()
    }

    private func prepareStoryModuleUI() {
        var appearance = EIQStoryManager.shared.appearance
        // ...
        // ...
        // ...
        EIQStoryManager.shared.appearance = appearance
    }


    // MARK: EIQStoryManagerDelegate
    // ...
}
```

4️⃣ Finally set your story data. And done!

```swift
class ViewController: UIViewController, EIQStoryManagerDelegate {

    private var stories: [Story]()
    // ...

    private func fetchStories() {
        // ...
        stories = getStoryDataAndParse(from: response) // Response from your server or local.

        storiesCardView.viewModel = StoryViewModel(stories: stories)
    }
}
```

# Deeplink
You can open a story after initialize module for given index.

```swift
func handleDeeplink(url: URL) {
    // Find your story index from deeplink.
    // ...
    EIQStoryManager.shared.openStory(at: index)
}
```


# Customization
> You can customize almost everything by using `EIQStoryAppearance`. You can access it via
```swift
EIQStoryManager.shared.appearance
```

## Properties
<details>
<summary>Show</summary>

```swift
public struct EIQStoryAppearance {
    public enum ThemeType {
        case light
        case dark
        @available(iOS 13.0, *)
        case adaptive
    }

    /// Apperance mode
    public var theme: ThemeType = .light

    /// EIQStoryContainerCard's appearance
    public var list = List()

    /// Preview's appearance
    public var preview = Preview()
}

extension EIQStoryAppearance {
    public struct List {
        /// EIQStoryContainerCard's collection view and cell appearance
        public var item = ItemConfig()

        /// Collection Cell border appearance
        public var border = BorderConfig()

        /// Collection Cell image appearance
        public var image = ThumbnailConfig()

        /// Collection Cell title label appearance for story unseen state
        public var title = LabelConfig()

        /// Collection Cell title label appearance for story seen state
        /// Only `font` and `textColor` is used for appearance
        public var seenTitle: LabelConfig? = nil

        /// Collection Cell countdown label appearance
        public var countdown: CountdownLabelConfig? = CountdownLabelConfig()

        /// Collection Cell featured image appearance
        public var featured: ImageConfig? = ImageConfig(image: UIImage(named: "icStar", in: .EIQStory, compatibleWith: nil))

        /// Spacing between image container and title label
        public var titleSpacing: CGFloat = 8

        /// Container card background color
        public var backgroundColor: Colors = (light: .clear, dark: .clear)
    }

    public struct Preview {
        /// Preview Controller background color
        public var backgroundColor: Colors = (light: .black, dark: .black)

        /// Preview header appearance
        public var header = HeaderConfig()

        /// Preview snap appearance
        public var snap = SnapConfig()

        /// Preview footer appearance
        public var footer = FooterConfig()
    }

    /// Radius type
    public enum Radius {
        /// Circular (view's height / 2)
        case circular
        /// Custom value
        case value(cornerRadius: CGFloat)

        /// Returns value for custom corner radius. For `circular`, you need to calculate corner
        /// radius value yourself. (height / 2)
        public var value: CGFloat {
            switch self {
            case .circular: return 0
            case .value(let cornerRadius): return cornerRadius
            }
        }
    }

    public struct IndicatorConfig {
        /// Activity Indicator color
        public var tintColor: Colors = (light: .white, dark: .white)

        /// Activity Indicator Style
        public var style: UIActivityIndicatorView.Style = .white

        public init(
            tintColor: Colors = (light: .white, dark: .white),
            style: UIActivityIndicatorView.Style = .white
        ) {
            self.tintColor = tintColor
            self.style = style
        }
    }

    public struct LabelConfig: LabelProtocol {
        /// Font for labels
        public var font = UIFont.systemFont(ofSize: 12)

        /// Text color for labels
        public var textColor: Colors = (light: .darkText, dark: .darkText)

        /// Number of lines for label
        public var numberOfLines: Int = 2

        /// Text alignment for label
        public var alignment: NSTextAlignment = .natural

        /// Label visibility
        public var isHidden = false
    }
    
    public enum ImagePosition {
        case normal, lowered
    }

    public struct ImageConfig: ImageProtocol {
        /// Image
        public var image: UIImage? = UIImage(named: "icStar", in: .EIQStory, compatibleWith: nil)

        /// Placeholder
        public var placeholder: String?

        /// Options to specify how a view adjusts its content when its size changes.
        public var contentMode: UIView.ContentMode = .scaleAspectFit

        /// A color used to tint template images in the view hierarchy.
        public var tintColor: Colors?

        /// Image indicator appearance
        public var indicator: IndicatorConfig?

        /// The imageview’s background color.
        public var backgroundColor: Colors = (light: .clear, dark: .clear)
        
        /// The imageview's position
        public var position: ImagePosition

        public init(
            image: UIImage?,
            placeholder: String? = nil,
            contentMode: UIView.ContentMode = .scaleAspectFit,
            tintColor: Colors? = nil,
            indicator: IndicatorConfig = IndicatorConfig(),
            backgroundColor: Colors = (light: .clear, dark: .clear),
            position: ImagePosition? = nil
        ) {
            self.image = image
            self.placeholder = placeholder
            self.contentMode = contentMode
            self.tintColor = tintColor
            self.indicator = indicator
            self.backgroundColor = backgroundColor
            self.position = position ?? .normal
        }
    }

    public struct BorderConfig {
        /// Border container view background color.
        public var backgroundColor: Colors = (light: .clear, dark: .clear)

        /// Margin value between superview and border.
        public var margin: CGFloat = 0.0

        /// Border corner radius
        public var radius: Radius = .value(cornerRadius: 6)

        /// Border width for story seen state.
        public var seenWidth: CGFloat = 2.0

        /// Border color for story seen state.
        public var seenColor: Colors = (light: .systemGray, dark: .systemGray)

        /// Border width for story unseen state.
        public var unseenWidth: CGFloat = 2.0

        /// Border color for story unseen state.
        public var unseenColor: Colors = (light: .systemRed, dark: .systemRed)
    }

    /// StoryContainerCard collection cell's image appearance
    public struct ThumbnailConfig: MediaProtocol {
        /// Placeholder
        public var placeholder: String?

        /// Options to specify how a view adjusts its content when its size changes.
        public var contentMode: UIView.ContentMode = .scaleAspectFill

        /// - Warning: !!! Not used for thumbnail.
        public var tintColor: Colors?

        /// The imageview’s background color.
        public var backgroundColor: Colors = (light: .clear, dark: .clear)

        /// Margin between border view and image view. You need to consider border width.
        /// For example, let's assume that you give the border width as 3px. If you want a 10px
        /// spacing between border and image, margin value must be 13.0.
        public var margin: CGFloat = 8.0

        /// ImageView corner radius
        public var radius: Radius = .value(cornerRadius: 5)

        /// Image indicator appearance
        public var indicator: IndicatorConfig? = IndicatorConfig(tintColor: (light: .white, dark: .white), style: .white)

        /// GradientView's color for image. To hide it, set `nil`
        public var gradientColor: Colors? = (light: UIColor.black.withAlphaComponent(0.3), dark: UIColor.black.withAlphaComponent(0.3))
    }

    public struct ItemConfig {
        /// Cell image container's background color.
        public var backgroundColor: Colors = (light: .clear, dark: .clear)

        /// Size for image container.
        public var size = CGSize(width: 90, height: 90)

        /// Type of list appearance.
        public var listType: StoryListType = .circular

        /// CollectionView left and right inset.
        public var leftRightInset: CGFloat = 20

        /// Spacing between items.
        public var spacing: CGFloat = 16

        public enum StoryListType {
            case circular
            case rectangle
            case embeddedTitle
        }
    }

    public struct CountdownLabelConfig: LabelProtocol {
        /// Font.
        public var font = UIFont.systemFont(ofSize: 10)

        /// Text color.
        public var textColor: Colors = (light: .darkText, dark: .darkText)

        /// Number of lines.
        public var numberOfLines: Int = 1

        /// Text alignment.
        public var alignment: NSTextAlignment = .center

        /// Visibility.
        public var isHidden = false

        /// Container view's background color.
        public var backgroundColor: Colors = (light: .white, dark: .white)

        /// Corner radius for container view.
        public var radius: Radius = .circular
    }

    public struct HeaderConfig {
        /// ProgressBar appearance.
        public var progressBar = ProgressBarConfig()

        /// Close Image
        public var closeImage: ImageConfig? = ImageConfig(image: UIImage(named: "icCloseWhite", in: .EIQStory, compatibleWith: nil))

        /// Gradient View color. To hide it, set `nil`
        public var gradientColor: Colors? = (light: UIColor.black.withAlphaComponent(0.3), dark: UIColor.black.withAlphaComponent(0.3))

        /// Icon for featured story type. To hide it, set `nil`.
        public var featured: ImageConfig? = ImageConfig(image: UIImage(named: "icStar", in: .EIQStory, compatibleWith: nil))

        /// Icon for countdown story type. To hide it, set `nil`.
        public var countdown: ImageConfig? = ImageConfig(image: UIImage(named: "icClock", in: .EIQStory, compatibleWith: nil))

        /// Title label appearance
        public var title = LabelConfig()

        /// Countdown label appearance
        public var countdownText = LabelConfig()


        public struct ProgressBarConfig {
            /// Progress bar indicator's color.
            public var tintColor: Colors = (light: .white, dark: .white)

            /// Progress bar indicator's thickness.
            public var height: CGFloat = 3

            /// Distance between snap's progress bars.
            public var distance: CGFloat = 10.0

            /// Progress bar background opacity.
            public var opacity: CGFloat = 0.3
        }
    }

    public struct SnapConfig: MediaProtocol {
        /// Snap Progress Duration.
        public var duration: TimeInterval = 5.0
        /// Placeholder.
        public var placeholder: String?

        /// Options to specify how a image view adjusts its content when its size changes.
        public var contentMode: UIView.ContentMode = .scaleAspectFill

        /// Options to specify how a video view adjusts its content when its size changes.
        public var videoGravity: AVLayerVideoGravity = .resizeAspectFill

        /// - Warning: !!! Not used for snap image.
        public var tintColor: Colors?

        /// ImageView background color.
        public var backgroundColor: Colors = (light: .black, dark: .black)

        /// Image indicator appearance.
        public var indicator: IndicatorConfig? = IndicatorConfig(tintColor: (light: .white, dark: .white), style: .white)

        /// Magnifier appearance.
        public var magnifier = MagnifierConfig()
    }

    public struct FooterConfig {
        /// Button appearance
        public var button = Button()

        /// Gradient View color. To hide it, set `nil`
        public var gradientColor: Colors? = (light: UIColor.black.withAlphaComponent(0.3), dark: UIColor.black.withAlphaComponent(0.3))

        public struct Button {
            /// Font.
            public var font = UIFont.systemFont(ofSize: 18)

            /// Default text color.
            public var textColor: Colors = (light: .darkText, dark: .darkText)

            /// Default background color.
            public var backgroundColor: Colors = (light: .white, dark: .white)

            /// Height
            public var height: CGFloat = 44

            /// Corner radius
            public var radius: Radius = .value(cornerRadius: 6)

            /// .text Button Style Image
            public var textStyleImage: ImageConfig? = ImageConfig(image: UIImage(named: "icChevronUp", in: .EIQStory, compatibleWith: nil))
        }
    }

    public struct MagnifierConfig {
        /// Magnifier visibility
        public var isActive: Bool = true

        /// Glass radius
        public var radius: CGFloat = 70.0

        /// Scale of magnification
        public var scale: CGFloat = 2.5

        /// Shift offset of magnification view
        public var offset = CGPoint(x: 70, y: -70)
    }
}
```
</details>


Your changes are applied automatically.

# Delegate
Implement delegate methods if needed
```swift
func containerCard(
    _ containerCard: EIQStoryContainerCard,
    didSelect story: Story,
    at index: Int
)
```
> Tells the delegate that story item selected.

```swift
func previewController(
    _ controller: UIViewController,
    didShow story: Story,
    storyIndex: Int,
    snap: Snap,
    snapIndex: Int
)
```
> Tells the delegate that story or snap showed.

```swift
func previewController(
    _ controller: UIViewController,
    handleURL url: URL,
    story: Story,
    storyIndex: Int,
    snap: Snap,
    snapIndex: Int
)
```
> Tells the delegate that snap button pressed.

```swift
func previewControllerDidDismiss()
```
> Tells the delegate that preview dismissed

```swift
func previewControllerWillAppear()
```
> Tells the delegate that preview will appear
