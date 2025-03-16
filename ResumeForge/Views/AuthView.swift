import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email = ""
    @State private var password = ""
    @State private var isShowingRegistration = false
    
    var body: some View {
        VStack(spacing: 30) {
            // Заголовок и логотип
            VStack(spacing: 15) {
                Image(systemName: "doc.text.magnifyingglass")
                    .font(.system(size: 70))
                    .foregroundColor(.blue)
                
                Text("Resume Enhancer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Улучшайте резюме с помощью ИИ")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            .padding(.top, 50)
            
            // Поля ввода
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                SecureField("Пароль", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                if let error = authManager.error {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding(.horizontal)
            
            // Кнопки действий
            VStack(spacing: 15) {
                Button(action: login) {
                    if authManager.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Войти")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .disabled(authManager.isLoading)
                
                Button(action: {
                    isShowingRegistration = true
                }) {
                    Text("Зарегистрироваться")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .foregroundColor(.primary)
                .cornerRadius(10)
                .sheet(isPresented: $isShowingRegistration) {
                    // Экран регистрации (не реализован в данном примере)
                    Text("Экран регистрации")
                }
                
                // Демо-режим для тестирования
                Button(action: demoLogin) {
                    Text("Войти в демо-режиме")
                        .fontWeight(.medium)
                }
                .padding(.top)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
    
    // Функция входа
    private func login() {
        Task {
            do {
                try await authManager.login(email: email, password: password)
            } catch {
                // Ошибка обрабатывается в AuthManager
            }
        }
    }
    
    // Демо-режим для тестирования
    private func demoLogin() {
        Task {
            do {
                try await authManager.login(email: "demo@example.com", password: "demo123")
            } catch {
                // Ошибка обрабатывается в AuthManager
            }
        }
    }
}
