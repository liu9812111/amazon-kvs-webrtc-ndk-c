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
            checksum: "01a527f61a5bee84c92453d0889a9a55601347416e4290c9a1325adb05d4eab0"
        )
    ]
)
