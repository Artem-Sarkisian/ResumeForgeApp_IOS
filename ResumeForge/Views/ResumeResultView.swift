import SwiftUI

struct ResumeResultView: View {
    @EnvironmentObject var resumeManager: ResumeManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isShowingShareSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Заголовок с успешным результатом
                HStack {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                    
                    Text("Резюме улучшено!")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                
                // Раздел с обзором изменений
                VStack(alignment: .leading, spacing: 10) {
                    Text("Обзор изменений")
                        .font(.headline)
                    
                    if let enhancedResume = resumeManager.enhancedResume {
                        Text(enhancedResume.summary)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                
                // Оригинальное и улучшенное резюме
                HStack(spacing: 0) {
                    // Оригинальная версия
                    VStack {
                        Text("Оригинал")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ScrollView {
                            if let originalText = resumeManager.originalResumeText {
                                Text(originalText)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(height: 300)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                    
                    // Улучшенная версия
                    VStack {
                        Text("Улучшенная версия")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        ScrollView {
                            if let enhancedResume = resumeManager.enhancedResume {
                                Text(enhancedResume.enhancedText)
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .frame(height: 300)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Кнопки действий
                VStack(spacing: 15) {
                    Button(action: {
                        isShowingShareSheet = true
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Поделиться результатом")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        resumeManager.saveEnhancedResume()
                    }) {
                        HStack {
                            Image(systemName: "arrow.down.doc")
                            Text("Сохранить в историю")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        resumeManager.clearCurrentResult()
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Вернуться к загрузке")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray5))
                        .foregroundColor(.primary)
                        .cornerRadius(10)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Результат")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingShareSheet) {
            if let enhancedResume = resumeManager.enhancedResume {
                ActivityViewController(activityItems: [enhancedResume.enhancedText])
            }
        }
    }
}
