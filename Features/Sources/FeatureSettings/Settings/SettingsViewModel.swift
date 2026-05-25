import APIKeyClient
import Dependencies
import Models
import Observation

@MainActor
@Observable
public final class SettingsViewModel {
    public enum Destination {
        case apiKeySetting
    }
    
    var apiKey: APIKey
    var path: [Destination]
    
    @ObservationIgnored
    @Dependency(\.apiKeyClient) private var apiKeyClient
    
    public init(
        apiKey: APIKey = .init(rawValue: ""),
        path: [Destination] = [],
    ) {
        self.apiKey = apiKey
        self.path = path
    }
    
    func onAppear() {
        getAPIKey()
    }
    
    func onUpdatedAPIKey() {
        getAPIKey()
    }
    
    private func getAPIKey() {
        apiKey = apiKeyClient.getKey() ?? .init(rawValue: "")
    }
}
