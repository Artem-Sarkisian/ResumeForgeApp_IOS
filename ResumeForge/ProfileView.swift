import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationView {
            Form {
                // Информация о пользователе
                Section(header: Text("Профиль")) {
                    if let user = authManager.currentUser {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 65))
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(user.name)
                                    .font(.headline)
                                Text(user.email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                // Информация о подписке
                Section(header: Text("Подписка")) {
                    if let user = authManager.currentUser {
                        HStack {
                            Image(systemName: user.subscriptionActive ? "checkmark.seal.fill" : "xmark.seal.fill")
                                .foregroundColor(user.subscriptionActive ? .green : .red)
                            
                            Text(user.subscriptionActive ? "Активная подписка" : "Нет активной подписки")
                            
                            Spacer()
                            
                            if !user.subscriptionActive {
                                Button("Активировать") {
                                    // Логика активации подписки (не реализована в примере)
                                }
                                .foregroundColor(.blue)
                            }
                        }
                    }
                }
                
                // Настройки
                Section(header: Text("Настройки")) {
                    Button(action: {
                        // Логика для экрана настроек (не реализована в примере)
                    }) {
                        HStack {
                            Image(systemName: "gear")
                            Text("Настройки приложения")
                        }
                    }
                    
                    Button(action: {
                        // Логика для экрана поддержки (не реализована в примере)
                    }) {
                        HStack {
                            Image(systemName: "questionmark.circle")
                            Text("Поддержка")
                        }
                    }
                }
                
                // Выход из аккаунта
                Section {
                    Button(action: {
                        authManager.logout()
                    }) {
                        HStack {
                            Spacer()
                            Text("Выйти")
                                .foregroundColor(.red)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Профиль")
        }
    }
}
