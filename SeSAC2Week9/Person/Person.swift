import Foundation

struct Person: Codable {
    let page, totalPages, totalResults: Int
    let results: [Result]
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Result: Codable {
    let knownForDepartment, name: String
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
    }
}
