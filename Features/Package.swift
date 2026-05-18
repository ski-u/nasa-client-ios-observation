// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AstronomyPictureDetail",
            targets: ["AstronomyPictureDetail"],
        ),
        .library(
            name: "Features",
            targets: ["Features"]
        ),
        .library(
            name: "Models",
            targets: ["Models"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/konomae/swift-local-date.git", from: "0.5.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AstronomyPictureDetail",
            dependencies: [
                "Models",
            ],
        ),
        .testTarget(
            name: "AstronomyPictureDetailTests",
            dependencies: ["AstronomyPictureDetail"],
        ),
        .target(
            name: "Features"
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: ["Features"]
        ),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "LocalDate", package: "swift-local-date")
            ],
        ),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"],
        ),
    ],
    swiftLanguageModes: [.v6]
)
