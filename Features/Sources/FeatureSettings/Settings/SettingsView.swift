import Dependencies
import SwiftUI

public struct SettingsView: View {
    @Bindable var viewModel: SettingsViewModel
    
    public init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        NavigationStack(path: $viewModel.path) {
            List {
                Section {
                    NavigationLink(value: SettingsViewModel.Destination.apiKeySetting) {
                        Label {
                            HStack {
                                Text("API Key", bundle: .module)

                                Spacer()

                                if let key = viewModel.apiKey.masked {
                                    Text(key)
                                        .foregroundStyle(Color.secondary)
                                } else {
                                    Text("None", bundle: .module)
                                        .foregroundStyle(Color.secondary)
                                }
                            }
                        } icon: {
                            Image(systemName: "key.fill")
                                .foregroundStyle(Color.yellow)
                        }
                    }
                }
            }
            .navigationTitle(Text("Settings", bundle: .module))
            .navigationDestination(for: SettingsViewModel.Destination.self) {
                switch $0 {
                case .apiKeySetting:
                    APIKeySettingView(
                        viewModel: .init(
                            onUpdatedKey: viewModel.onAppear,
                        )
                    )
                }
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
}

#Preview {
    let _ = prepareDependencies {
        $0.apiKeyClient = .inMemory(initialKey: .init(rawValue: "KEY"))
    }
    
    SettingsView(
        viewModel: .init(),
    )
}
