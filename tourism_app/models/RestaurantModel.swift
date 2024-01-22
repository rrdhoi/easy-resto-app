import Foundation

struct RestaurantResponse : Decodable {
    let error: Bool
    let message: String
    let restaurants : [RestaurantModel]
}

struct RestaurantModel : Decodable {
    let id: String
    let name: String
    let description: String
    let pictureId: String
    let city: String
    let rating: Double
}
