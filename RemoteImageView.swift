import SwiftUI

public struct RemoteImageView<Content: View>: View {
  // 1
  @ObservedObject var imageFetcher: RemoteImageFetcher
  var content: (_ image: Image) -> Content
  let placeHolder: Image

  // 2
  @State var previousURL: URL? = nil
  @State var imageData: Data = Data()

  // 3
  public init(
    placeHolder: Image,
    imageFetcher: RemoteImageFetcher,
    content: @escaping (_ image: Image) -> Content
  ) {
    self.placeHolder = placeHolder
    self.imageFetcher = imageFetcher
    self.content = content
  }

  // 4
  public var body: some View {
    DispatchQueue.main.async {
      if (self.previousURL != self.imageFetcher.getUrl()) {
        self.previousURL = self.imageFetcher.getUrl()
      }

      if (!self.imageFetcher.imageData.isEmpty) {
        self.imageData = self.imageFetcher.imageData
      }
    }

    let uiImage = imageData.isEmpty ? nil : UIImage(data: imageData)
    let image = uiImage != nil ? Image(uiImage: uiImage!) : nil;

    // 5
    return ZStack() {
      if image != nil {
        content(image!)
      } else {
        content(placeHolder)
      }
    }
    .onAppear(perform: loadImage)
  }

  // 6
  private func loadImage() {
    imageFetcher.fetch()
  }
}
