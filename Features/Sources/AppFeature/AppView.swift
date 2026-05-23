import APIClientLive
import AstronomyPictureDetail
import Dependencies
import SwiftUI

public struct AppView: View {
    public init() {}
    
    public var body: some View {
        NavigationStack {
            AstronomyPictureDetailView(
                viewModel: withDependencies {
                    $0.apiClient = .liveValue
                } operation: {
                    AstronomyPictureDetailViewModel(
                        date: .init(),
                    )
                }
            )
        }
    }
}
