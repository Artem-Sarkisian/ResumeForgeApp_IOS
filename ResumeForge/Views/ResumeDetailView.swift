import SwiftUI

struct ResumeDetailView: View {
    let resume: EnhancedResume
    @State private var isShowingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Информация о резюме
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(resume.industry.displayName)
                            .font(.headline)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(5)
                        
                        Spacer()
                        
                        Text("Сохранено: \(dateFormatter.string(from: resume.createdAt))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Divider()
                    
                    // Краткое содержание улучшений
                    Text("Обзор изменений")
                        .font(.headline)
                    
                    Text(resume.summary)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // Содержимое резюме
                VStack(alignment: .leading, spacing: 15) {
                    Text("Улучшенное резюме")
                        .font(.headline)
                    
                    Text(resume.enhancedText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                
                // Кнопки действий
                Button(action: {
                    isShowingShareSheet = true
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Поделиться")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Детали резюме")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingShareSheet) {
            ActivityViewController(activityItems: [resume.enhancedText])
        }
    }
    
    // Форматирование даты
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        return formatter
    }
}
