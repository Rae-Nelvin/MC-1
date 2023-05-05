//
//  CustomDatePickerComponent.swift
//  QuitZone
//
//  Created by Salsabila Zahra Chinanti on 05/05/23.
//

import SwiftUI

struct CustomDatePickerComponent: View {
    @Binding var question: String
    @Binding var dateOfBirth: String
    @State private var selectedDate = Date()
    
    private let maximumDateAllowed = Calendar.current.date(byAdding: .day, value: 0, to: Date())!

    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            
            ZStack {
                HStack{
                    Text("\(dateOnly(date:selectedDate))")
                    Spacer()
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal, 12)
                .frame(width:315, height:52)
                .background()
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("SystemGray"), lineWidth: 2)
                )
                
                DatePicker("", selection: $selectedDate, in: ...maximumDateAllowed, displayedComponents: [.date])
                    .foregroundColor(.white)
                    .datePickerStyle(CompactDatePickerStyle())
                    .labelsHidden()
                    .transformEffect(.init(scaleX: 2.6, y: 1.3))
                    .offset(CGSize(width: 0, height: -5))
                    .opacity(0.02)
                    .colorInvert()
                    .background(.clear)
            .hAlign(.leading)
            }
        }
        
    }
    
    func dateOnly(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}

struct NoHitTesting: ViewModifier {
    func body(content: Content) -> some View {
        SwiftUIWrapper { content }
            .allowsHitTesting(false)
    }
}

extension View {
    func userInteractionDisabled() -> some View {
        self.modifier(NoHitTesting())
    }
}

struct SwiftUIWrapper<T: View>: UIViewControllerRepresentable {
    let content: () -> T
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: content())
    }
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {}
}

struct Previews_CustomDatePickerComponent_Previews: PreviewProvider {
    
    @State static private var dummyUser: User = User()
    @State static private var options:[String]=["Sampoerna", "Rokok 2", "Rokok 3", "Rokok 4"]
    
    static var previews: some View {
        CustomDatePickerComponent(question: .constant("Question"), dateOfBirth: $dummyUser.dateOfBirth)
    }
}
