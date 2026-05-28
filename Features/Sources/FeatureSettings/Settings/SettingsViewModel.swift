import APIKeyClient
import Dependencies
import Models
import Observation
import SharedKeys
import Sharing

@MainActor
@Observable
public final class SettingsViewModel {
    public enum Destination {
        case apiKeySetting
        case appearanceSetting
        case licenseList
    }
    
    var apiKey: APIKey
    var path: [Destination]
    
    @ObservationIgnored
    @Shared(.colorSchme) var userColorScheme = UserColorScheme.system
    
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
