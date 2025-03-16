import Foundation

class AIService {
    // URL API
    private let apiURL = URL(string: "https://api.anthropic.com/v1/messages")!
    // API-ключ (в реальном приложении должен быть защищен)
    private let apiKey = "your_api_key_here"
    
    // Метод улучшения резюме с помощью ИИ
    func enhanceResume(originalText: String, industry: Industry) async throws -> EnhancedResume {
        // Формируем запрос
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("anthropic-version", forHTTPHeaderField: "x-api-key")
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        
        // Создаем промпт для ИИ на основе отрасли
        let prompt = createPrompt(for: originalText, industry: industry)
        
        // Структура запроса для Claude API
        let requestBody: [String: Any] = [
            "model": "claude-3-sonnet-20240229",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "max_tokens": 4000
        ]
        
        // Сериализуем запрос
        let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
        request.httpBody = jsonData
        
        // В реальном приложении выполняем сетевой запрос
        // Здесь имитируем ответ для примера
        do {
            try await Task.sleep(nanoseconds: 3_000_000_000) // 3 секунды
            
            // Создаем улучшенный текст (имитация ответа от API)
            let enhancedText = simulateAIResponse(originalText: originalText, industry: industry)
            
            // Создаем объект улучшенного резюме
            return EnhancedResume(
                originalText: originalText,
                enhancedText: enhancedText,
                industry: industry,
                summary: "Улучшены формулировки, добавлены ключевые навыки, исправлены грамматические ошибки."
            )
        } catch {
            throw ResumeError.aiProcessingError
        }
    }
    
    // Создает промпт для ИИ на основе отрасли
    private func createPrompt(for text: String, industry: Industry) -> String {
        return """
        Улучши это резюме для отрасли \(industry.displayName).
        Сделай формулировки более профессиональными, добавь релевантные ключевые слова,
        исправь грамматические ошибки и улучши структуру.
        
        Оригинальное резюме:
        \(text)
        """
    }
    
    // Имитация ответа ИИ для примера
    private func simulateAIResponse(originalText: String, industry: Industry) -> String {
        // В реальном приложении здесь будет обработка ответа от API
        // Для демонстрации используем упрощенную логику
        
        var enhancedText = originalText
        
        // Добавляем улучшения в зависимости от отрасли
        switch industry {
        case .technology:
            enhancedText += "\n\n[Улучшенная версия с акцентом на технические навыки]"
        case .finance:
            enhancedText += "\n\n[Улучшенная версия с акцентом на финансовые навыки]"
        case .healthcare:
            enhancedText += "\n\n[Улучшенная версия с акцентом на медицинские навыки]"
        case .education:
            enhancedText += "\n\n[Улучшенная версия с акцентом на образовательные навыки]"
        case .marketing:
            enhancedText += "\n\n[Улучшенная версия с акцентом на маркетинговые навыки]"
        case .other:
            enhancedText += "\n\n[Улучшенная версия с общими улучшениями]"
        }
        
        return enhancedText
    }
}
