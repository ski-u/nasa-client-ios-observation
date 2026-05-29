import Dependencies
import Foundation
import LocalDate
import Models
import Testing

@testable import FeatureAstronomyPictureDetail

struct AstronomyPictureDetailViewModelTests {
    @MainActor
    struct CalendarIntegrationTests {
        @Test
        func calendarButtonTapped() {
            let viewModel = AstronomyPictureDetailViewModel()
            #expect(!viewModel.isCalendarPresented)
            
            viewModel.calendarButtonTapped()
            #expect(viewModel.isCalendarPresented)
        }
        
        @Test
        func dateSelected() async {
            var called: [LocalDate] = []
            
            let viewModel = withDependencies {
                $0.apiClient.fetchAstronomyPictures = { @MainActor in
                    called.append($0)
                    return .mock
                }
            } operation: {
                AstronomyPictureDetailViewModel(
                    date: .init(year: 2026, month: 5, day: 29),
                    isCalendarPresented: true,
                )
            }
            
            let selectedDate = LocalDate(year: 2026, month: 5, day: 30)
            
            viewModel.dateSelected(selectedDate)
            await viewModel.fetchTask?.value
            
            #expect(viewModel.date == selectedDate)
            #expect(!viewModel.isCalendarPresented)
            #expect(viewModel.picture == .mock)
            #expect(called == [selectedDate])
        }
        
        @Test
        func sameDateSelected() {
            let date = LocalDate(year: 2026, month: 5, day: 29)
            let viewModel = AstronomyPictureDetailViewModel(
                date: date,
                isCalendarPresented: true,
            )
            
            viewModel.dateSelected(date)
            #expect(!viewModel.isCalendarPresented)
        }
    }
    
    @MainActor
    struct OnAppearTests {
        @Test
        func astronomyPictureReceived() async {
            let date = LocalDate(year: 2026, month: 5, day: 29)
            var called: [LocalDate] = []
            
            let viewModel = withDependencies {
                $0.apiClient.fetchAstronomyPictures = { @MainActor in
                    called.append($0)
                    return .mock
                }
            } operation: {
                AstronomyPictureDetailViewModel(
                    date: date,
                )
            }
            
            viewModel.onAppear()
            await viewModel.fetchTask?.value
            
            #expect(viewModel.picture == .mock)
            #expect(called == [date])
        }
        
        @Test
        func errorReceived() async {
            let error = NSError(domain: "test", code: 1)
            
            let viewModel = withDependencies {
                $0.apiClient.fetchAstronomyPictures = { _ in
                    throw error
                }
            } operation: {
                AstronomyPictureDetailViewModel(
                    date: .init(year: 2026, month: 5, day: 29),
                )
            }
            
            viewModel.onAppear()
            await viewModel.fetchTask?.value
            
            #expect(viewModel.picture == nil)
            #expect(viewModel.errorMessage == error.localizedDescription)
        }
        
        @Test
        func astronomyPictureAlreadyExists() async {
            let viewModel = AstronomyPictureDetailViewModel(
                date: .init(year: 2026, month: 5, day: 29),
                picture: .mock,
            )
            
            viewModel.onAppear()
        }
    }
    
    @MainActor
    struct RetryButtonTappedTests {
        @Test
        func retrySucceeded() async {
            let viewModel = withDependencies {
                $0.apiClient.fetchAstronomyPictures = { _ in
                    return .mock
                }
            } operation: {
                AstronomyPictureDetailViewModel(
                    date: .init(year: 2026, month: 5, day: 29),
                    errorMessage: "error",
                )
            }
            
            viewModel.retryButtonTapped()
            await viewModel.fetchTask?.value
            
            #expect(viewModel.errorMessage == nil)
            #expect(viewModel.picture == .mock)
        }
    }
}
