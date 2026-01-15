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
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/1.1.1/eiqstory.xcframework.zip",
            checksum: "458b0702b2c97dc7155ffe81af1a228bc549b471ef29c9e5f91ba14e427e16d3"
        )
    ]
)
