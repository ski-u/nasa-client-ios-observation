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
            name: "APIClientLive",
            targets: ["APIClientLive"],
        ),
        .library(
            name: "APIKeyClient",
            targets: ["APIKeyClient"],
        ),
        .library(
            name: "APIKeyClientLive",
            targets: ["APIKeyClientLive"],
        ),
        .library(
            name: "AppFeature",
            targets: ["AppFeature"]
        ),
        .library(
            name: "FeatureAstronomyPictureDetail",
            targets: ["FeatureAstronomyPictureDetail"],
        ),
        .library(
            name: "FeatureSettings",
            targets: ["FeatureSettings"],
        ),
        .library(
            name: "Models",
            targets: ["Models"],
        ),
        .library(
            name: "SharedKeys",
            targets: ["SharedKeys"],
        ),
        .library(
            name: "SharedUI",
            targets: ["SharedUI"],
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
        .package(url: "https://github.com/konomae/swift-local-date.git", from: "0.5.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", from: "1.12.0"),
        .package(url: "https://github.com/pointfreeco/swift-sharing.git", from: "2.8.0"),
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
            name: "APIClientLive",
            dependencies: [
                "APIClient",
                "APIKeyClientLive",
            ],
        ),
        .target(
            name: "APIKeyClient",
            dependencies: [
                "Models",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "APIKeyClientLive",
            dependencies: [
                "APIKeyClient",
                .product(name: "KeychainAccess", package: "KeychainAccess"),
            ],
        ),
        .target(
            name: "AppFeature",
            dependencies: [
                "APIClientLive",
                "FeatureAstronomyPictureDetail",
                "FeatureSettings",
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
        .target(
            name: "FeatureAstronomyPictureDetail",
            dependencies: [
                "APIClient",
                "Models",
                "SharedUI",
            ],
        ),
        .testTarget(
            name: "FeatureAstronomyPictureDetailTests",
            dependencies: ["FeatureAstronomyPictureDetail"],
        ),
        .target(
            name: "FeatureSettings",
            dependencies: [
                "APIClient",
                "APIKeyClient",
            ],
        ),
        .testTarget(
            name: "FeatureSettingsTests",
            dependencies: ["FeatureSettings"],
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
        .target(
            name: "SharedKeys",
            dependencies: [
                "Models",
                .product(name: "Sharing", package: "swift-sharing"),
            ],
        ),
        .target(
            name: "SharedUI",
            dependencies: [],
        ),
    ],
)
