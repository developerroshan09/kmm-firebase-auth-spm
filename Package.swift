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
            url: "https://github.com/developerroshan09/xcframework_dist_spm/releases/download/1.0.2/ComposeApp.xcframework.zip",
            checksum: "29cc1fb117548ebda13b4feafebca69c6a21cfcc7fd9e9cbc8509e38f9a309d4"
        )
    ]
)