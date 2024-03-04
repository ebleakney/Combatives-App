import SwiftUI

struct ScoringItem: Identifiable {
    let id = UUID()
    var description: String
    var points: Int
}

struct RearMountView: View {
    @State private var dpScoringItems: [ScoringItem] = [
        ScoringItem(description: "Lost position or established closed or 1/2 guard (top/bottom)", points: 0),
        ScoringItem(description: "Established front, knee, or side mount", points: 3),
        ScoringItem(description: "Recovered rear mount", points: 5),
        ScoringItem(description: "Maintained", points: 7),
        ScoringItem(description: "Rear Naked Choke (RNC)", points: 10),
        ScoringItem(description: "Guillotine", points: 10)
    ]
    
    @State private var ndpScoringItems: [ScoringItem] = [
        ScoringItem(description: "Got choked", points: 0),
        ScoringItem(description: "No escape", points: 3),
        ScoringItem(description: "Escape to any other NDP or 1/2 guard (top/bottom)", points: 5),
        ScoringItem(description: "Escape to neutral or establish closed guard DP", points: 7),
        ScoringItem(description: "Escape to top dominant", points: 10),
        ScoringItem(description: "RNC or Guillotine", points: 10)
    ]
    
    @State private var selectedDpIndex: Int?
    @State private var selectedNdpIndex: Int?
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Rear Mt (DP)").foregroundColor(.black).padding().background(Color.blue)) {
                    ForEach(Array(dpScoringItems.enumerated()), id: \.element.id) { index, item in
                        ScoringRow(item: item, isSelected: self.selectedDpIndex == index)
                            .onTapGesture {
                                self.selectedDpIndex = self.selectedDpIndex == index ? nil : index
                            }
                    }
                }
                Section(header: Text("Rear Mt (NDP)").foregroundColor(.black).padding().background(Color.gray)) {
                    ForEach(Array(ndpScoringItems.enumerated()), id: \.element.id) { index, item in
                        ScoringRow(item: item, isSelected: self.selectedNdpIndex == index)
                            .onTapGesture {
                                if index == self.ndpScoringItems.count - 1 && self.selectedNdpIndex == index {
                                    return // Don't deselect if it's the last item
                                }
                                self.selectedNdpIndex = self.selectedNdpIndex == index ? nil : index
                            }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .background(Color(.systemGroupedBackground)) // Matches the typical background color for grouped lists
        }
    }
}

struct ScoringRow: View {
    var item: ScoringItem
    var isSelected: Bool
    
    var body: some View {
        HStack {
            Text(item.description)
                .foregroundColor(.black)
            Spacer()
            Text("\(item.points)")
                .foregroundColor(isSelected ? .white : .black)
                .padding()
                .background(isSelected ? Color.blue : Color.gray)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.black, lineWidth: isSelected ? 0 : 1)
                )
        }
        .padding(.vertical, 4)
        .background(isSelected ? Color.blue : Color.clear)
        .cornerRadius(8)
    }
}

struct RearMountView_Previews: PreviewProvider {
    static var previews: some View {
        RearMountView()
    }
}
