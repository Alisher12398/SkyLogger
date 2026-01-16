//
//  SkyFileManager.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 09.11.2021.
//

import UIKit

struct SkyFileManager {
    
    static let shared = SkyFileManager()
    
    init() {
        setup()
    }
    
//    private let textFileName = "sky_logger.txt"
    
    private let textFileURL: URL? = {
            guard let path = Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                Logger.print(message: ".documentDirectory from Foundation.FileManager is nil")
                return nil
            }
            let fileURL = path.appendingPathComponent("sky_logger.txt")
            return fileURL
    }()
    
}

//MARK: - Public Functions
extension SkyFileManager {
    
    func removeTextFile() {
        guard let textFileURL = textFileURL else { return }
        do {
            try Foundation.FileManager.default.removeItem(at: textFileURL)
        } catch {
//            Logger.print(error: "can't remove text file from FileManager. Error: \(error); localizedDescription: \(error.localizedDescription)")
        }
    }
    
    func saveToTextFile(logs: [Log], additionalInfoParameters: [Log.Parameter]) -> URL? {
        guard let textFileURL = textFileURL else { return nil }
        removeTextFile()
        let header: String = SkyStringHandler.generateInfoHeaderString(additionalInfoParameters: additionalInfoParameters)
        let logs = SkyStringHandler.convertLogsToString(logs, showDivider: true, destination: .share)
        write(header + logs)
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

//MARK: - Private Functions
extension SkyFileManager: TextOutputStream {
    
    private func setup() {
        removeTextFile()
    }
    
    func write(_ string: String) {
        guard let textFileURL = textFileURL else { return }
        do {
            if let data = string.data(using: String.Encoding.utf8) {
                try data.appendToFile(fileURL: textFileURL)
            }
        }
        catch {
            Logger.print(error: "can't write text file. Error: \(error); localizedDescription: \(error.localizedDescription)")
        }
    }
    
}

//MARK: - Data extension
fileprivate extension Data {
    
    func appendToFile(fileURL: URL) throws {
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
