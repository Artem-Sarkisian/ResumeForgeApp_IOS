import Foundation
import Combine

let resumeManager = ResumeManager()

Task {
    do {
        let testURL = URL(fileURLWithPath: "/Users/artesarkisyan/Dev/ResumeForgeApp_IOS/testresume.txt") // Укажи реальный путь
        try await resumeManager.processResume(fileURL: testURL, industry: .technology)
    } catch {
        print("Ошибка:", error.localizedDescription)
    }
}
