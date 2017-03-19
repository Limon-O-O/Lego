//
//  ViewController.swift
//  LegoAPI
//
//  Created by Limon-O-O on 03/16/2017.
//  Copyright (c) 2017 Limon-O-O. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import LegoProvider

struct Template: Decodable {

    init?(json: [String: Any]) {
        print("json \(json)")
    }
}

class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let provider = LegoProvider<GitHubUserContent>()

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadRepositories("Limon-O-O")
    }

    private func downloadRepositories(_ username: String) {

//        provider.request(.userRepositories(username)).mapObjects(type: Template.self).subscribe(onNext: { event in
//            print(event)
//        }, onError: { error in
//            self.showAlert("GitHub Fetch", message: error.localizedDescription)
//        }).disposed(by: disposeBag)

        provider.requestWithProgress((.downloadMoyaWebContent("logo_github.png"))) { progress in

            print("progress \(progress) \(Thread.current.name)")

        }.mapObjects(type: Template.self).subscribe(onNext: { event in
            print(event)
        }, onError: { error in
            print((error as! ProviderError))
        }).disposed(by: disposeBag)

    }

    fileprivate func showAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(ok)
        present(alertController, animated: true, completion: nil)
    }

}

// MARK: - Provider support

public enum GitHubUserContent {
    case downloadMoyaWebContent(String)
}

extension GitHubUserContent: LegoAPI {
    public var baseURL: URL { return URL(string: "https://raw.githubusercontent.com")! }
    public var path: String {
        switch self {
        case .downloadMoyaWebContent(let contentPath):
            return "/Moya/Moya/master/web/\(contentPath)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .downloadMoyaWebContent:
            return .get
        }
    }
    public var parameters: [String: Any]? {
        switch self {
        case .downloadMoyaWebContent:
            return nil
        }
    }
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    public var task: Task {
        switch self {
        case .downloadMoyaWebContent:
            return .download(.request(DefaultDownloadDestination))
        }
    }
    public var sampleData: Data {
        return Data()
    }

}

private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

    if !directoryURLs.isEmpty {
        return (directoryURLs[0].appendingPathComponent(response.suggestedFilename!), [])
    }

    return (temporaryURL, [])
}


private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

public enum GitHub {
    case zen
    case userProfile(String)
    case userRepositories(String)
}

extension GitHub: LegoAPI {

    public var baseURL: URL { return URL(string: "https://api.github.com")! }

    public var path: String {
        switch self {
        case .zen:
            return "/zen"
        case .userProfile(let name):
            return "/users/\(name.urlEscaped)"
        case .userRepositories(let name):
            return "/users/\(name.urlEscaped)/repos"
        }
    }

    public var method: Moya.Method {
        return .get
    }

    public var parameters: [String: Any]? {
        switch self {
        case .userRepositories(_):
            return ["sort": "pushed"]
        default:
            return nil
        }
    }

    /// Provides stub data for use in testing.
    public var sampleData: Data {
        return Data()
    }

}
