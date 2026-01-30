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
            url: "https://github.com/developerroshan09/kmm-firebase-auth-spm/releases/download/1.0.7/KmmFirebaseAuth.xcframework.zip",
            checksum: "8f6fd9ee95189f24d90af9f7205e1b3969beee22aed6195e5910974d87cf0f1a"
        )
    ]
)