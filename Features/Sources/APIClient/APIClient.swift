import Dependencies
import DependenciesMacros
import LocalDate
import Models

@DependencyClient
public struct APIClient: Sendable {
    public var fetchAstronomyPictures: @Sendable (_ date: LocalDate) async throws -> AstronomyPicture
}

extension APIClient: TestDependencyKey {
    public static let testValue = Self()
}

public extension DependencyValues {
    var apiClient: APIClient {
        get { self[APIClient.self] }
        set { self[APIClient.self] = newValue }
    }
}
