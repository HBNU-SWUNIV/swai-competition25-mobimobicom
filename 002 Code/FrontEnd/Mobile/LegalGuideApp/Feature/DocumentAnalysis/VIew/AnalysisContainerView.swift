import SwiftUI

struct AnalysisContainerView: View {
    @State private var isSelected: Bool = false
    @State private var isShowedAnalysis: Bool = false
    @State private var selectedTab: Tab = .all
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 0) {
            // 네비게이션
            NavigationLink(destination: LawAnalysisView(), isActive: $isShowedAnalysis) {
                EmptyView()
            }

            // 헤더
            HeaderView(pageName: "번역 결과") {
                dismiss()
            }

            // 스크롤 콘텐츠
            ScrollView {
                VStack(alignment: .center, spacing: 5) {
                    // 탭 바
                    NavTabBar(isSelected: $selectedTab)

                    // 탭 내용
                    Group {
                        switch selectedTab {
                        case .all:
                            TranslationResultAllView()
                        case .analysis:
                            TranslationResultView()
                        case .original:
                            Text("여기에 원본 보기 뷰 삽입")
                                .foregroundColor(.gray)
                        }
                    }

                    // 저장 / 공유 버튼
                    HStack(spacing: 16) {
                        DefaultButton(text: "저장하기", buttonColor: .white, textColor: .black, verticalPadding: 10)
                            .padding(.horizontal, 30)
                        DefaultButton(text: "공유하기", buttonColor: .white, textColor: .black, verticalPadding: 10)
                            .padding(.horizontal, 30)
                    }
                    .padding(.horizontal, 20)

                    // 분석 보기 버튼
                    DefaultButton(text: "법률 분석 보기") {
                        isShowedAnalysis = true
                    }
                    .padding(.top, 2)
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 100)
            }
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 80)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color.white)
        .navigationBarBackButtonHidden(true)
    }
}


#Preview {
    AnalysisContainerView()
}
