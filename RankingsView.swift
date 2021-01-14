//
//  RankingsView.swift
//  DDCFormater
//
//  Created by Travis Finucane on 1/13/21.
//

import Foundation
import SwiftUI

struct RankingsView: View {
    

    var body: some View {
    VStack(alignment: .leading) {
            Form {
                Section(header: Text("Results").font(.caption)) {
                    /*
                    HStack() {
                        Text("player").font(.bold)
                        Text("wins").font(.bold)
                        Text("+/-").font(.bold)
                        Text("tot").font(.bold)

                    }
 */
            
                    ForEach(selectedPlayers.players.filter({$0.active}), id: \.self) { player in
                        HStack() {
                            Text(player.name)
                            let total_score = player.todaysScores.reduce(0, +)
                            let wins = player.wins.reduce(0, +)
                            let diff = player.todaysPointDiffs.reduce(0, +)
                            Text(verbatim: "w: \(wins)")
                            Text(verbatim: "+/-: \(diff)")
                            Text(verbatim: "t: \(total_score)")
                        }
                    }
                }
            }
        }
        .frame(alignment: .leading)
    }
}

struct RankingsView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            RankingsView()
                .alignmentGuide(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=Guide@*/.top/*@END_MENU_TOKEN@*/) { dimension in
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/dimension[.top]/*@END_MENU_TOKEN@*/
                }
        }

    }

}
