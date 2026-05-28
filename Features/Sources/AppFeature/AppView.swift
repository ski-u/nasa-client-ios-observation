import APIClientLive
import Dependencies
import FeatureAstronomyPictureDetail
import FeatureSettings
import LocalDate
import Models
import SharedKeys
import Sharing
import SwiftUI

public struct AppView: View {
    @State private var viewModel: AppViewModel
    
    @Shared(.colorSchme) private var userColorScheme = UserColorScheme.system
    
    public init(
        viewModel: AppViewModel = .init(
            astronomyPictureDetailViewModel: .init(date: .init()),
            settingsViewModel: .init(),
        ),
    ) {
        _viewModel = State(initialValue: viewModel)
    }
    
    public var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            NavigationStack {
                AstronomyPictureDetailView(
                    viewModel: viewModel.astronomyPictureDetailViewModel,
                )
            }
            .tabItem {
                VStack {
                    Image(systemName: "moon.stars")
                    Text("Today", bundle: .module)
                }
            }
            .tag(AppViewModel.Tab.astronomyPicture)
            
            SettingsView(
                viewModel: viewModel.settingsViewModel,
            )
            .tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings", bundle: .module)
                }
            }
            .tag(AppViewModel.Tab.settings)
        }
        .preferredColorScheme(userColorScheme.colorScheme)
    }
}
