//
//  MissionComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct MissionData: Identifiable {
    let id = UUID()
    let missionTitle: String
    let missionText: String
    var isDone = false
}

func dummyMission() -> [MissionData] {
    let dummy: [MissionData] = [
        MissionData(missionTitle: "Mission 1", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 2", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 3", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 4", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 5", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 6", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 7", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 8", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 9", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 10", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 11", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 12", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 13", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 14", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 15", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 16", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 17", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 18", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 19", missionText: "Dummy Missin Text"),
        MissionData(missionTitle: "Mission 20", missionText: "Dummy Missin Text")
    ]
    
    return dummy
}


struct MissionComponent: View {
    
    let columns = Array(repeating: GridItem(), count: 5)
    @State private var isMissionShowed = false
    @State private var index: Int = -1
    @State private var data = dummyMission()

    
    var body: some View {
        ZStack {
            //mission page
            VStack {
                Text("**Your Mission**")
                    .customText(size: 36)
                    .hAlign(.leading)
                    .padding(.bottom, 90)
                
                //mission grid
                LazyVGrid(columns: columns) {
                    ForEach(data.indices, id: \.self) {idx in
                        VStack {
                            Text("")
                        }
                        .frame(width: 60, height: 60)
                        .background(
                            Rectangle()
                                .fill(data[idx].isDone ? .green : .white)
                                .background(
                                    Rectangle()
                                        .stroke()
                                )
                        )
                        .padding(1)
                        .onTapGesture {
                            withAnimation {
//                                isMissionShowed = true
                                index = idx
                                customMissionAlert(title: data[index].missionTitle,
                                                            message: data[index].missionText,
                                                            leftButton: "Cancel",
                                                            rightButton: data[index].isDone ? "Unmark" : "Mark as Done",
                                                            leftAction: {
                                                                  print("cancelled")
                                                             },
                                                            rightAction: {
                                                                 data[index].isDone.toggle()
                                                             })
                            }
                           
                        }
                    }
                }
                .hAlign(.center)
            }
            .vAlign(.top)
            .padding()
            .blur(radius: isMissionShowed ? 1:0)
            
            
            //show mission
//            if isMissionShowed {
//                MissionAlert(isMissionShowed: $isMissionShowed,
//                             idx: $index,
//                             data: $data
//                )
//            }
        }
    }
}

struct MissionAlert: View {
    @Binding var isMissionShowed: Bool
    @Binding var idx: Int
    @Binding var data: [MissionData]
    
    var body: some View {
        
        VStack {
            Text("**\(data[idx].missionTitle)**")
                .customText(size: 24)
                .padding(.bottom, 30)
            Text("\(data[idx].missionText)")
                .customText(size: 20)
            
            //button
            HStack {
                Button("Cancel") {
                    isMissionShowed = false
                }
                
                Spacer()
                
                Button(data[idx].isDone ? "UnMark" : "Mark as Done") {
                    data[idx].isDone.toggle()
                    isMissionShowed = false
                }
            }
            .padding()
        }
        .frame(width: 280, height: 200, alignment: .center)
        .background(.green)
        .clipShape(RoundedRectangle(cornerRadius: 25))
        .padding()
    }
    
}

//optional
extension View {
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

    //showing alert controller
    func alertController() -> UIViewController {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {return .init()}
        guard let root = screen.windows.first?.rootViewController else {return .init()}
        
        return root
    }

}


struct MissionComponent_Previews: PreviewProvider {
    static var previews: some View {
        MissionComponent()
    }
}
