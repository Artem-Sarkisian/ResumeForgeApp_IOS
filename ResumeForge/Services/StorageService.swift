import Foundation

class StorageService {
    // Ключ для UserDefaults
    private let resumeStorageKey = "saved_resumes"
    
    // Сохранение резюме
    func saveResume(_ resume: EnhancedResume) throws {
        // Получаем существующие резюме
        var savedResumes = try loadResumes()
        
        // Добавляем новое резюме
        savedResumes.append(resume)
        
        // Кодируем в JSON
        let encoder = JSONEncoder()
        let data = try encoder.encode(savedResumes)
        
        // Сохраняем в UserDefaults
        UserDefaults.standard.set(data, forKey: resumeStorageKey)
    }
    
    // Загрузка сохраненных резюме
    func loadResumes() throws -> [EnhancedResume] {
        // Получаем данные из UserDefaults
        guard let data = UserDefaults.standard.data(forKey: resumeStorageKey) else {
            return []
        }
        
        // Декодируем из JSON
        let decoder = JSONDecoder()
        return try decoder.decode([EnhancedResume].self, from: data)
    }
    
    // Удаление резюме
    func deleteResume(withID id: UUID) throws {
        // Получаем существующие резюме
        var savedResumes = try loadResumes()
        
        // Удаляем резюме с указанным ID
        savedResumes.removeAll { $0.id == id }
        
        // Кодируем обновленный список
        let encoder = JSONEncoder()
        let data = try encoder.encode(savedResumes)
        
        // Сохраняем в UserDefaults
        UserDefaults.standard.set(data, forKey: resumeStorageKey)
    }
}
