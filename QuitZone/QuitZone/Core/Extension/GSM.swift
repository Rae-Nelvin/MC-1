//
//  GSM.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

//buat atur Text
extension Text {
    // set kalo body brp, title brp,
    //title: 36
    //body:14
    func customText(size:Double) -> some View {
        self.font(.custom("SF Pro", size: size))
    }
    
}

extension Font {
    enum BloxFont {
        case regular
        
        var value: String {
            switch self {
            case .regular:
                return "Blox-BRK"
            }
        }
    }
    
    enum TicketingFont {
        case regular
        
        var value: String {
            switch self {
            case .regular:
                return "Ticketing"
            }
        }
    }
    
    enum SizeFont {
        case maintitle
        case title
        case body
        case caption
        
        var value: CGFloat {
            switch self {
            case .maintitle:
                return 72
            case .title:
                return 34
            case .body:
                return 20
            case .caption:
                return 16
            }
        }
    }
    
    static func primary(_ type: BloxFont,  _ size: SizeFont) -> Font {
        return .custom(type.value, size: size.value)
    }
    
    static func secondary(_ type: TicketingFont, _ size: SizeFont) -> Font {
        return .custom(type.value, size: size.value)
    }
}

extension View {
    func hAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vAlign(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func statisticsFormating() -> some View {
        self
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .fill(.white.shadow(.drop(radius: 5)))
            )
            .padding(.top, 15)
    }
}

//warna apps kita
struct AppColor {
    static let primary1 = Color("blue")
    static let primary2 = Color("yellow")
    static let secondary = Color("green")
    static let tertiary = Color("yellow")
    private init() {}
}

//ukuran image

//button start, submit

//button nagivation bar (save, edit, create team, create)

//back button (my teams, asoy geboy, edit profile)

//text field form
struct customTextField: View {
    
    @Binding var question: String
    @Binding var answer: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.regular, .body))
                .padding(.bottom, 6)
            TextField("", text: $answer)
                .font(.title)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(width:315, height:52)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("SystemGray"), lineWidth: 2)
                )
        }
        .frame(width:.infinity, height:82)
        
    }
}
//ada text
//ada date
//ada dropdown

//alert
//MARK: Mission alert
extension View {
    //MARK: Alert with 2 Button
    func customMissionAlert(title: String, message: String, leftButton: String, rightButton: String, leftAction: @escaping ()->(), rightAction: @escaping ()-> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //left side (Cancel)
        alert.addAction(.init(title: leftButton, style: .default, handler: { _ in
            leftAction()
        }))
        
        //right side (Mark as Done)
        alert.addAction(.init(title: rightButton, style: .default, handler: { _ in
            rightAction()
        }))
        
        //showing alert
        alertController().present(alert, animated: true, completion: nil)
    }
    
    //button alert
    //MARK: Alert with 2 Button & 1 Textfield
    func customAlertTextField(title: String, message: String, leftButton: String, rightButton: String, leftAction: @escaping ()->(), rightAction: @escaping (String)-> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField() { field in
            field.keyboardType = .decimalPad
            field.placeholder = "3"
        }
        
        //left side (Cancel)
        alert.addAction(.init(title: leftButton, style: .default, handler: { _ in
            leftAction()
        }))
        
        //right side (Save)
        alert.addAction(.init(title: rightButton, style: .default, handler: { _ in
            if let text = alert.textFields?[0].text {
                rightAction(text)
            } else {
                rightAction("-1")
            }
        }))
        
        //showing alert
        alertController().present(alert, animated: true, completion: nil)
    }
    
    //MARK: showing alert controller
    func alertController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return .init()}
        guard let root = screen.windows.first?.rootViewController else {return .init()}
        
        return root
    }
}

//tabview


//user info list


//team list container


//team member list container

//search bar



