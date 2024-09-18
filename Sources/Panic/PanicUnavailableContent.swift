import SwiftUI

@MainActor
public struct PanicUnavailableContent {
    public struct Label: View {
        private let base: () -> AnyView

        init(base: @escaping () -> some View) {
            self.base = { AnyView(base()) }
        }

        public var body: some View {
            base()
        }
    }

    public struct Description: View {
        private let base: () -> AnyView

        init(base: @escaping () -> some View) {
            self.base = { AnyView(base()) }
        }

        public var body: some View {
            base()
        }
    }

    public struct Actions: View {
        private let base: () -> AnyView

        init(base: @escaping () -> some View) {
            self.base = { AnyView(base()) }
        }

        public var body: some View {
            base()
        }
    }

    public let label: Label
    public let description: Description
    public let actions: Actions

    public init(@ViewBuilder label: @escaping () -> some View, @ViewBuilder description: @escaping () -> some View, @ViewBuilder actions: @escaping () -> some View) {
        self.label = Label {
            label()
        }

        self.description = Description {
            description()
        }

        self.actions = Actions {
            actions()
        }
    }
}

public extension ContentUnavailableView where Label == PanicUnavailableContent.Label, Description == PanicUnavailableContent.Description, Actions == PanicUnavailableContent.Actions {
    init(_ content: PanicUnavailableContent) {
        self.init {
            content.label
        } description: {
            content.description
        } actions: {
            content.actions
        }
    }

    static func panic<T: View, D: View, A: View>(
        @ViewBuilder title: @escaping () -> T,
        @ViewBuilder description: @escaping () -> D,
        @ViewBuilder actions: @escaping () -> A = { EmptyView() }
    ) -> Self {
        ContentUnavailableView(PanicUnavailableContent {
            SwiftUI.Label {
                title()
            } icon: {
                Image(systemName: "exclamationmark.octagon")
                    .foregroundStyle(.red)
            }
        } description: {
            description()
        } actions: {
            actions()
        })
    }

    static func panic<A: View>(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        @ViewBuilder actions: @escaping () -> A = { EmptyView() }
    ) -> Self {
        .panic {
            Text(title)
        } description: {
            Text(description)
        } actions: {
            actions()
        }
    }
}

#Preview {
    ContentUnavailableView.panic {
        Text("Title")
    } description: {
        Text("Description")
    } actions: {
        Button("Button") {}
    }

    ContentUnavailableView.panic(
        title: "Panic",
        description: "Something went wrong"
    )
}
