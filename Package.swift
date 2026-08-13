// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "WebRTC",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "WebRTC", targets: ["WebRTC"])
    ],
    targets: [
        .binaryTarget(
            name: "WebRTC",
            url: "https://github.com/liu9812111/amazon-kvs-webrtc-ndk-c/releases/download/v2.0.0/WebRTC.xcframework.zip",
            checksum: "a298728b0e4f6b28c562c9b18dec2550b2b7f949fa50e46c9a20916abf8da0aa"
        )
    ]
)
