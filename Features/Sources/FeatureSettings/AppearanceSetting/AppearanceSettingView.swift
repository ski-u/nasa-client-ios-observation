import Models
import SharedKeys
import Sharing
import SwiftUI

struct AppearanceSettingView: View {
    @Shared(.colorSchme) private var userColorScheme = UserColorScheme.system
    
    var body: some View {
        Form {
            Button {
                $userColorScheme.withLock {
                    $0 = .light
                }
            } label: {
                HStack {
                    Text("Light", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .light {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button {
                $userColorScheme.withLock {
                    $0 = .dark
                }
            } label: {
                HStack {
                    Text("Dark", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .dark {
                        Image(systemName: "checkmark")
                    }
                }
            }
            
            Button {
                $userColorScheme.withLock {
                    $0 = .system
                }
            } label: {
                HStack {
                    Text("Automatic", bundle: .module)
                        .foregroundStyle(Color.primary)
                    
                    Spacer()
                    
                    if userColorScheme == .system {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
        .navigationTitle(Text("Appearance", bundle: .module))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AppearanceSettingView()
    }
}
