//
//  Palette.swift
//  TimePlanner
//
//  Created by Coby on 9/20/24.
//

import SwiftUI

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = CGFloat((rgb >> 16) & 0xFF) / 255.0
        let g = CGFloat((rgb >>  8) & 0xFF) / 255.0
        let b = CGFloat((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    // Common
    static let common100 = UIColor(hex: "#FFFFFF")
    static let common0 = UIColor(hex: "#000000")
    
    // Neutral
    static let neutral99 = UIColor(hex: "#F7F7F7")
    static let neutral95 = UIColor(hex: "#DCDCDC")
    static let neutral90 = UIColor(hex: "#C4C4C4")
    static let neutral80 = UIColor(hex: "#B0B0B0")
    static let neutral70 = UIColor(hex: "#9B9B9B")
    static let neutral60 = UIColor(hex: "#8A8A8A")
    static let neutral50 = UIColor(hex: "#737373")
    static let neutral40 = UIColor(hex: "#5C5C5C")
    static let neutral30 = UIColor(hex: "#474747")
    static let neutral22 = UIColor(hex: "#303030")
    static let neutral20 = UIColor(hex: "#2A2A2A")
    static let neutral15 = UIColor(hex: "#1C1C1C")
    static let neutral10 = UIColor(hex: "#171717")
    static let neutral5 = UIColor(hex: "#0F0F0F")
    
    // CoolNeutral
    static let coolNeutral99 = UIColor(hex: "#F7F7F8")
    static let coolNeutral98 = UIColor(hex: "#F4F4F5")
    static let coolNeutral97 = UIColor(hex: "#EAEBEC")
    static let coolNeutral96 = UIColor(hex: "#E1E2E4")
    static let coolNeutral95 = UIColor(hex: "#DBDCDF")
    static let coolNeutral90 = UIColor(hex: "#C2C4C8")
    static let coolNeutral80 = UIColor(hex: "#AEB0B6")
    static let coolNeutral70 = UIColor(hex: "#989BA2")
    static let coolNeutral60 = UIColor(hex: "#878A93")
    static let coolNeutral50 = UIColor(hex: "#70737C")
    static let coolNeutral40 = UIColor(hex: "#5A5C63")
    static let coolNeutral30 = UIColor(hex: "#46474C")
    static let coolNeutral25 = UIColor(hex: "#3C383C")
    static let coolNeutral23 = UIColor(hex: "#333438")
    static let coolNeutral22 = UIColor(hex: "#2E2F33")
    static let coolNeutral20 = UIColor(hex: "#292A2D")
    static let coolNeutral17 = UIColor(hex: "#212225")
    static let coolNeutral15 = UIColor(hex: "#1B1C1E")
    static let coolNeutral10 = UIColor(hex: "#171718")
    static let coolNeutral7 = UIColor(hex: "#141415")
    static let coolNeutral5 = UIColor(hex: "#0F0F10")
    
    // Blue
    static let blue99 = UIColor(hex: "#F7FBFF")
    static let blue95 = UIColor(hex: "#EAF2FE")
    static let blue90 = UIColor(hex: "#C9DEFE")
    static let blue80 = UIColor(hex: "#9EC5FF")
    static let blue70 = UIColor(hex: "#69A5FF")
    static let blue60 = UIColor(hex: "#3385FF")
    static let blue55 = UIColor(hex: "#1A75FF")
    static let blue50 = UIColor(hex: "#0066FF")
    static let blue45 = UIColor(hex: "#005EEB")
    static let blue40 = UIColor(hex: "#0054D1")
    static let blue30 = UIColor(hex: "#003E9C")
    static let blue20 = UIColor(hex: "#002966")
    static let blue10 = UIColor(hex: "#001536")
    
    // Red
    static let red99 = UIColor(hex: "#FFFAFA")
    static let red95 = UIColor(hex: "#FEECEC")
    static let red90 = UIColor(hex: "#FED5D5")
    static let red80 = UIColor(hex: "#FFB5B5")
    static let red70 = UIColor(hex: "#FF8C8C")
    static let red60 = UIColor(hex: "#FF6363")
    static let red50 = UIColor(hex: "#FF4242")
    static let red40 = UIColor(hex: "#E52222")
    static let red30 = UIColor(hex: "#B00C0C")
    static let red20 = UIColor(hex: "#730303")
    static let red10 = UIColor(hex: "#3B0101")
    
    // Green
    static let green99 = UIColor(hex: "#F2FFF6")
    static let green95 = UIColor(hex: "#D9FFE6")
    static let green90 = UIColor(hex: "#ACFCC7")
    static let green80 = UIColor(hex: "#7DF5A5")
    static let green70 = UIColor(hex: "#49E57D")
    static let green60 = UIColor(hex: "#1ED45A")
    static let green50 = UIColor(hex: "#00BF40")
    static let green40 = UIColor(hex: "#009632")
    static let green30 = UIColor(hex: "#006E25")
    static let green20 = UIColor(hex: "#004517")
    static let green10 = UIColor(hex: "#00240C")
    
    // Orange
    static let orange99 = UIColor(hex: "#FFFCF7")
    static let orange95 = UIColor(hex: "#FEF4E6")
    static let orange90 = UIColor(hex: "#FEE6C6")
    static let orange80 = UIColor(hex: "#FFD49C")
    static let orange70 = UIColor(hex: "#FFC06E")
    static let orange60 = UIColor(hex: "#FFA938")
    static let orange50 = UIColor(hex: "#FF9200")
    static let orange40 = UIColor(hex: "#D47800")
    static let orange30 = UIColor(hex: "#9C5800")
    static let orange20 = UIColor(hex: "#663A00")
    static let orange10 = UIColor(hex: "#361E00")
    
    // RedOrange
    static let redOrange99 = UIColor(hex: "#FFFAF7")
    static let redOrange95 = UIColor(hex: "#FEEEE5")
    static let redOrange90 = UIColor(hex: "#FED9C4")
    static let redOrange80 = UIColor(hex: "#FFBD96")
    static let redOrange70 = UIColor(hex: "#FF9B61")
    static let redOrange60 = UIColor(hex: "#FF7B2E")
    static let redOrange50 = UIColor(hex: "#FF5E00")
    static let redOrange40 = UIColor(hex: "#C94A00")
    static let redOrange30 = UIColor(hex: "#913500")
    static let redOrange20 = UIColor(hex: "#592100")
    static let redOrange10 = UIColor(hex: "#290F00")
    
    // Lime
    static let lime99 = UIColor(hex: "#F8FFF2")
    static let lime95 = UIColor(hex: "#E6FFD4")
    static let lime90 = UIColor(hex: "#CCFCA9")
    static let lime80 = UIColor(hex: "#AEF779")
    static let lime70 = UIColor(hex: "#88F03E")
    static let lime60 = UIColor(hex: "#6BE016")
    static let lime50 = UIColor(hex: "#58CF04")
    static let lime40 = UIColor(hex: "#48AD00")
    static let lime30 = UIColor(hex: "#347D00")
    static let lime20 = UIColor(hex: "#225200")
    static let lime10 = UIColor(hex: "#112900")
    
    // Cyan
    static let cyan99 = UIColor(hex: "#F7FEFF")
    static let cyan95 = UIColor(hex: "#DEFAFF")
    static let cyan90 = UIColor(hex: "#B5F4FF")
    static let cyan80 = UIColor(hex: "#8AEDFF")
    static let cyan70 = UIColor(hex: "#57DFF7")
    static let cyan60 = UIColor(hex: "#28D0ED")
    static let cyan50 = UIColor(hex: "#00BDDE")
    static let cyan40 = UIColor(hex: "#0098B2")
    static let cyan30 = UIColor(hex: "#006F82")
    static let cyan20 = UIColor(hex: "#004854")
    static let cyan10 = UIColor(hex: "#00252B")
    
    // LightBlue
    static let lightBlue99 = UIColor(hex: "#F7FDFF")
    static let lightBlue95 = UIColor(hex: "#E5F6FE")
    static let lightBlue90 = UIColor(hex: "#C4ECFE")
    static let lightBlue80 = UIColor(hex: "#A1E1FF")
    static let lightBlue70 = UIColor(hex: "#70D2FF")
    static let lightBlue60 = UIColor(hex: "#3DC2FF")
    static let lightBlue50 = UIColor(hex: "#00AEFF")
    static let lightBlue40 = UIColor(hex: "#008DCF")
    static let lightBlue30 = UIColor(hex: "#006796")
    static let lightBlue20 = UIColor(hex: "#004261")
    static let lightBlue10 = UIColor(hex: "#002130")
    
    // Violet
    static let violet99 = UIColor(hex: "#FBFAFF")
    static let violet95 = UIColor(hex: "#F0ECFE")
    static let violet90 = UIColor(hex: "#DBD3FE")
    static let violet80 = UIColor(hex: "#C0B0FF")
    static let violet70 = UIColor(hex: "#9E86FC")
    static let violet60 = UIColor(hex: "#7D5EF7")
    static let violet50 = UIColor(hex: "#6541F2")
    static let violet40 = UIColor(hex: "#4F29E5")
    static let violet30 = UIColor(hex: "#3A16C9")
    static let violet20 = UIColor(hex: "#23098F")
    static let violet10 = UIColor(hex: "#11024D")
    
    // Purple
    static let purple99 = UIColor(hex: "#FEFBFF")
    static let purple95 = UIColor(hex: "#F9EDFF")
    static let purple90 = UIColor(hex: "#F2D6FF")
    static let purple80 = UIColor(hex: "#E9BAFF")
    static let purple70 = UIColor(hex: "#DE96FF")
    static let purple60 = UIColor(hex: "#D478FF")
    static let purple50 = UIColor(hex: "#CB59FF")
    static let purple40 = UIColor(hex: "#AD36E3")
    static let purple30 = UIColor(hex: "#861CB8")
    static let purple20 = UIColor(hex: "#580A7D")
    static let purple10 = UIColor(hex: "#290247")
    
    // Pink
    static let pink99 = UIColor(hex: "#FFFAFE")
    static let pink95 = UIColor(hex: "#FEECFB")
    static let pink90 = UIColor(hex: "#FED3F7")
    static let pink80 = UIColor(hex: "#FFB8F3")
    static let pink70 = UIColor(hex: "#FF94ED")
    static let pink60 = UIColor(hex: "#FA73E3")
    static let pink50 = UIColor(hex: "#F553DA")
    static let pink40 = UIColor(hex: "#D331B8")
    static let pink30 = UIColor(hex: "#A81690")
    static let pink20 = UIColor(hex: "#730560")
    static let pink10 = UIColor(hex: "#3D0133")
}
