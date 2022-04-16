import SwiftUI
import Combine

struct SettingsView: View {
  @ObservedObject var settingsStore: SettingsStore
  
  var body: some View {
    Form {
      Picker(selection: $settingsStore.selectedPen, label: Text("Pen")) {
        ForEach(SettingsStore.getAvailablePens(), id: \.id) { pen in
          Text(pen.label).tag(pen)
        }
      }
    }.navigationBarTitle("Settings", displayMode: .large)
  }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      SettingsView(settingsStore: SettingsStore())
    }
  }
}
#endif
