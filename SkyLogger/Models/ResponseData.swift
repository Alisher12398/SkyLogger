//
//  ResponseData.swift
//  SkyLogger
//
//  Created by Алишер Халыкбаев on 17.11.2021.
//

import Foundation

public class ResponseData {
    
    let baseURL: URL?
    let urlPath: String
    let method: String
    let statusCode: Int?
    let headers: [String: String]?
    let urlParameters: [String: Any]?
    let bodyParameters: [String: Any]?
    let error: Error?
    let responseBody: String?
    let showAuthorizationHeader: Bool
    
    var url: String {
        var result: String = baseURL?.absoluteString ?? "" + urlPath
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
    
    enum Key: String, CaseIterable {
        case baseURL
        case urlPath
        case url
        case method
        case statusCode
        case headers
        case urlParameters
        case bodyParameters
        case error
        case responseBody
        
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
    
    public init(showAuthorizationHeader: Bool = false) {
        self.baseURL = nil
        self.urlPath = ""
        self.method = ""
        self.statusCode = 0
        self.headers = nil
        self.urlParameters = nil
        self.bodyParameters = nil
        self.error = nil
        self.responseBody = nil
        self.showAuthorizationHeader = showAuthorizationHeader
    }
    
    public init(baseURL: URL, urlPath: String, method: String, statusCode: Int?, headers: [String : String]?, urlParameters: [String : Any]?, bodyParameters: [String : Any]?, error: Error?, responseBody: String?, showAuthorizationHeader: Bool) {
        self.baseURL = baseURL
        self.urlPath = urlPath
        self.method = method
        self.statusCode = statusCode
        self.headers = headers
        self.urlParameters = urlParameters
        self.bodyParameters = bodyParameters
        self.error = error
        self.responseBody = responseBody
        self.showAuthorizationHeader = showAuthorizationHeader
    }
    
//    public init(state: TargetType, result: Result<MoyaResponse, MoyaError>, showAuthorizationHeader: Bool) {
//
//        ResponseData.init(
//            baseURL: state.baseURL,
//            urlPath: state.path,
//            method: state.method.rawValue,
//            statusCode: statusCode,
//            headers: headers,
//            urlParameters: Self.getParameters().url,
//            bodyParameters: Self.getParameters().body,
//            error: responseError,
//            responseBody: responseBody
//        )
//    }
//
//    private static func getParameters(state: TargetType) -> (url: [String: Any]?, body: [String: Any]?) {
//        switch state.task {
//        case .requestParameters(parameters: let parameters, encoding: _):
//            return (url: parameters, body: nil)
//        case .requestCompositeData(bodyData: _, urlParameters: let urlParameters):
//            return (url: urlParameters, body: nil)
//        case .requestCompositeParameters(bodyParameters: let bodyParameters, bodyEncoding: _, urlParameters: let urlParameters):
//            return (url: urlParameters, body: bodyParameters)
//        case .uploadCompositeMultipart(_, urlParameters: let urlParameters):
//            return (url: urlParameters, body: nil)
//        case .downloadParameters(parameters: let parameters, encoding: _, destination: _):
//            return (url: parameters, body: nil)
//        default:
//            return (url: nil, body: nil)
//        }
//    }
    
}
