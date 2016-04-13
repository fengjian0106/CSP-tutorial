import PackageDescription

let package = Package(
    name: "CSP-tutorial",
    dependencies: [
        .Package(url: "https://github.com/VeniceX/Venice.git", majorVersion: 0, minor: 4)
    ]
)
