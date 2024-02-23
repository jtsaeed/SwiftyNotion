import Foundation

@available(iOS 15.0, *)
public struct NotionAPIGateway {
    private let secretKey: String
    private let baseUrl = "https://api.notion.com/v1"
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        return decoder
    }
    
    public init(secretKey: String) {
        self.secretKey = secretKey
    }
    
    private func request(_ notionRequest: NotionRequest) async throws -> Data {
        let request = URLRequest(from: notionRequest, baseUrl: baseUrl, secretKey: secretKey)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
    
    public func retrieveDatabase(withId id: String) async throws -> NotionDatabase {
        let data = try await request(.retrieveDatabase(databaseId: id))
        let database = try decoder.decode(NotionDatabase.self, from: data)
        return database
    }
    
    public func queryDatabase(withId id: String) async throws -> [NotionPage] {
        let data = try await request(.queryDatabase(databaseId: id))
        let list = try decoder.decode(NotionPageList.self, from: data)
        return list.results
    }
    
    public func retrievePage(withId id: String) async throws -> NotionPage {
        let data = try await request(.retrievePage(pageId: id))
        let page = try decoder.decode(NotionPage.self, from: data)
        return page
    }
    
    public func retrieveBlockChildren(withId id: String) async throws -> [NotionBlock] {
        let data = try await request(.retrieveBlockChildren(blockId: id))
//        print("💼\(String(data: data, encoding: .utf8))")
        let list = try decoder.decode(NotionBlockList.self, from: data)
        return list.results
    }
}

public extension URLRequest {
    init(from notionRequest: NotionRequest, baseUrl: String, secretKey: String) {
        let url = URL(string: "\(baseUrl)\(notionRequest.endpointPath)")!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "Authorization": "Bearer \(secretKey)",
            "Notion-Version": "2021-05-13"
        ]
        request.httpMethod = notionRequest.request.rawValue.uppercased()
        self = request
    }
}
