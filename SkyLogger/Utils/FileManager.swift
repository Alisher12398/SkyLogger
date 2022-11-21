//
//  FileManager.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 09.11.2021.
//

import UIKit

struct FileManager {
    
    static let shared = FileManager()
    
    init() {
        setup()
    }
    
    private let textFileName = "sky_logger.txt"
    
    private var textFileURL: URL? {
        get {
            guard let path = Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                Logger.print(".documentDirectory from Foundation.FileManager is nil")
                return nil
            }
            let fileURL = path.appendingPathComponent(textFileName)
            return fileURL
        }
    }
    
}

//MARK:- Public Functions
extension FileManager {
    
    func removeTextFile() {
        guard let textFileURL = textFileURL else { return }
        do {
            try Foundation.FileManager.default.removeItem(at: textFileURL)
        } catch {
            Logger.print("Remove catch. Error: \(error)")
        }
    }
    
    func saveToTextFile(logs: [Log], appVersion: String, additionalParameters: [Log.Parameter]) -> URL? {
        guard let textFileURL = textFileURL else { return nil }
        let header: String = SkyStringHandler.generateInfoHeaderString(appVersion: appVersion, additionalParameters: additionalParameters)
        write(header)
        write(SkyStringHandler.convertLogsToString(logs))
        return textFileURL
    }
    
    func readFromTextFile() -> String {
        guard let textFileURL = textFileURL else { return "" }
        do {
            let currentTextInFile: String = try String(contentsOf: textFileURL, encoding: .utf8)
            return currentTextInFile
        } catch {
            return ""
        }
    }
    
}

//MARK:- Private Functions
extension FileManager: TextOutputStream {
    
    private func setup() {
        removeTextFile()
    }
    
    func write(_ string: String) {
        guard let textFileURL = textFileURL else { return }
        do {
            if let data = string.data(using: String.Encoding.utf8) {
                try data.append(fileURL: textFileURL)
            }
        }
        catch {
            Logger.print("Write catch. Error: \(error)")
        }
    }
    
}

//MARK:- Data extension
fileprivate extension Data {
    
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
    
}
