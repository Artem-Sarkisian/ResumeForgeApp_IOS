import SwiftUI

struct ResumeHistoryView: View {
    @EnvironmentObject var resumeManager: ResumeManager
    
    var body: some View {
        NavigationView {
            Group {
                if resumeManager.savedResumes.isEmpty {
                    // Если история пуста
                    VStack(spacing: 20) {
                        Image(systemName: "doc.text.magnifyingglass")
                            .font(.system(size: 70))
                            .foregroundColor(.gray)
                        
                        Text("История пуста")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Улучшенные резюме будут отображаться здесь")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                    }
                } else {
                    // Список сохраненных резюме
                    List {
                        ForEach(resumeManager.savedResumes) { resume in
                            NavigationLink(destination: ResumeDetailView(resume: resume)) {
                                ResumeHistoryItemView(resume: resume)
                            }
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .navigationTitle("История")
            .onAppear {
                // Загружаем сохраненные резюме при появлении экрана
                resumeManager.loadSavedResumes()
            }
        }
    }
}

struct ResumeHistoryItemView: View {
    let resume: EnhancedResume
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Дата и отрасль
            HStack {
                Text(resume.industry.displayName)
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .cornerRadius(4)
                
                Spacer()
                
                Text(dateFormatter.string(from: resume.createdAt))
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            // Превью содержимого
            Text(resume.enhancedText.prefix(100) + (resume.enhancedText.count > 100 ? "..." : ""))
                .lineLimit(2)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
    }
    
    // Форматирование даты
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}
