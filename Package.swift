// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "RAMLParserKit",
    platforms: [.macOS(.v13)],
    products: [
        .library(
            name: "RAMLParserKit",
            targets: ["RAMLParserKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "RAMLParserKit",
            dependencies: ["Yams"]
        ),
    ]
)
