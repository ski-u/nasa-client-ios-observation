import FeatureAstronomyPictureDetail
import FeatureSettings
import Observation

@MainActor
@Observable
public final class AppViewModel {
    public enum Tab: Hashable {
        case astronomyPicture
        case settings
    }
    
    let astronomyPictureDetailViewModel: AstronomyPictureDetailViewModel
    var selectedTab: Tab
    let settingsViewModel: SettingsViewModel
    
    public init(
        astronomyPictureDetailViewModel: AstronomyPictureDetailViewModel,
        selectedTab: Tab = .astronomyPicture,
        settingsViewModel: SettingsViewModel
    ) {
        self.astronomyPictureDetailViewModel = astronomyPictureDetailViewModel
        self.selectedTab = selectedTab
        self.settingsViewModel = settingsViewModel
    }
}
