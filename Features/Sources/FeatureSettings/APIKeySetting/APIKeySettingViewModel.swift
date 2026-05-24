import APIKeyClient
import Dependencies
import Models
import Observation

@MainActor
@Observable
public final class APIKeySettingViewModel {
    var apiKeyInput: APIKey
    private(set) var savedAPIKey: APIKey
    @ObservationIgnored private let onUpdatedKey: () -> Void
    
    var isEdited: Bool {
        apiKeyInput != savedAPIKey
    }
    
    @ObservationIgnored
    @Dependency(\.apiKeyClient) private var apiKeyClient
    
    public init(
        apiKeyInput: APIKey = .init(rawValue: ""),
        savedAPIKey: APIKey = .init(rawValue: ""),
        onUpdatedKey: @escaping () -> Void,
    ) {
        self.apiKeyInput = apiKeyInput
        self.savedAPIKey = savedAPIKey
        self.onUpdatedKey = onUpdatedKey
    }
    
    public init(
        apiKeyInput: APIKey = .init(rawValue: ""),
        onUpdatedKey: @escaping () -> Void,
    ) {
        self.apiKeyInput = apiKeyInput
        savedAPIKey = apiKeyInput
        self.onUpdatedKey = onUpdatedKey
    }
    
    func onAppear() {
        let key = apiKeyClient.getKey() ?? .init(rawValue: "")
        apiKeyInput = key
        savedAPIKey = key
    }
    
    func saveButtonTapped() {
        apiKeyClient.setKey(apiKeyInput)
        onUpdatedKey()
    }
}
