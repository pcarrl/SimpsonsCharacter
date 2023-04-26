import Foundation

class CharacterListViewModel {
    private let fullList: [Character]

    var filteredList: [Character] = [] {
        didSet {
            NotificationCenter.default.post(name: Notification.Name("RefreshTable"), object: nil)
        }
    }

    init(characters: [Character]) {
        self.fullList = characters
        self.filteredList = fullList
    }

    func getCharacterName(name: String) -> String {
        return name.replacingOccurrences(of: "https://duckduckgo.com/", with: "")
            .replacingOccurrences(of: "_", with: " ")
    }

    func searchList(query: String) {
        guard query.isEmpty == false else {
            resetList()
            return
        }
        let newList = fullList.filter { character in
            character.name?.contains(query) == true || character.text?.contains(query) == true
        }
        filteredList = newList
    }

    func resetList() {
        filteredList = fullList
    }
}
