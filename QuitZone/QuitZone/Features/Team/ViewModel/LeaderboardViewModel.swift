//
//  LeaderboardViewModel.swift
//  QuitZone
//
//  Created by Leonardo Wijaya on 06/05/23.
//

import Foundation
import CoreData

class LeaderboardViewModel: ObservableObject {
    
    @Published var team: Team
    @Published var leaderboards: [Member] = []
    
    init(team: Team)
    {
        self.team = team
        getAllMembers()
    }
    
    func getAllMembers() {
        let request: NSFetchRequest<Member> = Member.fetchRequest()
        request.predicate = NSPredicate(format: "team == %@", self.team)
        
        do {
            let results = try PersistenceController.shared.viewContext.fetch(request)
            if results.count > 0 {
                for result in results {
                    leaderboards.append(result)
                }
            }
        } catch let error as NSError {
            print("Error fetching records: \(error)")
        }
        self.sortLeaderboard()
    }
    
    private func sortLeaderboard() {
        guard leaderboards.count > 1 else { return }
        for i in 0..<leaderboards.count {
            var swapped = false
            for j in 1..<leaderboards.count-i {
                if leaderboards[j-1].score < leaderboards[j].score {
                    leaderboards.swapAt(j-1, j)
                    swapped = true
                }
            }
            
            if !swapped { return }
        }
    }
    
}
