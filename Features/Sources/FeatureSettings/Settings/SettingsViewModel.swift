import APIKeyClient
import Dependencies
import Models
import Observation

@MainActor
@Observable
public final class SettingsViewModel {
    var apiKey: APIKey
    
    @ObservationIgnored
    @Dependency(\.apiKeyClient) private var apiKeyClient
    
    public init(
        apiKey: APIKey = .init(rawValue: ""),
    ) {
        self.apiKey = apiKey
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
