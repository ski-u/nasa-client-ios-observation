import APIKeyClient
import Dependencies
@testable import FeatureSettings
import Testing

@MainActor
struct SettingsViewModelTests {
    @Test
    func onAppear() {
        let viewModel = withDependencies {
            $0.apiKeyClient = .inMemory(initialKey: nil)
        } operation: {
            SettingsViewModel()
        }
        
        viewModel.onAppear()
        #expect(viewModel.apiKey == .init(rawValue: ""))
    }
    
    @Test
    func onUpdatedAPIKey() {
        let viewModel = withDependencies {
            $0.apiKeyClient = .inMemory(initialKey: .init(rawValue: "UPDATED_KEY"))
        } operation: {
            SettingsViewModel(apiKey: .init(rawValue: "KEY"))
        }
        
        viewModel.onUpdatedAPIKey()
        #expect(viewModel.apiKey == .init(rawValue: "UPDATED_KEY"))
    }
}
