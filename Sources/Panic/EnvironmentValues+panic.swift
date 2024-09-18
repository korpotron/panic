import SwiftUI

private struct PanicKey: @preconcurrency EnvironmentKey {
    @MainActor
    static let defaultValue: PanicAction = .fatal
}

public extension EnvironmentValues {
    var panic: PanicAction {
        get {
            self[PanicKey.self]
        }
        set {
            self[PanicKey.self] = newValue
        }
    }
}
