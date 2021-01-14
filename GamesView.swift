//
//  GamesView.swift
//  DDCFormater
//
//  Created by Travis Finucane on 1/11/21.
//

import Foundation
import SwiftUI



let formats  = [
    5: [
        [[1,2], [3,5]],
        [[1,3], [4,5]],
        [[2,5], [3,4]],
        [[1,5], [2,4]],
        [[1,4], [2,3]],
    ],
    6: [
        [[1,3], [4,6]],
        [[1,4], [2,5]],
        [[2,4], [3,6]],
        [[1,6], [3,5]],
        [[4,5], [2,6]],
        [[1,5], [2,3]],
    ],
    7: [
        [[1,6],[2,3]],
        [[5,7],[2,4]],
        [[4,7],[1,3]],
        [[6,7],[1,5]],
        [[2,7],[3,5]],
        [[4,6],[1,7]],
        [[2,6],[3,7]],
        [[3,6],[4,5]],
        [[1,4],[2,5]],
    ],
    8: [
        [[1,3],[6,8]],
        [[2,4],[5,7]],
        [[1,6],[4,7]],
        [[3,8],[2,5]],
        [[1,2],[7,8]],
        [[3,4],[5,6]],
        [[1,5],[2,6]],
        [[4,8],[3,7]],
        [[1,8],[4,5]],
        [[2,7],[3,6]],
        [[1,7],[3,5]],
        [[4,6],[2,8]],
        [[1,4],[2,3]],
        [[6,7],[5,8]],
     ],
    9: [
        [[6,7],[8,9]],
        [[2,5],[3,4]],
        [[6,8],[7,9]],
        [[1,5],[2,4]],
        [[6,9],[7,8]],
        [[1,2],[3,5]],
        [[7,2],[6,8]],
        [[1,3],[4,5]],
        [[6,5],[7,9]],
        [[1,4],[2,3]],
        [[6,4],[2,3]],
        [[9,1],[8,5]],
        [[7,5],[9,3]],
        [[8,2],[1,4]],
        [[6,3],[1,2]],
        [[8,1],[7,9]],
        [[6,9],[1,5]],
        [[7,8],[3,4]],
    ],
    10: [
        [[1,2],[3,5]],
        [[6,7],[8,10]],
        [[1,3],[4,5]],
        [[6,8],[9,10]],
        [[1,5],[2,4]],
        [[6,10],[7,9]],
        [[2,5],[3,4]],
        [[7,9],[8,9]],
        [[1,4],[2,3]],
        [[6,9],[7,8]],
        [[1,2],[8,10]],
        [[6,7],[3,5]],
        [[1,3],[9,10]],
        [[6,8],[4,5]],
        [[1,5],[7,9]],
        [[6,10],[2,4]],
        [[2,5],[8,9]],
        [[7,10],[3,4]],
        [[1,4],[7,8]],
        [[6,9],[2,3]],
    ],
    11: [
        [[7,8],[9,11]],
        [[1,3],[2,5]],
        [[7,9],[10,11]],
        [[1,4],[2,6]],
        [[7,10],[8,9]],
        [[1,6],[3,5]],
        [[7,11],[8,10]],
        [[4,6],[2,5]],
        [[8,11],[9,10]],
        [[1,5],[2,4]],
        [[7,8],[1,2]],
        [[3,6],[4,5]],
        [[10,11],[5,6]],
        [[7,9],[1,3]],
        [[7,11],[2,4]],
        [[8,9],[3,5]],
        [[9,10],[3,4]],
        [[8,11],[1,6]],
        [[7,10],[1,5]],
        [[3,4],[2,6]],
        [[8,10],[2,3]],
        [[9,11],[4,6]],
    ],
    12: [
        [[1,3], [4,6]],
        [[7,9], [10,12]],
        [[1,4], [2,5]],
        [[7,10], [8,11]],
        [[2,4], [3,6]],
        [[8,10], [9,12]],
        [[1,6], [3,5]],
        [[7,12], [9,11]],
        [[4,5], [2,6]],
        [[10,11], [8,12]],
        [[1,5], [2,3]],
        [[7,11], [8,9]],
    ],
    13: [
        [[1,6],[2,3]],
        [[8,10],[11,13]],
        [[5,7],[2,4]],
        [[8,11],[9,12]],
        [[4,7],[1,3]],
        [[9,11],[10,13]],
        [[6,7],[1,5]],
        [[8,13],[10,12]],
        [[2,7],[3,5]],
        [[11,12],[9,6]],
        [[4,6],[1,7]],
        [[8,12],[9,10]],
        [[2,6],[3,7]],
        [[3,6],[4,5]],
        [[1,4],[2,5]],
    ],
]


struct Team {
    var player1: Player
    var player2: Player
    func setWin(game_index: Int) {
        player1.wins[game_index] = 1
        player2.wins[game_index] = 1
    }
    func setLoss(game_index: Int) {
        player1.wins[game_index] = 0
        player2.wins[game_index] = 0
    }
    func setScore(game_index: Int, score: Int) {
        player1.todaysScores[game_index] = score
        player2.todaysScores[game_index] = score
    }
    func setDiff(game_index: Int, diff: Int) {
        player1.todaysPointDiffs[game_index] = diff
        player2.todaysPointDiffs[game_index] = diff
    }
}

struct Game {
    var game_index: Int
    var team1: Team
    var team2: Team
    var scores: [Int] = [0,0]
    
    init(fromPlayers players: [Player], format: [[Int]], gindex: Int ) {
        let player1 = players[format[0][0]-1]
        let player2 = players[format[0][1]-1]
        let player3 = players[format[1][0]-1]
        let player4 = players[format[1][1]-1]
        team1 = Team(player1: player1, player2: player2)
        team2 = Team(player1: player3, player2: player4)
        game_index = gindex
        
    }

    
    func publishResults() {
        team1.setScore(game_index: game_index, score: scores[0])
        team2.setScore(game_index: game_index, score: scores[1])
        team1.setDiff(game_index: game_index, diff: scores[0]-scores[1])
        team2.setDiff(game_index: game_index, diff: scores[1]-scores[0])
        if (scores[0] > scores[1] ) {
            team1.setWin(game_index: game_index)
            team2.setLoss(game_index: game_index)
        } else if (scores[0] < scores[1] ) {
            team2.setWin(game_index: game_index)
            team1.setLoss(game_index: game_index)
        } else {
            team1.setLoss(game_index: game_index)
            team2.setLoss(game_index: game_index)
        }
    }
    
    func getPlayer(team_index: Int, player_index: Int) -> Player {
        var player: Player
        if (team_index == 0) {
            if (player_index == 0) {
                player = team1.player1
            } else {
                player = team1.player2
            }
        } else {
            if (player_index == 0) {
                player = team2.player1
            } else {
                player = team2.player2
            }
        }
        return player
    }
    
}


struct GamesView: View {
    var rounds: Int
    var fields: Int
 
    var round_count = 1;

    @State var todaysScores = Array(repeating: Array(repeating: 0, count: 2), count: 30)
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section(header: Text("Games").font(.caption)) {
            
                    let players: [Player] = selectedPlayers.getRandomPlayers()

                    if let format = formats[players.count] {
                        ForEach(format.indices, id: \.self) { game_index in
                            Text("game \(game_index + 1)").bold()

                            var game = Game(fromPlayers: players, format: format[game_index], gindex: game_index)
                            ForEach(format[game_index].indices, id: \.self) { team_index in
                                
                                let player1 = game.getPlayer(team_index: team_index, player_index: 0)
                                let player2 = game.getPlayer(team_index: team_index, player_index: 1)

                                let scoreUpdater = Binding<Int>(get: {
                                    return self.todaysScores[game_index][team_index]
                                }, set: {
                                    self.todaysScores[game.game_index][team_index] = $0

                                    game.scores = [self.todaysScores[game.game_index][0], self.todaysScores[game.game_index][1]]
                                    game.publishResults()
                                    
                                })
                                HStack {
                                    Text("\(player1.name), \(player2.name)")
                                    Picker(selection: scoreUpdater, label: Text("")) {
                                        ForEach(0..<15) { x in
                                            Text("\(x)")
                                        }
                                    }
                                }
                            }
                        }
                        NavigationLink(destination: RankingsView()) {
                            Text("show rankings")
                        }
                    }
                }
            }
        }
        .frame(alignment: .leading)
    }
}



struct GamesView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            GamesView(rounds:1,fields:2)
                .alignmentGuide(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Guide@*/.top/*@END_MENU_TOKEN@*/) { dimension in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
        }

    }

}
