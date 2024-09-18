import SwiftUI
import Panic

#Preview {
    struct DevelopmentError: PanicError {
        let description: String
    }

    struct OtherError: PanicError {}

    struct FooView: View {
        @Environment(\.panic)
        var panic

        var body: some View {
            TabView {
                Tab {
                    Color.yellow
                        .ignoresSafeArea()
                } label: {
                    Label {
                        Text("First")
                    } icon: {
                        Image(systemName: "house")
                    }
                }
                Tab {
                    Button("Panic dev") {
                        panic(DevelopmentError(description: "dev"))
                    }
                    Button("Panic other") {
                        panic(OtherError())
                    }
                } label: {
                    Label {
                        Text("Second")
                    } icon: {
                        Image(systemName: "ant")
                    }
                }
            }
        }
    }

    struct Example: View {
        var body: some View {
            PanicView {
                FooView()
            } panic: { error, retry in
                ContentUnavailableView.panic(
                    title: "Panic",
                    description: "Something went wrong",
                    actions: {
                        Button("Retry", action: retry)
                    }
                )
            }
        }
    }

    return Example()
}
