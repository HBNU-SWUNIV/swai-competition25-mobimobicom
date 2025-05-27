//
//  MyDocumentView.swift
//  LegalGuideApp
//
//  Created by 강윤서 on 5/6/25.


/* import SwiftUI

struct MyDocumentView: View {
    @Binding var selectedTab: AppTab
    
    // 샘플 데이터
    struct Document: Identifiable {
        var id: UUID = UUID()
        var title: String
        let data: String
    }
    
    @State private var documents: [Document] = [
        .init(title: "근로게약서", date: "2025-05-03")
    ]
    
    @State private var selectedCategory: String = "전체"
    let categories = ["전체", "근로계약서", "기타"]
    
    var filteredDocuments: [Document] {
        if selectedCategory == "전체" {
            return documents
        } else {
            return documents.filter {$0.title == selectedCategory}
        }
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HeaderView(pageName: "내 문서 기록") {
                //dismiss()
            }
            HStack(spacing: 8) {
                
            }
               
        }
    }
}

#Preview {
    StatefulPreviewWrapper(AppTab.myDocument) { binding in
        MyDocumentView(selectedTab: binding)
    }

}
*/

import SwiftUI

struct MyDocumentView: View {
    @Binding var selectedTab: AppTab
    @Environment(\.dismiss) private var dismiss

    struct Document: Identifiable, Equatable {
        let id = UUID()
        var title: String
        let date: String
        var isEditing: Bool = false
    }

    @State private var documents: [Document] = [
        .init(title: "근로계약서", date: "2025-05-03"),
        .init(title: "보험계약서", date: "2025-04-28"),
        .init(title: "임대차계약서", date: "2025-05-01"),
        .init(title: "근로계약서", date: "2024-07-15")
    ]

    @State private var selectedCategory: String = "전체"
    let categories = ["전체", "근로계약서", "기타"]

    var filteredDocuments: [Document] {
        if selectedCategory == "전체" {
            return documents
        } else {
            return documents.filter { $0.title == selectedCategory }
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            HeaderView(pageName: "내 문서 기록") {
                dismiss()
            }

            HStack(spacing: 8) {
                Spacer()
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(.subheadline)
                            .foregroundColor(selectedCategory == category ? .white : .black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(selectedCategory == category ? Color.blue : Color.gray.opacity(0.2))
                            )
                    }
                }
                Spacer()
            }
            .padding(.horizontal)

            // 문서 카드 리스트
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(filteredDocuments) { doc in
                        if let index = documents.firstIndex(of: doc) {
                            ZStack(alignment: .topTrailing) {
                                HStack(spacing: 8) {
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 24, height: 24)
                                        .foregroundColor(.blue)

                                    VStack(alignment: .leading, spacing: 4) {
                                        if documents[index].isEditing {
                                            TextField("문서 이름", text: $documents[index].title, onCommit: {
                                                documents[index].isEditing = false
                                            })
                                            .textFieldStyle(.roundedBorder)
                                        } else {
                                            HStack {
                                                Text(documents[index].title)
                                                    .bold()
                                                    .foregroundColor(.black)
                                                Button {
                                                    documents[index].isEditing = true
                                                } label: {
                                                    Image(systemName: "pencil")
                                                        .font(.system(size: 16, weight: .bold))
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }

                                        Text(documents[index].date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()
                                }
 
                                Button {
                                    documents.remove(at: index)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .frame(height: 90)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray.opacity(0.4))
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                .padding(.top, 4)
            }

            Spacer()
        }
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    StatefulPreviewWrapper(AppTab.myDocument) { binding in
        MyDocumentView(selectedTab: binding)
    }
}

