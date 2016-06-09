//
//  WatchExtensionSessionManager.swift
//  testWatch2
//
//  Created by Adriana Pineda on 6/2/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

import UIKit
import WatchConnectivity

@available(iOS 9.0, *)
class WatchExtensionSessionManager: NSObject, WCSessionDelegate {

    private var observer: ViewObserver? = nil
    static let sharedManager = WatchExtensionSessionManager()

    private override init() {
        super.init()
    }

    func setObserver(observer: ViewObserver) {
        self.observer = observer
    }

    private let wcSession: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil

    func startSession() {
        self.wcSession?.delegate = self
        self.wcSession?.activateSession()
    }

    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {

    }

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {

        var tokensDTO: [TokenDTO] = []

        if let tokens: [[String: AnyObject]] = userInfo["tokens"] as? [[String: AnyObject]] {
            for tokenDict:[String:AnyObject] in tokens {
                let tokenName: String = tokenDict["name"] as! String
                let tokenSecret: String = tokenDict["secret"] as! String

                let currentToken = TokenDTO(withName: tokenName, logo: "", secretSeed: tokenSecret)
                tokensDTO.append(currentToken)


            }
        }

        self.observer?.updateTokens(tokensDTO)
    }
    
}
