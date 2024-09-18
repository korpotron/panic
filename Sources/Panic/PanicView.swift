import SwiftUI

public struct PanicView<Root: View, Content: View>: View {
    public typealias RetryHandler = () -> Void

    private let root: () -> Root
    private let panic: (PanicError, @escaping RetryHandler) -> Content

    @State
    private var error: PanicError?

    public init(@ViewBuilder root: @escaping () -> Root, @ViewBuilder panic: @escaping (PanicError, @escaping RetryHandler) -> Content) {
        self.root = root
        self.panic = panic
        self.error = error
    }

    public init(@ViewBuilder root: @escaping () -> Root, @ViewBuilder panic: @escaping (PanicError) -> Content) {
        self.root = root
        self.panic = { error, _ in
            panic(error)
        }
        self.error = error
    }

    public var body: some View {
        if let error {
            panic(error, retry)
        } else {
            root()
                .panic { error in
                    self.error = error
                }
        }
    }

    private func retry() {
        error = nil
    }
}
