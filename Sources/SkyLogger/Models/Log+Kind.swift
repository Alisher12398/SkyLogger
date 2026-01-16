//
//  Log+Kind.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 02.09.2023.
//

import UIKit

extension Log {
    
    public enum Kind {
        
        case print
        case api(data: SkyResponseData?)
        case system
        case error(Error?)
        case analytics
        
        var index: Int {
            return Kind.allCases.firstIndex(of: self) ?? 0
        }
        
        var emoji: Character {
            switch self {
            case .print:
                return "⚪"
            case .api:
                return "🟢"
            case .system:
                return "🔵"
            case .error:
                return "🔴"
            case .analytics:
                return "🟡"
            }
        }
        
        var emojiString: String {
            return String(emoji)
        }
        
        var color: UIColor {
            switch self {
            case .print:
                return .skyTextWhite
            case .api:
                return .skyGreen
            case .system:
                return .skyBlue
            case .error:
                return .skyRed
            case .analytics:
                return .skyYellow
            }
        }
        
        var title: String {
            switch self {
            case .print:
                return "Print"
            case .api:
                return "Api"
            case .system:
                return "System"
            case .error:
                return "Error"
            case .analytics:
                return "Analytics / Debug"
            }
        }
        
    }
    
    public class Parameter {
        let key: String
        let value: Any?
        
        public init(key: String, value: Any?) {
            self.key = key
            self.value = value
        }
    }
    
}

//MARK: - Protocols
extension Log.Kind: CaseIterable, Equatable {
    
    public static var allCases: [Log.Kind] {
        return [.print, .api(data: nil), .system, .error(nil), .analytics]
    }
    
    static var allCasesForCollectionView: [(title: String, emoji: Character?)] {
        var result: [(title: String, emoji: Character?)] = allCases.map({ (title: $0.title, emoji: $0.emoji) })
        result.append((title: "Custom", emoji: "🟣"))
        result.insert((title: "All", emoji: nil), at: 0)
        return result
    }
    
    public static func == (lhs: Log.Kind, rhs: Log.Kind) -> Bool {
        switch lhs {
        case .print:
            switch rhs {
            case .print:
                return true
            default:
                return false
            }
        case .api:
            switch rhs {
            case .api:
                return true
            default:
                return false
            }
        case .system:
            switch rhs {
            case .system:
                return true
            default:
                return false
            }
        case .error:
            switch rhs {
            case .error:
                return true
            default:
                return false
            }
        case .analytics:
            switch rhs {
            case .analytics:
                return true
            default:
                return false
            }
        }
    }
    
}
