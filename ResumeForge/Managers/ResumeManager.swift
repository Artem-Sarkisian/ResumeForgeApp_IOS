import Foundation
import Combine

@MainActor
class ResumeManager: ObservableObject {
    // Публикуемые свойства
    @Published var isLoading = false
    @Published var originalResumeText: String?
    @Published var enhancedResume: EnhancedResume?
    @Published var savedResumes: [EnhancedResume] = []
    @Published var error: String?
    
    private let aiService = AIService()
    private let storageService = StorageService()
    
    // Обработка резюме
    func processResume(fileURL: URL, industry: Industry) async throws {
        isLoading = true
        error = nil
        
        do {
            // Чтение содержимого файла
            let fileText = try await readFileContent(from: fileURL)
            
            // Сохраняем оригинальный текст
            originalResumeText = fileText
            
            // Отправляем на обработку в ИИ
            let enhancedResult = try await aiService.enhanceResume(
                originalText: fileText,
                industry: industry
            )
            
            // Обновляем состояние
            DispatchQueue.main.async {
                print("Обновляем enhancedResume, старое значение:", self.enhancedResume as Any)
                self.enhancedResume = enhancedResult
                print("Новое значение:", self.enhancedResume!)
            }
//            self.enhancedResume = enhancedResult
            self.isLoading = false
        } catch {
            self.error = error.localizedDescription
            self.isLoading = false
            throw error
        }
    }
    
    // Чтение содержимого файла
    private func readFileContent(from url: URL) async throws -> String {
        // Получаем доступ к файлу
        if !url.startAccessingSecurityScopedResource() {
            throw ResumeError.fileAccessDenied
        }
        
        defer {
            url.stopAccessingSecurityScopedResource()
        }
        
        do {
            // Для PDF требуется специальная обработка
            if url.pathExtension.lowercased() == "pdf" {
                return try extractTextFromPDF(url: url)
            } else {
                return try String(contentsOf: url, encoding: .utf8)
            }
        } catch {
            throw ResumeError.fileReadError
        }
    }
    
    // Извлечение текста из PDF
    private func extractTextFromPDF(url: URL) throws -> String {
        // Упрощенная реализация
        return "Текст из PDF-файла (в реальной реализации используйте PDFKit)"
    }
    
    // Сохранение улучшенного резюме
    func saveEnhancedResume() {
        guard let resume = enhancedResume else { return }
        
        do {
            try storageService.saveResume(resume)
            loadSavedResumes()
        } catch {
            self.error = "Не удалось сохранить резюме: \(error.localizedDescription)"
        }
    }
    
    // Загрузка сохраненных резюме
    func loadSavedResumes() {
        do {
            let resumes = try storageService.loadResumes()
            self.savedResumes = resumes
        } catch {
            self.error = "Не удалось загрузить историю: \(error.localizedDescription)"
        }
    }
    
    // Очистка текущего результата
    func clearCurrentResult() {
        enhancedResume = nil
        originalResumeText = nil
    }
}

enum ResumeError: Error, LocalizedError {
    case fileAccessDenied
    case fileReadError
    case unsupportedFileFormat
    case aiProcessingError
    
    var errorDescription: String? {
        switch self {
        case .fileAccessDenied:
            return "Нет доступа к файлу"
        case .fileReadError:
            return "Ошибка чтения файла"
        case .unsupportedFileFormat:
            return "Неподдерживаемый формат файла"
        case .aiProcessingError:
            return "Ошибка обработки ИИ"
        }
    }
}
