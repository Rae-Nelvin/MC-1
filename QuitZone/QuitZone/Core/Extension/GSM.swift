//
//  GSM.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI


//MARK: STRUCT2
//TextField
struct customTextField: View {
    
    @Binding var question: String
    @Binding var answer: String
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            TextField("", text: $answer)
                .font(.title)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(width:315, height: question == "Group Goal" ? 100 : 52)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("SystemGray"), lineWidth: 2)
                )
        }
        .frame(width:.infinity, height:82)
        
    }
}

struct customIntField: View {
    
    @Binding var question: String
    @Binding var answer: Int16
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            TextField("", value: $answer, formatter: NumberFormatter())
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

//button start, submit
struct customButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .background(Image("board"))
            .scaleEffect(configuration.isPressed ? 1.2 : 1.0)
    }
}

//DatePicker
struct customDatePicker: View {
    
    @Binding var question: String
    @Binding var answer: Date
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            DatePicker("",
                       selection: $answer,
                       displayedComponents: [.date])
            .datePickerStyle(.compact)
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

// Image Picker
struct customImagePicker: View {
    
    @Binding var question: String
    @Binding var selectedImage: UIImage?
    @Binding var showImagePicker: Bool
    
    var body: some View {
        Button(action: {
            showImagePicker = true
        }) {
            Text("Select Image")
                .font(.secondary(.body))
                .foregroundColor(.black)
                .offset(CGSize(width: 0, height: showImagePicker ? -2 : -6))
                .animation(nil)
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
        .frame(width: 120, height: 80, alignment: .center)
        .padding(.all, 20)
        .background(Image("blankRectangleGray")
            .resizable()
            .frame(width: 170, height: 70)
        )
        .offset(CGSize(width: 0, height: showImagePicker ? 0 : -6))
    }

}

//Dropdown
struct customDropdown: View {
    
    @Binding var question: String
    @Binding var answer: Cigarattes?
    let options: [Cigarattes] = cigarattesLists.lists
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("\(question)")
                .font(.secondary(.body))
                .padding(.bottom, 6)
            Picker("Select an option", selection: $answer) {
                ForEach(options) { option in
                    Text(option.name)
                }
            }
            .pickerStyle(.menu)
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

struct ImagePicker: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

//Slider
struct customSlider: View {
    
    @Binding var question: String
    @Binding var answer: Double
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text("\(question)")
                    .font(.secondary(.body))
                    .padding(.bottom, 6)
                Text("(on a scale of 10)")
                    .font(.secondary(.custom(12)))
                    .padding(.bottom, 6)
                Spacer()
                
            }
            HStack {
                Slider(value: $answer, in:1...10, step: 1.0)
                Text("\(Int(answer))")
                    .font(.secondary(.custom(12)))
                    .padding(.bottom, 6)
            }
        }
        .frame(width:.infinity, height:82)
    }
}

//button form
struct customButton: View {
    
    var text: String
    @State private var didTap:Bool = false
    
    var body: some View {
        Button {
            self.didTap.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                self.didTap.toggle()
            }
        } label : {
            Text("\(self.text)")
                .font(.secondary(.body))
                .foregroundColor(.black)
                .offset(CGSize(width: 0, height: didTap ? 4 : -6))
                .animation(nil)
        }
        .frame(width: 240, height: 80, alignment: .center)
        .padding(.all, 20)
        .background(Image(didTap ? "boardPressed" : "board")
            .resizable()
            .frame(width: 240, height: 80)
        )
    }
}

struct customActionButton:View {
    var text: String
    @State private var didTap:Bool = false
    
    var body: some View {
        ZStack {
            Image("blankRectangleGray")
                .resizable()
                .frame(width: 91.38, height: 38)
            Text("\(text)")
                .foregroundColor(.black)
                .font(.secondary(.body))
                .offset(CGSize(width: -2, height: -2))
        }
    }
}

//custom generate field
struct customGenerateField : View {
    
    @ObservedObject var tvm: TeamViewModel
    @Binding var invitationCode: String
    @State private var emptyString: String = ""
    
    @State private var generateAlert: Bool = false
    @State private var didTap:Bool = false
    
    var body : some View{
        VStack (alignment: .leading) {
            HStack{
                Text("**Invitation Code**")
                    .font(.secondary(.body))
                    .padding(.bottom, 6)
                Spacer()
                Button {
                    generateAlert.toggle()
                    invitationCode = tvm.generateRandomStrings()
                    self.didTap.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                        self.didTap.toggle()
                    }
                } label : {
                    Text("Generate")
                        .font(.secondary(.caption))
                        .foregroundColor(.black)
                        .offset(CGSize(width: 0, height: didTap ? 4 : -6))
                        .animation(nil)
                }
                .frame(width: 90, height: 45, alignment: .center)
                .padding(.vertical, 10)
                .background(Image(didTap ? "boardPressed" : "board")
                    .resizable()
                    .frame(width: 90, height: 45)
                )
                .alert("Team Invitation Code", isPresented: $generateAlert){
                    Button("OK", action: {
                        generateAlert.toggle()
                    })
                    Button("Cancel", role: .cancel) {}
                } message: {
                    Text(invitationCode)
                }
            }
            TextField("", text: (!generateAlert && !invitationCode.isEmpty) ? $invitationCode : $emptyString)
                .font(.title)
                .autocapitalization(.none)
                .padding(.horizontal, 12)
                .frame(width:315, height:52)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color("SystemGray"), lineWidth: 2)
                )
        }
        .frame(width:315, height:82)
    }
}

//button nagivation bar atas (save, edit, create team, create)

//button navigation bar bawah
struct customNavigationButton: View {
    
    var text: String
    var page: Page
    var image: String
    @Binding var currentPage: Page
    
    var body: some View {
        Button {
            currentPage = self.page
        } label: {
            ZStack {
                Image((self.page == currentPage) ? "blankSquarePressed" : "blankSquare")
                    .resizable()
                    .frame(width: 80, height: 73.89)
                
                VStack {
                    Image("\(self.image)")
                        .resizable()
                        .frame(width: 41, height: 41)
                        .padding(.bottom,-10)
                    Text("\(self.text)")
                        .font(.secondary(.caption))
                        .foregroundColor(.black)
                }
                .offset((self.page == currentPage) ? CGSize(width: 3, height: 5) : CGSize(width: -2, height: 0))
            }
            .animation(nil)
        }
        
    }
}


struct AppColor {
    static let primary1 = Color("blue")
    static let primary2 = Color("yellow")
    static let secondary = Color("green")
    static let tertiary = Color("yellow")
    private init() {}
}

struct customBackButton : View {
    
    var text: String

    var body: some View {
        HStack {
            Image("ButtonLeft")
                .resizable()
                .frame(width: 42, height: 40)
            Text("\(text)")
                .foregroundColor(.black)
                .font(.secondary(.body))
        }
    }
}

//MARK: ENUM2
enum faceImage : String {
    case happy = "happyface"
    case neutral = "neutralface"
    case sad = "sadface"
}

enum Page : String {
    case welcome
    case splashScreen
    case form
    case home
    case gangs
    case task
    case profile
    case editProfile
    case friend
    case leaderboard
    case createteam
    case mission
    case user
}


//MARK: EXTENSION2
//Text
extension Text {
    func customText(size:Double) -> some View {
        self.font(.secondary(.custom(Int(size))))
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

//alert
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




