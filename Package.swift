// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "EIQStory",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "EIQStory",
            targets: ["EIQStory"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: "7.12.0")
    ],
    targets: [
        .target(
            name: "EIQStory",
            dependencies: [
                .target(name: "EnliqStory"),
                .product(name: "Kingfisher", package: "Kingfisher")
            ],
            path: "Sources"
        ),
        .binaryTarget(
            name: "EnliqStory",
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/1.0.0/eiqstory.xcframework.zip",
            checksum: "5e25d1215bb47eac8bc7aed4a485d15aad8f35b6efeedfc1f475b7d46207decf"
        )
    ]
)
