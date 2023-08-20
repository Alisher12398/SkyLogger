//
//  SkyExtensions.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 19.08.2023.
//

import UIKit

//MARK: - UINavigationBar
extension UINavigationBar {
    
    func configure() {
        tintColor = UIColor.skyTextWhite
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = false
        barTintColor = UIColor.skyBackground
        backgroundColor = UIColor.skyBackground
        superview?.backgroundColor = UIColor.skyBackground
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.skyTextWhite]
        titleTextAttributes = textAttributes
    }
    
}

//MARK: - Collection
extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
    
}

//MARK: - UIFont
extension UIFont {
    
    public class func light(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    public class func regular(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    public class func medium(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    public class func semibold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
    
    public class func bold(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
    
}

//MARK: - String
extension String {
    
    func width(font: UIFont) -> CGFloat {
        guard !self.isEmpty else { return 0 }
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes).width
    }
    
}

//MARK: - UILabel
extension UILabel {
    
    func addLeftVerticalLine(checkIsEmpty: Bool) {
        if checkIsEmpty, self.text?.isEmpty ?? true {
            return
        }
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        self.reAddSubview(view)
        NSLayoutConstraint.activate([
            view.rightAnchor.constraint(equalTo: self.leftAnchor, constant: -5),
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            view.widthAnchor.constraint(equalToConstant: 1.2)
        ])
    }
    
    func calculateMaxWidth() -> CGFloat {
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: frame.size.height)
        let actualSize = self.sizeThatFits(maxSize)
        return actualSize.width
    }
    
}

//MARK: - UIWindow
extension UIWindow {
    
    var visibleViewController: UIViewController? {
        if let rootViewController = self.rootViewController {
            return rootViewController.getVisibleViewController()
        }
        return nil
    }
    
}

//MARK: - UIWindowScene
@available(iOS 13.0, *)
extension UIWindowScene {
    
    var visibleViewController: UIViewController? {
        if let rootViewController = self.windows.first?.rootViewController {
            return rootViewController.getVisibleViewController()
        }
        return nil
    }
    
}

//MARK: - UIViewController
extension UIViewController {
    
    func getVisibleViewController() -> UIViewController {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.getVisibleViewController()
        } else if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController ?? navigationController
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController ?? tabBarController
        } else {
            return self
        }
    }
    
}

//MARK: - UIColor
extension UIColor {
    
    public static var skyBackground: UIColor {
        .init(hex: "#06001D")
    }
    
    public static var skyBackgroundLight: UIColor {
        .init(hex: "#FAFAFA")
    }
    
    public static var skyYellow: UIColor {
        .init(hex: "#FFD400")
    }
    
    public static var skyYellow2: UIColor {
        .init(hex: "#FFE14D")
    }
    
    public static var skyRed: UIColor {
        .init(hex: "#FF5A43")
    }
    
    public static var skyRed2: UIColor {
        .init(hex: "#DB1B00")
    }
    
    public static var skyGreen: UIColor {
        .init(hex: "#61CA45")
    }
    
    public static var skyBlue: UIColor {
        .init(hex: "#0C4DCE")
    }
    
    public static var skyLightGray: UIColor {
        .init(hex: "#F8F8F8")
    }
    
    public static var skyMidGray: UIColor {
        .init(hex: "#F1F1F4")
    }
    
    public static var skyTextBlack: UIColor {
        .init(hex: "#10083F")
    }
    
    public static var skyTextSecondary: UIColor {
        .init(hex: "#858295")
    }
    
    public static var skyTextTertiary: UIColor {
        .init(hex: "#A8A6B3")
    }
    
    public static var skyTextWhite: UIColor {
        .init(hex: "#FAFAFA")
    }
    
}

//MARK: - UIView
extension UIView {
    
    func reAddSubview(_ view: UIView) {
        view.removeFromSuperview()
        self.addSubview(view)
    }
    
    func reAddSubviews(_ views: [UIView]) {
        views.forEach({
            $0.removeFromSuperview()
            self.addSubview($0)
        })
    }
    
    func removeSubview(_ view: UIView) {
        view.removeFromSuperview()
    }
    
    func removeSubviews(_ views: [UIView]) {
        views.forEach({
            $0.removeFromSuperview()
        })
    }
    
}

extension UIDevice {
    
    func getModelFromAll() -> SkyDevice.AllModels {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return mapToDevice(identifier: identifier)
    }
    
    func mapToDevice(identifier: String) -> SkyDevice.AllModels {
        switch identifier {
        case "iPhone5,1", "iPhone5,2": return .iPhone(kind: ._5)
        case "iPhone5,3", "iPhone5,4": return .iPhone(kind: ._5C)
        case "iPhone6,1", "iPhone6,2": return .iPhone(kind: ._5S)
        case "iPhone7,2": return .iPhone(kind: ._6)
        case "iPhone7,1": return .iPhone(kind: ._6_PLUS)
        case "iPhone8,1": return .iPhone(kind: ._6S)
        case "iPhone8,2": return .iPhone(kind: ._6s_PLUS)
        case "iPhone9,1", "iPhone9,3": return .iPhone(kind: ._7)
        case "iPhone9,2", "iPhone9,4": return .iPhone(kind: ._7_PLUS)
        case "iPhone8,4": return .iPhone(kind: ._SE)
        case "iPhone10,1", "iPhone10,4": return .iPhone(kind: ._8)
        case "iPhone10,2", "iPhone10,5": return .iPhone(kind: ._8_PLUS)
        case "iPhone10,3", "iPhone10,6": return .iPhone(kind: ._X)
        case "iPhone11,2": return .iPhone(kind: ._XS)
        case "iPhone11,4", "iPhone11,6": return .iPhone(kind: ._XS_MAX)
        case "iPhone11,8": return .iPhone(kind: ._XR)
        case "iPhone12,1": return .iPhone(kind: ._11)
        case "iPhone12,3": return .iPhone(kind: ._11_PRO)
        case "iPhone12,5": return .iPhone(kind: ._11_PRO_MAX)
        case "iPhone12,8": return .iPhone(kind: ._SE_2)
            
        case "iPhone13,1": return .iPhone(kind: ._12_MINI)
        case "iPhone13,2": return .iPhone(kind: ._12)
        case "iPhone13,3": return .iPhone(kind: ._12_PRO)
        case "iPhone13,4": return .iPhone(kind: ._12_PRO_MAX)
            
        case "iPhone14,2": return .iPhone(kind: ._13)
        case "iPhone14,3": return .iPhone(kind: ._13_mini)
        case "iPhone14,4": return .iPhone(kind: ._13_pro)
        case "iPhone14,5": return .iPhone(kind: ._13_pro_max)
            
        case "iPhone14,7": return .iPhone(kind: ._14)
        case "iPhone14,8": return .iPhone(kind: ._14_plus)
        case "iPhone15,2": return .iPhone(kind: ._14_pro)
        case "iPhone15,3": return .iPhone(kind: ._14_pro_max)
            
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad_OLD
        case "iPad3,1", "iPad3,2", "iPad3,3": return .iPad_OLD
        case "iPad3,4", "iPad3,5", "iPad3,6": return .iPad_OLD
        case "iPad6,11", "iPad6,12": return .iPad_NEW
        case "iPad7,5", "iPad7,6": return .iPad_NEW
        case "iPad7,11", "iPad7,12": return .iPad_NEW
        case "iPad4,1", "iPad4,2", "iPad4,3": return .iPad_OLD
        case "iPad5,3", "iPad5,4": return .iPad_OLD
        case "iPad11,4", "iPad11,5": return .iPad_NEW
        case "iPad2,5", "iPad2,6", "iPad2,7": return .iPad_OLD
        case "iPad4,4", "iPad4,5", "iPad4,6": return .iPad_OLD
        case "iPad4,7", "iPad4,8", "iPad4,9": return .iPad_OLD
        case "iPad5,1", "iPad5,2": return .iPad_NEW
        case "iPad11,1", "iPad11,2": return .iPad_NEW
        case "iPad6,3", "iPad6,4": return .iPad_NEW
        case "iPad6,7", "iPad6,8": return .iPad_NEW
        case "iPad7,1", "iPad7,2": return .iPad_NEW
        case "iPad7,3", "iPad7,4": return .iPad_NEW
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4": return .iPad_NEW
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8": return .iPad_NEW
            
        case "i386", "x86_64", "arm64": return .simulator
        default: return .unknown
        }
    }
    
    var identifier: String {
        get {
            var systemInfo = utsname()
            uname(&systemInfo)
            let machineMirror = Mirror(reflecting: systemInfo.machine)
            let identifier = machineMirror.children.reduce("") { identifier, element in
                guard let value = element.value as? Int8, value != 0 else { return identifier }
                return identifier + String(UnicodeScalar(UInt8(value)))
            }
            return identifier
        }
    }
    
}
