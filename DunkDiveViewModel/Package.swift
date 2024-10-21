// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DunkDiveViewModel",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DunkDiveViewModel",
            targets: ["DunkDiveViewModel"]),
    ],
    dependencies: [
        .package(path: "../DunkDiveModel"),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", from: "0.15.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DunkDiveViewModel",
            dependencies: ["DunkDiveModel",
                .product(name: "SQLite", package: "SQLite.swift")
            ]),
        .testTarget(
            name: "DunkDiveViewModelTests",
            dependencies: ["DunkDiveViewModel"]),
    ]
)
