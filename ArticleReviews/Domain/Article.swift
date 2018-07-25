

struct Article: Codable {
    let embedded: EmbeddedDetails
    
    enum CodingKeys : String, CodingKey {
        case embedded = "_embedded"
    }
    
    struct EmbeddedDetails: Codable {
        let articles: [ArticlesDetails]
    }
    
    struct ArticlesDetails: Codable {
        let sku: String
        let title: String
        let media: [MediaDetails]
    }
    
    struct MediaDetails: Codable {
        let uri: String
    }
}
