//
//  SkyExtensions.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 19.08.2023.
//

import UIKit

//MARK: - SkyLogger Call
public extension UIViewController {
    
    func log(_ log: Log) {
        Logger.log(log)
    }
    
    /**
     Convenience func to show a log with .print kind only in Xcode
     */
    func skyPrint(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.skyPrint(message, file: file, function: function, line: line)
    }
    
}

public extension UIView {
    
    func log(_ log: Log) {
        Logger.log(log)
    }
    
    /**
     Convenience func to show a log with .print kind only in Xcode
     */
    func skyPrint(_ message: Any, file: String = #file, function: String = #function, line: Int = #line) {
        Logger.skyPrint(message, file: file, function: function, line: line)
    }
    
}

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

extension Notification.Name {
    
    static let newLogAdded = Notification.Name("new.log.added")
    
}
