import Foundation

struct ServiceResponse: Decodable {
    let characters: [Character]

    enum CodingKeys: String, CodingKey {
        case characters = "RelatedTopics"
    }
}
struct Character: Decodable {
    let name: String?
    let icon: CharacterIcon
    let result: String?
    let text: String?

    enum CodingKeys: String, CodingKey {
        case name = "FirstURL"
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}
struct CharacterIcon: Decodable {
    let height: String?
    let url: String?
    let width: String?

    enum CodingKeys: String, CodingKey {
        case height = "Height"
        case url = "URL"
        case width = "Width"
    }
}
