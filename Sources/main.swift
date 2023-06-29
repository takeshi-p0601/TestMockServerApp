import OpenAPIRuntime
import OpenAPIVapor
import Vapor
import Foundation

struct Handler: APIProtocol {
    func getImage(_ input: Operations.getImage.Input) async throws -> Operations.getImage.Output {
        let imageResourceURL = Bundle.module.url(forResource: "test", withExtension: "png")!
        let imageData = try Data(contentsOf: imageResourceURL)
        return .ok(Operations.getImage.Output.Ok(body: .binary(imageData)))
    }
    
    func getGreeting(
        _ input: Operations.getGreeting.Input
    ) async throws -> Operations.getGreeting.Output {
        let name = input.query.name ?? "Stranger"
        return .ok(.init(body: .json(.init(message: "Hello, \(name)!"))))
    }
}

let app = Vapor.Application()
let transport = VaporTransport(routesBuilder: app)
let handler = Handler()
try handler.registerHandlers(on: transport, serverURL: Servers.server1())
try app.run()
