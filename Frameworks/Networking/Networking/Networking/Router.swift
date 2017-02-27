//
//  Router.swift
//  NetworkingService
//
//  Created by Limon on 20/02/2017.
//  Copyright © 2017 Limon.F. All rights reserved.
//

import Alamofire

public struct Router {

    public static let v1BaseURLString: String = {
        return "https://\(ServiceConfigure.apiHost)/v1"
    }()

    // Beta/1.0.0 (iPhone; iOS 8.1; Scale/2.00)
    public static let userAgent: String = {

        let key: String = {
            switch ServiceConfigure.Environment.value {
            case .debug:
                return "DEV"
            case .enterprise:
                return "Beta"
            case .release:
                return "Lego"
            }
        }()

        let version = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String) ?? "1.0.0"

        return "\(key)/\(version) (\(UIDevice.current.model); iOS \(UIDevice.current.systemVersion); Scale/\(UIScreen.main.scale))"
    }()

}

extension URLRequest {

    public static func buildRequest(path: String, method: Alamofire.HTTPMethod, needsResolve: Bool = true) -> URLRequest {

        let urlString = Router.v1BaseURLString + path
        let encodingString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: encodingString ?? urlString)!

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(Router.userAgent, forHTTPHeaderField: "User-Agent")
        urlRequest.setValue(NSLocalizedString("locate", tableName: ServiceConfigure.tableName, bundle: ServiceConfigure.bundle, comment: ""), forHTTPHeaderField: "Accept-Language")

        if let token = ServiceConfigure.accessToken {
            urlRequest.setValue(token, forHTTPHeaderField: "Lego-TOKEN")
        }

        return urlRequest
    }
}
