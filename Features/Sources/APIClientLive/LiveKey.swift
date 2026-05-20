import APIClient
import Dependencies
import Foundation
import LocalDate
import Models

extension APIClient: DependencyKey {
    private static let baseURL = URL(string: "https://api.nasa.gov")!
    
    public static var liveValue: Self {
        .init(
            fetchAstronomyPictures: {
                let payload: AstronomyPicture.Payload = try await fetch(
                    path: "/planetary/apod",
                    queryItems: [
                        URLQueryItem(
                            name: "date",
                            value: $0.description,
                        ),
                    ],
                )
                return AstronomyPicture(payload: payload)
            }
        )
    }
    
    private static func fetch<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem] = [],
    ) async throws -> T {
        var urlComponents = URLComponents(
            url: baseURL,
            resolvingAgainstBaseURL: false,
        )!
        urlComponents.path = path
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: "")
        ] + queryItems
        
        let (data, response) = try await URLSession.shared.data(from: urlComponents.url!)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NASAClientError.unexpectedResponse
        }
        let statusCode = httpResponse.statusCode
        
        guard (200..<300).contains(statusCode) else {
            let errorMessage = (
                try? JSONDecoder().decode(NASAErrorResponse.self, from: data)
            )
            .flatMap {
                $0.error?.message ?? $0.msg
            }
            throw NASAClientError.httpError(statusCode: statusCode, message: errorMessage)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
