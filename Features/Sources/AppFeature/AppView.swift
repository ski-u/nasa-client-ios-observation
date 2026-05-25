import APIClientLive
import Dependencies
import FeatureAstronomyPictureDetail
import FeatureSettings
import LocalDate
import SwiftUI

public struct AppView: View {
    @Bindable var viewModel: AppViewModel
    
    public init(
        viewModel: AppViewModel = .init(
            astronomyPictureDetailViewModel: .init(date: .init()),
            settingsViewModel: .init(),
        ),
    ) {
        self.viewModel = viewModel
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
            
            SettingsView(
                viewModel: viewModel.settingsViewModel,
            )
            .tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings", bundle: .module)
                }
            }
        }
    }
}
