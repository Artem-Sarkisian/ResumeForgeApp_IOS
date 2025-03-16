import SwiftUI

struct ContentView: View {
    // Подключаем глобальные объекты состояния
    @EnvironmentObject var authManager: AuthManager
    @EnvironmentObject var resumeManager: ResumeManager
    
    var body: some View {
        NavigationView {
            // Показываем разные экраны в зависимости от состояния авторизации
            if authManager.isAuthenticated {
                MainTabView()
            } else {
                AuthView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
