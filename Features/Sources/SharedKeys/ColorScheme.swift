import Models
import Sharing

public extension SharedKey where Self == AppStorageKey<UserColorScheme> {
    static var colorSchme: Self {
        appStorage("colorScheme")
    }
}
