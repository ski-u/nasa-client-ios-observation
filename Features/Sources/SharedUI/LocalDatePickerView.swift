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
                    get: { selection.date(in: .current) },
                    set: { selection = .init(from: $0, in: .current) },
                ),
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

#Preview {
    LocalDatePickerView(
        selection: .constant(.init()),
        onCompleted: {},
    )
}
