// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let regionModel = try? newJSONDecoder().decode(RegionModel.self, from: jsonData)

import Foundation

// MARK: - RegionModel
class RegionModel: Codable {
    let count: Int
    let next, previous: JSONNull?
    let results: [Result]
    
    init(count: Int, next: JSONNull?, previous: JSONNull?, results: [Result]) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

// MARK: - Result
class Result: Codable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public func hash(into hasher: inout Hasher) {
        // No-op
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
