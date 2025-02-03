import Foundation

enum MyGoogleBooks {
    // A response for a Google Search request.
    struct SearchResponse: Codable, Sendable {
        var items: [Item]
    }
    
    // An individual item in a Google Books search.
    struct Item: Codable, Sendable {
        public var id: String
        public var volumeInfo: VolumeInfo
    }
    
    // Valid industry identifiers.
    enum IndustryIdentifierType: String, Codable, Sendable {
        case isbn10 = "ISBN_10"
        case isbn13 = "ISBN_13"
        case issn = "ISSN"
        case other = "OTHER"
    }
    
    // An industry identifier for a book.
    struct IndustryIdentifier: Codable, Sendable {
        public var type: IndustryIdentifierType
        public var identifier: String
    }
    
    // The book itself.
    struct VolumeInfo: Codable, Sendable {
        public var title: String?
        public var subtitle: String?
        public var authors: [String]?
        public var publishedDate: String?
        public var imageLinks: ImageLink?
        public var industryIdentifiers: [IndustryIdentifier]?
        public var pageCount: Int?
        public var publisher: String?
        public var mainCategory: String?
        public var categories: [String]?
        public var description: String?
    }
    
    // A book cover image.
    struct ImageLink: Codable, Sendable {
        public var smallThumbnail: String?
        public var thumbnail: String?
    }
    
    // Request for a book.
    static func search(for searchTerm: String) async throws -> SearchResponse {
        // Ensure the base URL is valid
        guard let baseURL = URL(string: "https://www.googleapis.com/books/v1/volumes") else {
            throw URLError(.badURL)
        }
        
        // Configure URL components
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "q", value: searchTerm)
        ]

        // Construct the final URL
        guard let url = urlComponents?.url else {
            throw URLError(.badURL)
        }

        // Perform the network request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Validate the response
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        // Decode the response data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            return try decoder.decode(SearchResponse.self, from: data)
        } catch {
            throw URLError(.cannotDecodeRawData)
        }
    }
}
