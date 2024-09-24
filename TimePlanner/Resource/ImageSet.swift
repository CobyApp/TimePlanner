//
//  ImageSet.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import UIKit

extension UIImage {
    
    enum Button {
        static let back = UIImage(name: "back")!
        static let forward = UIImage(name: "forward")!
        static let person = UIImage(name: "person")!
        static let close = UIImage(name: "close")!
        static let more = UIImage(name: "more")!
        static let plus = UIImage(name: "plus")!
        static let checkboxOff = UIImage(name: "checkbox_off")!
        static let checkboxOn = UIImage(name: "checkbox_on")!
        static let setting = UIImage(name: "setting")!
        static let search = UIImage(name: "search")!
        static let home = UIImage(name: "home")!
        static let note = UIImage(name: "note")!
        static let calendarClock = UIImage(name: "calendar_clock")!
    }
    
    enum Icon {
        static let logo = UIImage(name: "logo")!
    }
}

extension UIImage {
    convenience init?(name: String) {
        self.init(named: name, in: nil, compatibleWith: nil)
    }
    
    func resize(to size: CGSize) -> UIImage {
        let image = UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        return image
    }
}
