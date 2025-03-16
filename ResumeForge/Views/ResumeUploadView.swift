import SwiftUI
import UniformTypeIdentifiers

struct ResumeUploadView: View {
    @EnvironmentObject var resumeManager: ResumeManager
    @State private var isShowingDocumentPicker = false
    @State private var isShowingErrorAlert = false
    @State private var errorMessage = ""
    @State private var selectedIndustry = Industry.technology
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Улучшите своё резюме")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Загрузите файл резюме в формате PDF, DOCX или TXT для улучшения с помощью ИИ")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Image(systemName: "wand.and.stars")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("ИИ улучшит ваше резюме")
                                .font(.headline)
                            Text("Получите профессиональные рекомендации")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "timer")
                            .font(.title)
                            .foregroundColor(.blue)
                        
                        VStack(alignment: .leading) {
                            Text("Быстрая обработка")
                                .font(.headline)
                            Text("Результат будет готов в течение минуты")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                )
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Выберите отрасль:")
                        .font(.headline)
                        .padding(.leading)
                    
                    Picker("Отрасль", selection: $selectedIndustry) {
                        ForEach(Industry.allCases) { industry in
                            Text(industry.displayName).tag(industry)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                
                Button(action: {
                    isShowingDocumentPicker = true
                }) {
                    HStack {
                        Image(systemName: "arrow.up.doc")
                        Text("Загрузить резюме")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                
                if resumeManager.isLoading {
                    ProgressView("Обрабатываем ваше резюме...")
                        .padding()
                }
                
                Spacer()
            }
            .padding(.vertical)
            .navigationTitle("Resume Enhancer")
            .sheet(isPresented: $isShowingDocumentPicker) {
                DocumentPicker(
                    supportedTypes: [UTType.pdf, UTType.plainText, UTType.rtf],
                    onDocumentsPicked: handleDocumentsPicked
                )
            }
            .alert(isPresented: $isShowingErrorAlert) {
                Alert(
                    title: Text("Ошибка"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .onChange(of: resumeManager.enhancedResume) { _, newValue in
                guard newValue != nil else { return }
                navigateToResultView()
            }
        }
    }
    
    private func handleDocumentsPicked(urls: [URL]) {
        guard let url = urls.first else { return }
        
        let fileExtension = url.pathExtension.lowercased()
        let supportedExtensions = ["pdf", "docx", "txt", "rtf"]
        
        guard supportedExtensions.contains(fileExtension) else {
            errorMessage = "Неподдерживаемый формат файла. Пожалуйста, загрузите PDF, DOCX или TXT."
            isShowingErrorAlert = true
            return
        }
        
        Task {
            do {
                try await resumeManager.processResume(fileURL: url, industry: selectedIndustry)
            } catch {
                errorMessage = "Не удалось обработать файл: \(error.localizedDescription)"
                isShowingErrorAlert = true
            }
        }
    }
    
    private func navigateToResultView() {
        // В полной реализации здесь будет код для программной навигации
    }
}
