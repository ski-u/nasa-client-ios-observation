import Foundation
import LocalDate
import SwiftUI

public struct LocalDatePickerView: View {
    @Binding var selection: LocalDate
    var onCompleted: () -> Void
    
    public init(
        selection: Binding<LocalDate>,
        onCompleted: @escaping () -> Void,
    ) {
        _selection = selection
        self.onCompleted = onCompleted
    }
    
    public var body: some View {
        NavigationStack {
            DatePicker(
                selection: .init(
                    get: { selection.date(in: newYorkTimeZone) },
                    set: { selection = .init(from: $0, in: newYorkTimeZone) },
                ),
                in: minimumDate...maximumDate,
                displayedComponents: [.date],
            ) {
                EmptyView()
            }
            .datePickerStyle(.graphical)
            .frame(maxHeight: .infinity, alignment: .top)
            .navigationTitle(Text("Select date", bundle: .module))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: onCompleted) {
                        Image(systemName: "checkmark")
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
        }
    }
}

private extension LocalDatePickerView {
    var newYorkTimeZone: TimeZone {
        .init(identifier: "America/New_York")!
    }
    
    var newYorkCalendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = newYorkTimeZone
        return calendar
    }
    
    var maximumDate: Date {
        newYorkCalendar.startOfDay(for: .now)
    }
    
    var minimumDate: Date {
        DateComponents(
            calendar: newYorkCalendar,
            year: 1995,
            month: 6,
            day: 16,
        ).date!
    }
}

#Preview {
    LocalDatePickerView(
        selection: .constant(.init()),
        onCompleted: {},
    )
}
