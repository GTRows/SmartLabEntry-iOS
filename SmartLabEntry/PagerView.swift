import SwiftUI
import SwiftUIPager

struct CardsCellView: View {
    var title: String

    var body: some View {
        VStack {
            Button(action: {
                print("Tapped")
            }) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 300, height: 200)
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct PagerView: View {
    @State private var selectedIndex = 0
    private let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]

    @StateObject var page1: Page = Page.withIndex(2)
    @StateObject var page: Page = .first()
    @State var isPresented: Bool = false

    var body: some View {
        VStack {
            Pager(
                page: page1,
                data: items,
                id: \.self
            ) { item in
                CardsCellView(title: item)
            }
            .singlePagination(ratio: 0.5, sensitivity: .medium)
            .onPageWillChange({ page in
                print("Page will change to \(page)")
            })
            .onPageChanged { page in
                print("Page changed to \(page)")
                selectedIndex = page
                isPresented.toggle()
                if page == items.count - 1 {
                    print("Last page")
                    page1.update(.moveToFirst)
                    selectedIndex = 0
                }
            }
            .pagingPriority(.simultaneous)
            .preferredItemSize(CGSize(width: 320, height: 200))
            .itemSpacing(10)
            .background(Color.red)

            // Sayfa Göstergesi
            HStack {
                ForEach(items.indices, id: \.self) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color.red : Color.gray)
                        .frame(width: 10, height: 10)
                }
            }
        }
    }
}

struct PagerView_Previews: PreviewProvider {
    static var previews: some View {
        PagerView()
    }
}
