// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EIQStory",
    defaultLocalization: "tr",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "EIQStory",
            targets: ["EIQStory", "EIQStorySources"])
    ],
    dependencies: [
        .package(
            url: "https://github.com/onevcat/Kingfisher.git",
            .upToNextMajor(from: "7.0.0")
        )
    ],
    targets: [
        .target(
            name: "EIQStorySources",
            dependencies: [
                "Kingfisher"
            ],
            path: "Sources"
        ),
        .binaryTarget(
            name: "EIQStory",
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/1.0.0/eiqstory.xcframework.zip",
            checksum: "a753655cca2e6724988e062b15064d63b546d0157bc561cf411fa1b5c186b326"
        )
    ]
)
