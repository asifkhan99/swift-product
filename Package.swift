import PackageDescription

let package = Package(
    name: "VaporApp",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1),
        .Package(url: "https://github.com/vapor/mysql-provider.git", majorVersion: 1)
    ],
    exclude: [
        "Config",
<<<<<<< HEAD
        "Database",
        "Localization",
        "Public",
        "Resources",
        "Tests",
=======
        "Deploy",
        "Public",
        "Resources",
        "Tests",
        "Database"
>>>>>>> 772ef2a018d8fd83ffae6b9e8716937a55474a33
    ]
)
