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
            url: "https://github.com/liu9812111/amazon-kvs-webrtc-ndk-c/releases/download/v3.0.0/WebRTC.xcframework.zip",
            checksum: "9a9e8875dd146071dc06f8ae362d305d1bfab606a90152d33eb4c3bf9f1324df"
        )
    ]
)
