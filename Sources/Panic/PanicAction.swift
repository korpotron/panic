import SwiftUI

@MainActor
public struct PanicAction {
    private let handler: PanicHandler

    public init(handler: @escaping PanicHandler) {
        self.handler = handler
    }

    public func callAsFunction(_ error: PanicError) {
        handler(error)
    }
}

public extension PanicAction {
    static let fatal: Self = .init { error in
        fatalError("panic | \(error)")
    }
}
