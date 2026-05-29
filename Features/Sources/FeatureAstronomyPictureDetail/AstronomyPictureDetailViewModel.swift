import APIClient
import Dependencies
import Foundation
import LocalDate
import Models
import Observation

@MainActor
@Observable
public final class AstronomyPictureDetailViewModel {
    var date: LocalDate
    var errorMessage: String?
    var isCalendarPresented: Bool
    var picture: AstronomyPicture?
    
    @ObservationIgnored
    private(set) var fetchTask: Task<Void, Never>?
    
    @ObservationIgnored
    @Dependency(\.apiClient) private var apiClient
    
    public init(
        date: LocalDate = .init(from: Date(), in: .newYork),
        errorMessage: String? = nil,
        isCalendarPresented: Bool = false,
        picture: AstronomyPicture? = nil,
    ) {
        self.date = date
        self.errorMessage = errorMessage
        self.isCalendarPresented = isCalendarPresented
        self.picture = picture
    }
    
    func calendarButtonTapped() {
        isCalendarPresented = true
    }
    
    func dateSelected(_ date: LocalDate) {
        isCalendarPresented = false
        
        if self.date != date {
            self.date = date
            fetchAstronomyPicture()
        }
    }
    
    func onAppear() {
        if picture != nil {
            return
        }
        
        fetchAstronomyPicture()
    }
    
    func retryButtonTapped() {
        fetchAstronomyPicture()
    }
    
    private func fetchAstronomyPicture() {
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
