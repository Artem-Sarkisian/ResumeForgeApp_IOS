import SwiftUI

@main
struct ResumeForgeApp: App {
    @StateObject var resumeManager = ResumeManager()
    @StateObject var authManager = AuthManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(resumeManager)
                .environmentObject(authManager)
        }
    }
}
