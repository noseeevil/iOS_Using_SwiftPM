/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import Foundation

extension UserDefaults {
  static let encoder = JSONEncoder()

  struct Keys {
    static let selectedPen = "SelectedPen"
    static let settingActivated = "SettingActivated"
  }

  static var selectedPen: Pen {
    get {
      if let savedPen = UserDefaults.standard.data(forKey: Keys.selectedPen) {
          let decoder = JSONDecoder()
          if let decodedPen = try? decoder.decode(Pen.self, from: savedPen) {
              return decodedPen
          }
      }
      return SettingsStore.getAvailablePens()[0]
    }
    set {
      if let encodedPen = try? encoder.encode(newValue) {
        UserDefaults.standard.set(encodedPen, forKey: Keys.selectedPen)
      }
    }
  }

  static var settingActivated: Bool {
    get {
      return UserDefaults.standard.bool(forKey: Keys.settingActivated)
    }
    set {
      UserDefaults.standard.set(newValue, forKey: Keys.settingActivated)
    }
  }
}
