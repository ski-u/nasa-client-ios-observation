// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "APIClient",
            targets: ["APIClient"],
        ),
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        ),
        .library(
            name: "AstronomyPictureDetail",
            targets: ["AstronomyPictureDetail"],
        ),
        .library(
            name: "Models",
            targets: ["Models"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/konomae/swift-local-date.git", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.12.0"),
    ],
    targets: [
        .target(
            name: "APIClient",
            dependencies: [
                "Models",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
                .product(name: "LocalDate", package: "swift-local-date"),
            ]
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "AstronomyPictureDetail",
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
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
