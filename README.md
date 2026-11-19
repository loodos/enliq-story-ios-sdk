<p align="center">
  <img src="https://i.ibb.co/zh0Lrz6J/test.png" alt="Enliq" width="320"/>
</p>

<h1 align="center">EIQStory iOS SDK</h1>

<p align="center">
  <a href="https://github.com/loodos/enliq-story-ios-sdk/releases/latest"><img src="https://img.shields.io/github/v/release/loodos/enliq-story-ios-sdk?label=release&sort=semver" alt="Latest release"/></a>
  <img src="https://img.shields.io/badge/platform-iOS%2015.0%2B-blue.svg" alt="Platform iOS 15.0+"/>
  <a href="https://swift.org/package-manager"><img src="https://img.shields.io/badge/SPM-compatible-brightgreen.svg" alt="Swift Package Manager compatible"/></a>
  <img src="https://img.shields.io/badge/distribution-XCFramework-lightgrey.svg" alt="Binary XCFramework"/>
</p>

<p align="center">
  Instagram-style stories with images, videos, countdowns and call-to-action buttons<br/>
  for iOS apps powered by the <a href="https://www.enliq.com">Enliq</a> customer engagement platform.
</p>

<p align="center">
  <a href="https://developer.enliq.com"><b>Developer Docs</b></a> ·
  <a href="https://github.com/loodos/enliq-story-ios-sdk/releases"><b>Releases</b></a> ·
  <a href="#support"><b>Support</b></a>
</p>

---

## Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Opening a Story from a Deep Link](#opening-a-story-from-a-deep-link)
- [Appearance](#appearance)
- [Delegate](#delegate)
- [Manager API](#manager-api)
- [Migrating to 1.2](#migrating-to-12)
- [Support](#support)

## Requirements

| | Minimum |
|---|---|
| iOS | 15.0 |
| Xcode | 16.0 |
| Swift | 5.9 |

The SDK is distributed as a precompiled **binary XCFramework** built with library evolution, so it works with any newer Swift compiler. Its image loading dependency is embedded, so there are **no third-party dependencies** to resolve in your project.

## Installation

### Swift Package Manager

**Xcode:** `File` → `Add Package Dependencies…` → enter the URL below → choose **Up to Next Major Version**.

```
https://github.com/loodos/enliq-story-ios-sdk
```

Add the `EIQStory` library to your app target.

**Package.swift:**

```swift
dependencies: [
    .package(url: "https://github.com/loodos/enliq-story-ios-sdk.git", .upToNextMajor(from: "1.2.0"))
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "EIQStory", package: "enliq-story-ios-sdk")
        ]
    )
]
```

## Quick Start

### 1. Add the story list view

`EIQStoryContainerCard` is the horizontal story list. Create it in code:

```swift
import EIQStory

let storyView = EIQStoryContainerCard()
storyView.translatesAutoresizingMaskIntoConstraints = false
containerView.addSubview(storyView)

let height = storyView.heightAnchor.constraint(equalToConstant: 110)
height.priority = .defaultLow

NSLayoutConstraint.activate([
    storyView.topAnchor.constraint(equalTo: containerView.topAnchor),
    storyView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
    storyView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
    storyView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
    height
])
```

…or in Interface Builder: add a `UIView`, set its class to `EIQStoryContainerCard` and module to `EIQStory`, then connect an outlet.

### 2. Initialize the manager

```swift
final class HomeViewController: UIViewController, EIQStoryManagerDelegate {
    @IBOutlet private weak var storyView: EIQStoryContainerCard!

    override func viewDidLoad() {
        super.viewDidLoad()
        EIQStoryManager.initialize(containerCard: storyView, delegate: self)

        var appearance = EIQStoryManager.shared.appearance
        appearance.theme = .adaptive
        appearance.list.item.listType = .circular
        EIQStoryManager.shared.appearance = appearance
    }
}
```

### 3. Provide stories

```swift
let stories: [Story] = try JSONDecoder().decode([Story].self, from: data) // from your backend / CMS
storyView.viewModel = StoryViewModel(stories: stories)
```

## Opening a Story from a Deep Link

After the manager is initialized, open a story by its index in the list:

```swift
EIQStoryManager.shared.openStory(at: index)
```

## Appearance

Almost every visual aspect is configurable through `EIQStoryAppearance`. Read the current value, change it and assign it back; changes are applied immediately.

```swift
var appearance = EIQStoryManager.shared.appearance

// Theme: .light, .dark or .adaptive (follows the system)
appearance.theme = .adaptive

// Story list
appearance.list.item.listType = .rectangle          // .circular, .rectangle, .embeddedTitle
appearance.list.item.size = CGSize(width: 80, height: 80)
appearance.list.border.unseenColor = (light: .systemRed, dark: .systemPink)
appearance.list.title.font = .systemFont(ofSize: 12, weight: .medium)

// Story viewer
appearance.preview.snap.duration = 6
appearance.preview.header.progressBar.tintColor = (light: .white, dark: .white)
appearance.preview.footer.button.backgroundColor = (light: .white, dark: .black)

EIQStoryManager.shared.appearance = appearance
```

Colors are given as `Colors` tuples (`(light: UIColor, dark: UIColor)`) so both themes can be styled.

| Group | Configures |
|---|---|
| `list.item` | List type, item size, insets, spacing |
| `list.border` | Seen / unseen ring color, width, radius |
| `list.image` | Thumbnail placeholder, margin, radius, gradient |
| `list.title`, `list.seenTitle` | Title label for unseen / seen stories |
| `list.countdown`, `list.featured` | Countdown badge and featured icon |
| `preview.header` | Progress bar, close button, title, featured / countdown icons |
| `preview.snap` | Snap duration, content mode, video gravity, magnifier |
| `preview.footer` | Call-to-action button |

## Delegate

`EIQStoryManagerDelegate` reports user interaction:

```swift
extension HomeViewController: EIQStoryManagerDelegate {
    func containerCard(_ containerCard: EIQStoryContainerCard, didSelect story: Story, at index: Int) {
        // A story in the list was tapped
    }

    func previewController(_ controller: UIViewController, didShow story: Story, storyIndex: Int, snap: Snap, snapIndex: Int) {
        // A snap became visible (e.g. for analytics)
    }

    func previewController(_ controller: UIViewController, handleURL url: URL, story: Story, storyIndex: Int, snap: Snap, snapIndex: Int) {
        // The snap's call-to-action button was tapped; route to `url`
    }

    func previewControllerWillAppear() {}

    func previewControllerDidDismiss() {}
}
```

## Manager API

| Method | Description |
|---|---|
| `EIQStoryManager.initialize(containerCard:delegate:)` | Connects the list view and the delegate. |
| `openStory(at:)` | Opens the story viewer at the given index. |
| `refreshStoryList()` | Reloads the list. Called automatically while `isAutoRefreshEnabled` is `true`. |
| `pauseProgress()` / `resumeProgress()` | Pauses / resumes the current snap (e.g. while presenting a sheet). |
| `clearCache()` | Clears the SDK's image cache. |

## Migrating to 1.2

- Minimum deployment target is now **iOS 15.0**.
- Install from this repository (`enliq-story-ios-sdk`) with Swift Package Manager. No access token is needed; CocoaPods is no longer supported.
- The SDK no longer adds Kingfisher to your project. If your app uses Kingfisher directly, add it as your own dependency.
- If you previously used the SDK from source, run **Product → Clean Build Folder** (or delete DerivedData) once after switching.

## Support

- **Integration guides & changelog:** [developer.enliq.com](https://developer.enliq.com)
- **Bug reports:** [GitHub Issues](https://github.com/loodos/enliq-story-ios-sdk/issues)
- **Account & panel questions:** contact your Enliq account manager.

---

<p align="center">© Enliq. All rights reserved.</p>
