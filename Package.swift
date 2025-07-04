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
            checksum: "5e25d1215bb47eac8bc7aed4a485d15aad8f35b6efeedfc1f475b7d46207decf"
        )
    ]
)
