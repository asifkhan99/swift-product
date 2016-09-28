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
    }
}
