//
//  ResponseData.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 17.11.2021.
//

import Foundation

public class ResponseData {
    
    let baseURL: URL
    let urlPath: String
    var url: String {
        var result: String = baseURL.absoluteString + urlPath
        if let urlParameters = urlParameters, !urlParameters.isEmpty {
            result.append("?")
            for (index, item) in urlParameters.enumerated() {
                if index > 0 {
                    result.append("&")
                }
                result.append("\(item.key)=\(item.value)")
            }
        }
        return result
    }
    let method: String
    let statusCode: Int?
    let headers: [String: String]?
    let urlParameters: [String: Any]?
    let bodyParameters: [String: Any]?
    let responseBody: String?
    let error: Error?
    
    enum Key: String, CaseIterable {
        case baseURL
        case urlPath
        case url
        case method
        case statusCode
        case headers
        case urlParameters
        case bodyParameters
        case responseBody
        case error
        
        func getValue(data: ResponseData) -> Any? {
            switch self {
            case .baseURL:
                return data.baseURL
            case .urlPath:
                return data.urlPath
            case .url:
                return data.url
            case .method:
                return data.method
            case .statusCode:
                return data.statusCode
            case .headers:
                return data.headers
            case .urlParameters:
                return data.urlParameters
            case .bodyParameters:
                return data.bodyParameters
            case .responseBody:
                if let responseBody = data.responseBody {
                    return "\n" + responseBody
                } else {
                    return data.responseBody
                }
            case .error:
                return data.error
            }
        }
    }
    
    public init(baseURL: URL, urlPath: String, method: String, statusCode: Int?, headers: [String : String]?, urlParameters: [String : Any]?, bodyParameters: [String : Any]?, responseBody: String?, error: Error?) {
        self.baseURL = baseURL
        self.urlPath = urlPath
        self.method = method
        self.statusCode = statusCode
        self.headers = headers
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.responseBody = responseBody
        self.error = error
    }
}
