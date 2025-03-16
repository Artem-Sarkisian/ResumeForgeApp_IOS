import Foundation

enum Industry: String, CaseIterable, Identifiable, Codable {
    case technology
    case finance
    case healthcare
    case education
    case marketing
    case other
    
    var id: String { self.rawValue }
    
    var displayName: String {
        switch self {
        case .technology: return "IT"
        case .finance: return "Финансы"
        case .healthcare: return "Медицина"
        case .education: return "Образование"
        case .marketing: return "Маркетинг"
        case .other: return "Другое"
        }
    }
}
