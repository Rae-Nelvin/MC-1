//
//  CloudKitUserViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 21/04/23.
//

import CloudKit
import SwiftUI

class iCloudViewModel: ObservableObject {
    @Published var permissionStatus: Bool = false
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    @Published var userName: String = ""
    
    init() {
        getiCloudStatus()
        requestPermission()
        fetchiCloudUserRecord()
    }
    
    private func getiCloudStatus() {
        CKContainer.default().accountStatus{ [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available:
                    self?.isSignedInToiCloud = true
                case .noAccount:
                    self?.error = CloudKitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine:
                    self?.error = CloudKitError.iCloudAccountNotDetermined.rawValue
                case .restricted:
                    self?.error = CloudKitError.iCloudAccountRestricted.rawValue
                default:
                    self?.error = CloudKitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudKitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
    
    func requestPermission() {
        CKContainer.default().requestApplicationPermission([.userDiscoverability]) { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                if returnedStatus == .granted {
                    self?.permissionStatus = true
                }
            }
        }
    }
    
    func fetchiCloudUserRecord() {
        CKContainer.default().fetchUserRecordID { [weak self] returnedID, returnedError in
            if let id = returnedID {
                self?.discoveriCloudUser(id: id)
            }
        }
    }
    
    func discoveriCloudUser(id: CKRecord.ID){
        CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedIdentity, returnedError in
            DispatchQueue.main.async {
                if let name = returnedIdentity?.nameComponents?.givenName {
                    self?.userName = name
                }
            }
        }
    }
}

// For Testing Purposes Delete Later
struct CloudKitUser: View {
    @StateObject private var vm: iCloudViewModel = iCloudViewModel()
    var container: CKContainer
    
    var body: some View {
        NavigationView {
            VStack {
                Text("IS SIGNED IN: \(vm.isSignedInToiCloud.description.uppercased())")
                Text(vm.error)
                Text("Permission: \(vm.permissionStatus.description.uppercased())")
                Text("Name: \(vm.userName)")
                NavigationLink(destination: PlayerView(pvm: PlayerViewModel(container: container)), label: {
                    Text("Next")
                })
            }
        }
    }
}

struct CloudKitUser_Previews: PreviewProvider {
    static var previews: some View {
        CloudKitUser(container: CKContainer.default())
    }
}
