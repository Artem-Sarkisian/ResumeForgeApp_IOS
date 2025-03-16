import Foundation

// Протокол
protocol ChangePerformable {
    func handleDocumentsPicked(urls: [URL])
}

// Исправленная структура EnhancedResume
struct EnhancedResume: Codable, Identifiable, ChangePerformable, Equatable {
    let id: UUID
    let originalText: String
    let enhancedText: String
    let industry: Industry
    let summary: String
    let createdAt: Date
    
    init(
        id: UUID = UUID(),
        originalText: String,
        enhancedText: String,
        industry: Industry,
        summary: String,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.originalText = originalText
        self.enhancedText = enhancedText
        self.industry = industry
        self.summary = summary
        self.createdAt = createdAt
    }
    
    // Реализация метода из протокола
    func handleDocumentsPicked(urls: [URL]) {
        print("Обработка документов для резюме \(id): \(urls)")
        // Здесь добавь свою логику обработки документов
    }
    
    // Реализация Equatable
    static func == (lhs: EnhancedResume, rhs: EnhancedResume) -> Bool {
        return lhs.id == rhs.id &&
               lhs.originalText == rhs.originalText &&
               lhs.enhancedText == rhs.enhancedText &&
               lhs.industry == rhs.industry &&
               lhs.summary == rhs.summary &&
               lhs.createdAt == rhs.createdAt
    }
}
