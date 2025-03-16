import Foundation
import Combine

@MainActor
class AuthManager: ObservableObject {
    // Публикуемые свойства
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isLoading = false
    @Published var error: String?
    
    // Имитация процесса авторизации
    func login(email: String, password: String) async throws {
        isLoading = true
        error = nil
        
        do {
            // Имитация запроса к серверу
            try await Task.sleep(nanoseconds: 2_000_000_000) // 2 секунды
            
            // Проверка данных
            if email.isEmpty || password.isEmpty {
                throw AuthError.invalidCredentials
            }
            
            // Успешная авторизация
            let user = User(
                id: UUID().uuidString,
                email: email,
                name: "Пользователь",
                subscriptionActive: true
            )
            
            // Обновляем состояние
            self.currentUser = user
            self.isAuthenticated = true
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
            throw error
        }
    }
    
    // Выход из аккаунта
    func logout() {
        isAuthenticated = false
        currentUser = nil
    }
}

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case networkError
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Неверный email или пароль"
        case .networkError:
            return "Ошибка сети. Проверьте подключение к интернету"
        case .serverError:
            return "Ошибка сервера. Попробуйте позже"
        }
    }
}
