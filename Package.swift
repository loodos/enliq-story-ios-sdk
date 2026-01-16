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
            checksum: "ae222135a82ed6ec476506524e2a861ba4c9417b6f56bb6ff619e8131c9ceeb0"
        )
    ]
)
