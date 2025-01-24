//
//  Extensions.swift
//  MissedCallAlert
//
//  Created by Abdul Motalab Rakib on 14/10/24.
//

import Foundation
import UIKit
import SDWebImage

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.hasPrefix("#") ? String(hexSanitized.dropFirst()) : hexSanitized

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 15.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                return window.safeAreaInsets.top > 20
            }
        } else {
            // Fallback for iOS < 15
            if let window = UIApplication.shared.windows.first {
                return window.safeAreaInsets.top > 20
            }
        }
        return false
    }
}

extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self)
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? {
          guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
                let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
                let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
          return prettyPrintedString
      }
}

extension String {
    var isReallyEmpty: Bool {
        return self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Array {
    subscript(indexChecked index: Int) -> Element? {
        return (index < count) ? self[index] : nil
    }
}

extension UIImageView {
    func setSDImage(URL urlString:String!, placeholderImageName: String = "preview_placeholder") {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: UIImage.init(named: placeholderImageName), options: .progressiveLoad, completed: nil)
        }
        else {
            self.image = UIImage.init(named: placeholderImageName)
        }
    }
    
    func setSplashSDImage(URL urlString: String?) {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.sd_setImage(with: url, placeholderImage: nil, options: .progressiveLoad, completed: nil)
        }
    }
}


func formattedDateString(_ dateString: String) -> String {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "dd/MM/yy"

        let outputDateString = outputFormatter.string(from: date)
        debugPrint("Formatted Date: \(outputDateString)")
        return outputDateString
    } else {
        debugPrint("Invalid date format")
        return ""
    }
}

func formattedToDayString(_ dateTimeString: String) -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"

    if let date = inputFormatter.date(from: dateTimeString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "EEEE d MMMM"

        let outputDateString = outputFormatter.string(from: date)
        debugPrint("Formatted Date: \(outputDateString)")
        return outputDateString
    } else {
        debugPrint("Invalid date format")
        return ""
    }
}
