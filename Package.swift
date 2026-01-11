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
            url: "https://github.com/developerroshan09/xcframework_dist_spm/releases/download/1.0.1/ComposeApp.xcframework.zip",
            checksum: "412ad1ab7d2f2c75b968cc06b6c8bfdde313c221b983f649dc5f9b2c95971c53"
        )
    ]
)