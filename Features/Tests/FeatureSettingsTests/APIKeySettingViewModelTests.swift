import APIKeyClient
import Dependencies
@testable import FeatureSettings
import Testing

@MainActor
struct APIKeySettingViewModelTests {
    @Test
    func isEdited() {
        let viewModel = APIKeySettingViewModel(
            apiKeyInput: .init(rawValue: ""),
            onUpdatedKey: {},
        )
        #expect(!viewModel.isEdited)
        
        viewModel.apiKeyInput = .init(rawValue: "UPDATED")
        #expect(viewModel.isEdited)
    }
    
    @Test
    func onAppear() {
        let client = APIKeyClient.inMemory(initialKey: .init(rawValue: "KEY"))
        
        let viewModel = withDependencies {
            $0.apiKeyClient = client
        } operation: {
            APIKeySettingViewModel(
                apiKeyInput: .init(rawValue: ""),
                onUpdatedKey: {},
            )
        }
        
        viewModel.onAppear()
        #expect(viewModel.apiKeyInput == .init(rawValue: "KEY"))
        #expect(viewModel.savedAPIKey == .init(rawValue: "KEY"))
    }
    
    @Test
    func saveButtonTapped() {
        var called = 0
        
        let client = APIKeyClient.inMemory(initialKey: nil)
        
        let viewModel = withDependencies {
            $0.apiKeyClient = client
        } operation: {
            APIKeySettingViewModel(
                apiKeyInput: .init(rawValue: "NEW_KEY"),
                onUpdatedKey: { called += 1 },
            )
        }
        
        viewModel.saveButtonTapped()
        #expect(called == 1)
        #expect(client.getKey() == .init(rawValue: ("NEW_KEY")))
    }
}
