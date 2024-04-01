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
            if item.isExtraPoints && item.isSelected {
                item.isSelected.toggle()
            }
            else if item.isSelected{
                item.isSelected.toggle()
            }
            /// Make changes so there is 1 case to handle whenever an item is selcted. It will check to make sure it is the highest points if it is the highest points it willl stay selected. If an extra points option is selected
        }
    }
}
