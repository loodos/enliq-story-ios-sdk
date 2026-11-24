// swift-tools-version: 5.9
//
// EIQStory iOS SDK — v1.2.1
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
            url: "https://github.com/loodos/enliq-story-ios-sdk/releases/download/v1.2.1/EIQStory.xcframework.zip",
            checksum: "743b10dcecac32ab898713c87b62096300ff893f066495c5ef23517fa8267843"
        ),
    ]
)
