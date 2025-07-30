import Foundation

struct ID<T>: Equatable {
    private let value = UUID()
}

struct Person {
    let id = ID<Self>()
    let name: String
}

struct Location {
    let id = ID<Self>()
    let coordinates: (Double, Double)
}

func handle(locations: [Location]) {
    let me = Location(coordinates: (4,
                                     2))
    let filtered = locations.filter({ $0.id == me.id })
}
