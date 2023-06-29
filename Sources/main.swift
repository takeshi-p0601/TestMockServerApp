import OpenAPIRuntime
import OpenAPIVapor
import Vapor

struct Handler: APIProtocol {
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
