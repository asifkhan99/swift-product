<<<<<<< HEAD
import Fluent

final class Product: Entity {
    var id: Fluent.Node?
    var name: String
    var email: String

    init(id: Node?, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }

    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "email": email
        ])
    }

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        email = try node.extract("email")
    }

    static func prepare(_ database: Fluent.Database) throws {
        try database.create(entity) { builder in
            builder.id()
            builder.string("name")
            builder.string("email")
        }
    }
    static func revert(_ database: Fluent.Database) throws {
        try database.delete(entity)
=======
import Vapor
import Fluent

// MARK: Model

struct Product: Model {
    var id: Node?

    var name: String?
    var code: String?
    var image: String?

    // used by fluent internally
    var exists: Bool = false
}

// MARK: NodeConvertible

extension Product: NodeConvertible {
    init(node: Node, in context: Context) throws {
        id = node["id"]
        name = node["name"]?.string
        code = node["code"]?.string
        image = node["image"]?.string
    }

    func makeNode(context: Context) throws -> Node {
        // model won't always have value to allow proper merges,
        // database defaults to false
        return try Node.init(node:
            [
                "id": id,
                "name": name,
                "code": code,
                "image": image
            ]
        )
    }
}

// MARK: Database Preparations

extension Product: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create("products") { users in
            users.id()
            users.string("name", optional: true)
            users.string("code")
            users.string("image", optional: true)
        }
    }

    static func revert(_ database: Database) throws {
        fatalError("unimplemented \(#function)")
    }
}

// MARK: Merge

extension Product {
    mutating func merge(updates: Product) {
        id = updates.id ?? id
        code = updates.code ?? code
        name = updates.name ?? name
        image = updates.image ?? image
>>>>>>> 772ef2a018d8fd83ffae6b9e8716937a55474a33
    }
}
