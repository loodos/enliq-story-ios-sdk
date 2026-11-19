// swift-tools-version: 5.9
//
// EIQStory iOS SDK — v1.2.0
// Bu dosya otomatik üretilir; elle düzenlemeyin.

import PackageDescription

let package = Package(
    name: "EIQStory",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "EIQStory", targets: ["EIQStory"]),
    ],
    targets: [
        .binaryTarget(
            name: "EIQStory",
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/v1.2.0/EIQStory.xcframework.zip",
            checksum: "a383427432b1f10e1b8d91add05734d6e1a2b5deeaf823c5465ef5794306ee15"
        ),
    ]
)
