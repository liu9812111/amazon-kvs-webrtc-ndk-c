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
            url: "https://github.com/liu9812111/amazon-kvs-webrtc-ndk-c/releases/download/v1.0.0/WebRTC.xcframework.zip",
            checksum: "013b465aa650e62c50cb11f79d05e98226e56416bc4ed910cae29c9145bfb502"
        )
    ]
)
