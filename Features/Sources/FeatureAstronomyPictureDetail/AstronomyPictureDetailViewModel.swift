import APIClient
import Dependencies
import LocalDate
import Models
import Observation

@MainActor
@Observable
public final class AstronomyPictureDetailViewModel {
    let date: LocalDate
    var errorMessage: String?
    var picture: AstronomyPicture?
    
    @ObservationIgnored
    private var fetchTask: Task<Void, Never>?
    
    @ObservationIgnored
    @Dependency(\.apiClient) private var apiClient
    
    public init(
        date: LocalDate,
        errorMessage: String? = nil,
        picture: AstronomyPicture? = nil,
    ) {
        self.date = date
        self.errorMessage = errorMessage
        self.picture = picture
    }
    
    func onAppear() {
        if picture != nil {
            return
        }
        
        fetchAstronomyPicture(date: date)
    }
    
    private func fetchAstronomyPicture(date: LocalDate) {
        fetchTask?.cancel()
        
        errorMessage = nil
        picture = nil
        
        fetchTask = Task {
            do {
                picture = try await apiClient.fetchAstronomyPictures(date: date)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
    }
}
