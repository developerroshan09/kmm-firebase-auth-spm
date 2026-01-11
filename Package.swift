// swift-tools-version:6.2
import  PackageDescription

let package = Package(
    name: "KmmFirebaseAuth",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "KmmFirebaseAuth",
            targets: ["KmmFirebaseAuth"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "KmmFirebaseAuth",
            url: "https://github.com/developerroshan09/xcframework_dist_spm/releases/download/1.0.0/ComposeApp.xcframework.zip",
            checksum: "7d7440e4242b56e0189a02365c268bc0c81f206e496a305e60ded9374f1e6595"
        )
    ]
)