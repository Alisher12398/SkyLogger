//
//  ThreadSafeArray.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 06.09.2022.
//

import Foundation

class ThreadSafeArray<Element> {
    
    private var array = [Element]()
    private let queue = DispatchQueue(label: "skylogger.thread.safe.array.label", attributes: .concurrent)
    
    subscript(index: Int) -> Element? {
        set {
            guard let newValue = newValue else { return }
            self.queue.async(flags:.barrier) {
                self.array[index] = newValue
            }
        }
        get {
            var element: Element?
            self.queue.sync {
                element = self.array[safe: index]
            }
            return element
        }
    }
    
    var allCases: [Element] {
        var elements: [Element] = []
        self.queue.sync {
            elements = self.array
        }
        return elements
    }
    
    var count: Int {
        var count = 0
        self.queue.sync {
            count = self.array.count
        }
        return count
    }
    
    var isEmpty: Bool {
        return self.count == 0
    }
    
    func append(newElement: Element) {
        self.queue.async(flags:.barrier) {
            self.array.append(newElement)
        }
    }
    
    func removeAt(index: Int) {
        self.queue.async(flags:.barrier) {
            self.array.remove(at: index)
        }
    }
    
    func forEach(_ body: (Element) -> Void) {
        queue.sync { self.array.forEach(body) }
    }
    
    func removeAll(completion: (([Element]) -> Void)? = nil) {
        queue.async(flags: .barrier) {
            let elements = self.array
            self.array.removeAll()
            DispatchQueue.main.async { completion?(elements) }
        }
    }
    
}
