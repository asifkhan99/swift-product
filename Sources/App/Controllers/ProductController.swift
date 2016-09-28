import HTTP
import Vapor

final class ProductController: ResourceRepresentable {
    func index(request: Request) throws -> ResponseRepresentable {
        return try Product.all().makeNode().converted(to: JSON.self)
    }

    func create(request: Request) throws -> ResponseRepresentable {
        var Product = try request.Product()
        try Product.save()
        return Product
    }

    func show(request: Request, Product: Product) throws -> ResponseRepresentable {
        return Product
    }

    func delete(request: Request, Product: Product) throws -> ResponseRepresentable {
        try Product.delete()
        return JSON([:])
    }

    func clear(request: Request) throws -> ResponseRepresentable {
        try Product.deleteAll()
        return JSON([])
    }

    func update(request: Request, Product: Product) throws -> ResponseRepresentable {
        let new = try request.Product()
        var Product = Product
        Product.merge(updates: new)
        try Product.save()
        return Product
    }

    func replace(request: Request, Product: Product) throws -> ResponseRepresentable {
        try Product.delete()
        return try create(request: request)
    }

    func makeResource() -> Resource<Product> {
        return Resource(
            index: index,
            store: create,
            show: show,
            replace: replace,
            modify: update,
            destroy: delete,
            clear: clear
        )
    }
}

extension Request {
    func Product() throws -> Product {
        guard let json = json else { throw Abort.badRequest }
        return try Product(node: json)
    //  return try Product()
    }
}
