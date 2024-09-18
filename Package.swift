// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Panic",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "Panic",
            targets: [
                "Panic"
            ]
        ),
        .library(
            name: "Example",
            targets: [
                "Example"
            ]
        ),
    ],
    targets: [
        .target(
            name: "Panic"
        ),
        .target(
            name: "Example",
            dependencies: [
                "Panic"
            ]
        ),
    ]
)
