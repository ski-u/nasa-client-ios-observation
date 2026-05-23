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
        .package(url: "https://github.com/kishikawakatsumi/KeychainAccess.git", from: "4.2.2"),
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
            name: "APIClientLive",
            dependencies: [
                "APIClient"
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
                "AstronomyPictureDetail"
            ]
        ),
        .testTarget(
            name: "AppFeatureTests",
            dependencies: ["AppFeature"]
        ),
        .target(
            name: "AstronomyPictureDetail",
            dependencies: [
                "APIClient",
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
)
