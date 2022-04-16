import Foundation
import Yams


struct Pen: Codable, Hashable, Identifiable {
  var id: Int { hashValue }
  var key: String
  var label: String
  var url: URL
}

class SettingsStore: ObservableObject {

  static func getAvailablePens() -> [Pen] {
      // 1
      if let path = Bundle.main.path(forResource: "pens", ofType: "yml") {
        do {
          // 2
          let yamlString = try String(contentsOfFile: path)
          // 3
          let decoder = YAMLDecoder()
          return try decoder.decode([Pen].self, from: yamlString)
        } catch {
          print("Could not load pen JSON!")
        }
      }
      // 4
      return []
  }

  @Published var selectedPen: Pen = UserDefaults.selectedPen {
    didSet {
      UserDefaults.selectedPen = selectedPen
    }
  }
}
