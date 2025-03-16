import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ResumeUploadView()
                .tabItem {
                    Label("Загрузить", systemImage: "doc.badge.plus")
                }
                .tag(0)
            
            ResumeHistoryView()
                .tabItem {
                    Label("История", systemImage: "clock")
                }
                .tag(1)
            
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person")
                }
                .tag(2)
        }
        .accentColor(.blue)
    }
}
