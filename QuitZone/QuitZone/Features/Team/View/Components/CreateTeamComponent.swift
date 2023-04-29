//
//  CreateTeamComponent.swift
//  QuitZone
//
//  Created by Jonathan Evan Christian on 19/04/23.
//

import SwiftUI

struct Person: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var isSelected = false
}

struct CreateTeamComponent: View {
    
    @State private var name: String = ""
    @State private var description: String = ""
    
    @State private var showingSheet = false

    var body: some View {
        NavigationStack {
            Form {
                Section{
                    Text("**Name**")
                        .hAlign(.leading)
                    TextField("Input your name...", text: $name)
                }

                Section{
                        Text("**Group Description**")
                            .hAlign(.leading)
                        TextField("Describe the group...", text: $description)
                            .frame(height: 100)
                }
                
                Section {
                    Text("**Participants**")
                    Button("Add new participants"){
                        showingSheet.toggle()
                    }
                    .sheet(isPresented: $showingSheet) {
                        AddParticipantsView()
                    }
                }
            }
            .navigationTitle("Create New Team")
            .navigationBarItems(trailing:
                Button("Add"){
                
                }
            )
        }

    }
    
}

struct CreateTeamComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamComponent()
    }
}

struct AddParticipantsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var people = [
        Person(name: "Alice"),
        Person(name: "Bob"),
        Person(name: "Charlie"),
        Person(name: "David"),
        Person(name: "Emily")
    ]
    @State private var friends = [Person]()
    @State private var searchText = ""
    
    var filteredPeople: [Person] {
        if searchText.isEmpty {
            return people
        } else {
            return people.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Search")) {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                }
                
                Section(header: Text("People")) {
                    ForEach(filteredPeople) { person in
                        HStack {
                            Text(person.name)
                            Spacer()
                            if person.isSelected {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            if let index = people.firstIndex(where: { $0.id == person.id }) {
                                people[index].isSelected.toggle()
                            }
                        }
                    }
                }
                
                Section(header: Text("Friends")) {
                    ForEach(friends) { friend in
                        HStack {
                            Text(friend.name)
                            Spacer()
                            Button(action: {
                                if let indexFriends = friends.firstIndex(where: { $0.id == friend.id }) {
                                    friends.remove(at: indexFriends)
                                }
                                if let indexPeople = people.firstIndex(where: { $0.id == friend.id }) {
                                    people[indexPeople].isSelected = false
                                }
                            }) {
                                Image(systemName: "minus.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Add Participants")
            .navigationBarItems(trailing:
                Button(action: {
                    friends.removeAll()
                    var selectedPeople = people.filter { $0.isSelected }
                    for person in selectedPeople {
                        friends.append(person)
                    }
                    for index in selectedPeople.indices {
                        selectedPeople[index].isSelected = false
                    }
                searchText = ""
                friends.sort { $0.name < $1.name }
                }) {
                    Text("Add Selected")
                }
                .disabled(people.filter { $0.isSelected }.isEmpty)
            )
        }
        .onAppear {
            friends.sort { $0.name < $1.name }
        }
    }
}

