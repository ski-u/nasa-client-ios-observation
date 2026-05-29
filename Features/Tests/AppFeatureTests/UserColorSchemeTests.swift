import Models
import Testing

@testable import AppFeature

struct UserColorSchemeTests {
    @Test
    func colorScheme() {
        #expect(UserColorScheme.dark.colorScheme == .dark)
        #expect(UserColorScheme.light.colorScheme == .light)
        #expect(UserColorScheme.system.colorScheme == nil)
    }
}
