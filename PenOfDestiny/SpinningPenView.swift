import SwiftUI
import RemoteImageView


struct SpinningPenView: View {
  @State var rotationAmount = 0.0
  @State var numberOfSegments = 6.0
  
  @ObservedObject var settingsStore = SettingsStore()
  
  func nextRotationAmount() -> Double {
    // Choose the next person
    let destinedPerson = Int.random(in: 1...Int(numberOfSegments))
    
    // Determine how much to rotate the pen back to the top
    let numberOfPreviousRotations = ceil(rotationAmount / 360)
    let nextCompleteRotation = numberOfPreviousRotations * 360
    let resetToTop = nextCompleteRotation - rotationAmount
    
    // Determine how far around the circle the pen should stop
    let segmentArc = 360 / numberOfSegments;
    let finishingPosition = Double((destinedPerson - 1)) * segmentArc
    
    // Spin at least 5 times
    let minSpin: Double = 360 * 5
    
    return resetToTop + minSpin + finishingPosition
  }
  
  var body: some View {
      
    let imageFetcher = RemoteImageFetcher(url: settingsStore.selectedPen.url)

      
    return VStack {
      Button(action: {
        withAnimation(.spring(response:1.25, dampingFraction:3.0, blendDuration:0.5)) {
          self.rotationAmount += self.nextRotationAmount()
        }
      }) {
          RemoteImageView(placeHolder: Image("sharpie"), imageFetcher: imageFetcher) {
            $0
              .resizable()
              .scaledToFit()
          }

      }
      .buttonStyle(PlainButtonStyle())
      .rotation3DEffect(.degrees(rotationAmount), axis: (x: 0, y: 0, z: 1))
      VStack {
        Slider(
          value: $numberOfSegments,
          in: 2...12,
          step: 1.0
        )
        Text("Select destiny between \(numberOfSegments, specifier: "%.f") people.")
      }
    }
    .navigationBarTitle("Pen of Destiny", displayMode: .large)
    .navigationBarItems(trailing:
      NavigationLink(destination: SettingsView(settingsStore: settingsStore)) {
        Image(systemName: "gear")
      }
    )
      .padding(.all)
  }
}

#if DEBUG
struct SpinningPenView_Previews: PreviewProvider {
  static var previews: some View {
    SpinningPenView()
  }
}
#endif
