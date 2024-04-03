import SwiftUI

struct ScoringRow: View {
    @Binding var item: ScoringItem // Use Binding to make item mutable
    
    var body: some View {
        HStack {
            Text(item.description)
                .foregroundColor(.black)
            Spacer()
            Text("\(item.points)")
                .foregroundColor(item.isSelected ? .white : .black)
                .padding()
                .background(item.isSelected ? Color.blue : Color.gray)
                .clipShape(Circle())
                .overlay(
                    Circle().stroke(Color.black, lineWidth: item.isSelected ? 0 : 1)
                )
        }
        .padding(.vertical, 4)
        .background(item.isSelected ? Color.blue : Color.clear)
        .cornerRadius(8)
        .onTapGesture {
            item.isSelected.toggle()
            // Find the item with the highest points
            let highestPointsItem = findHighestPointsItem()
            // Deselect items with fewer points unless it's an extra points item
            deselectItemsWithLessPoints(than: highestPointsItem)
        }
    }
    
    // Function to find the item with the highest points in the row
    private func findHighestPointsItem() -> ScoringItem {
        let items = [item] // Start with the current item
        // If there's a tie, choose the first one
        return items.max { $0.points == $1.points }!
    }
    
    // Function to deselect items with fewer points unless it's an extra points item
    private func deselectItemsWithLessPoints(than highestPointsItem: ScoringItem) {
        // Check each item in the row
        for var currentItem in [item] {
            // Skip the current item
            if currentItem.id == highestPointsItem.id { continue }
            // Deselect the item if it has fewer points and is not an extra points item
            if currentItem.points < highestPointsItem.points && !currentItem.isExtraPoints {
                currentItem.isSelected = false
            }
        }
    }
}
