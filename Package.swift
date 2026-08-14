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
            checksum: "6fbeb6063348ddcf08b187148669e9712685c1925a2c1dec772094655d6fca6c"
        )
    ]
)
