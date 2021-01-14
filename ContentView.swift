import SwiftUI

class Player {
    var name: String
    var wins: [Int]
    var todaysScores: [Int]
    var todaysPointDiffs: [Int]
    var active: Bool
    init(fromName playerName: String) {
        name = playerName
        todaysScores = Array(repeating: 0, count: 30)
        todaysPointDiffs = Array(repeating: 0, count: 30)
        wins = Array(repeating: 0, count: 30)
        active = false
    }
    func toggle() -> Bool {
        active = !active
        return active
    }
    
    func isActive() -> Bool {
        return active
    }
}

extension Player: Hashable {
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}

class PlayersToday: ObservableObject {
    
    @Published var players = [Player]()
    var emptyPlayer = Player(fromName: "")
    var shufflePlayers: [Player] = []
    init(fromPlayerNames playerNames: [String]) {
        for name in playerNames {
            players.append(Player(fromName: name))
        }
    }
    func getPlayerByName(name: String) -> Player {
        let player = players.first{ $0.name == name } ?? emptyPlayer
        return player
    }
    func getRandomPlayers() -> [Player] {
        if (shufflePlayers.count == 0) {
            shufflePlayers = players.filter({$0.active}).shuffled()
        }
        return shufflePlayers
    }

}
var allPlayers = ["Travis", "Terry", "Rick", "Doug", "LittleDoug", "Gary", "Sexter", "Lance", "Jen-O", "Greg", "Ali", "Brendan", "Dana", "Bill", "PlayerX", "PlayerY"]
var selectedPlayers = PlayersToday(fromPlayerNames: allPlayers)




struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(self.title)
                if self.isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}



struct ContentView: View {
    @State private var showPlayerSheet = false

   // @State var allPlayerNames = ["Travis", "Terry", "Doug", "Little Doug", "Mike", "Lance"]
   
    // @ObservedObject var selectedPlayers: PlayersToday
    @State var rounds = 1
    @State var fields = 1
    
    var body: some View {
        NavigationView {
              VStack {
                
                  Form {
                    
                    Section(header: Text("Todays Format").font(.caption)) {
                          Button(action: {
                              self.showPlayerSheet.toggle()
                          }) {
                              HStack {
                                  Text("Choose Players").foregroundColor(Color.black)
                                  Spacer()
                                  Text("among \(allPlayers.count)")
                                      .foregroundColor(Color(UIColor.systemGray))
                                      .font(.body)
                                  Image(systemName: "chevron.right")
                                      .foregroundColor(Color(UIColor.systemGray4))
                                      .font(Font.body.weight(.medium))

                              }
                          }
                          .sheet(isPresented: $showPlayerSheet) {
                            SettingsPlayerPickerView()
                          }
            

                        Picker(selection: $rounds, label: Text("Rounds")) {
                            ForEach(1..<11) { x in
                                Text("\(x)")
                            }
                        }
                        
                        
                        Picker(selection: $fields, label: Text("Fields")) {
                            ForEach(1..<5) { x in
                                Text("\(x)")
                            }
                        }
                    
                        NavigationLink(destination: GamesView(rounds: self.rounds,
                                                              fields: self.fields)) {
                                                            /*  players: selectedPlayers.players.filter{$0.active})) {
 */
                            Text("show matchups")
                        }
                    }
                }
            }
            .navigationBarTitle("DDC")
        }
    }
}



struct SettingsPlayerPickerView: View {
    @State private var allPlayers = [Player]()


//    init(_ allPlayers: PlayersToday) {
//        self.selectedPlayers = selectedPlayers
//    }
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Choose today's players")) {
                    ForEach(selectedPlayers.players, id: \.self) { player in
                        MultipleSelectionRow(title: player.name, isSelected: allPlayers.contains(player)) {
                            let uplayer = selectedPlayers.getPlayerByName(name: player.name)
                            if (uplayer.toggle()) {
                                self.allPlayers.append(uplayer)
                            } else {
                                self.allPlayers.removeAll(where: { $0.name == player.name })
                            }
                        }
                    }
                }
            }
 
            .onAppear(perform: { self.allPlayers = selectedPlayers.players.filter{$0.active} })
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Players Today", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
//                    self.selectedPlayers.players = self.allPlayers
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("OK")
                }
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        Group {
            ContentView()
        }

    }

}
