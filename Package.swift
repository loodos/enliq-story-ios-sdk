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
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/v1.1.1/eiqstory.xcframework.zip",
            checksum: "5ede652e1e786902f60810dac6fb76015be2cb0626a82f236dd1e0b446b20f52"
        )
    ]
)
