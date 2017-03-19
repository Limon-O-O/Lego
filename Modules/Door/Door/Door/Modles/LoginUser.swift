//
//  LoginUser.swift
//  Pods
//
//  Created by Limon on 27/02/2017.
//
//

import Foundation
import LegoProvider

enum LoginPlatform: String {
    case weChat = "wechat"
    case phone = "phone"
    case weibo = "weibo"
    case qq = "qq"
}

struct LoginUser {
    let userID: Int
    let nickname: String
}

extension LoginUser: Decodable {

    init?(json: [String: Any]) {
        guard let userID = json["user_id"] as? Int,
            let nickname = json["user_nickname"] as? String
            else { return nil }
        self.userID = userID
        self.nickname = nickname
    }

    static func mapping(json: [String: Any]) -> LoginUser? {
        return LoginUser(json: json)
    }
}
