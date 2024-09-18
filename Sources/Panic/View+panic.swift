import SwiftUI

public extension View {
    @inlinable
    func panic(_ handler: @escaping PanicHandler) -> some View {
        environment(\.panic, PanicAction(handler: handler))
    }
}
