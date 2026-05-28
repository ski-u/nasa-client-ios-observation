import Dependencies
import Observation
import SwiftUI

struct APIKeySettingView: View {
    @State private var viewModel: APIKeySettingViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: APIKeySettingViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        Form {
            Section(footer: link) {
                TextField(
                    String(localized: "Set your API Key", bundle: .module),
                    text: $viewModel.apiKeyInput.rawValue,
                )
                .textFieldStyle(.plain)
            }
        }
        .navigationTitle(Text("API key", bundle: .module))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    viewModel.saveButtonTapped()
                    dismiss()
                } label: {
                    Text("Save", bundle: .module)
                }
                .disabled(!viewModel.isEdited)
            }
        }
        .onAppear(perform: viewModel.onAppear)
    }
    
    private var link: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(
                "You can generate your API key on [NASA Open APIs](https://api.nasa.gov)",
                bundle: .module,
            )
            .font(.caption)
        }
    }
}

#Preview {
    let _ = prepareDependencies {
        $0.apiKeyClient = .inMemory(initialKey: .init(rawValue: "KEY"))
    }
    
    NavigationStack {
        APIKeySettingView(
            viewModel: .init(
                onUpdatedKey: {},
            )
        )
    }
}
