//
//  WatchSessionManager.swift
//  testWatch2
//
//  Created by Adriana Pineda on 6/2/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

import UIKit
import WatchConnectivity

@available(iOS 9.0, *)
class WatchSessionManager: NSObject, WCSessionDelegate {

    static let sharedManager = WatchSessionManager()

    private override init() {
        super.init()
    }

    private let wcSession: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil

    private var validSession: WCSession? {
        if let session = wcSession where session.paired && session.watchAppInstalled {
            return session
        }

        return nil
    }

    func startSession() {
        self.wcSession?.delegate = self
        self.wcSession?.activateSession()
    }

    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {

    }

    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        
    }

    func sendTokens(tokens: [TokenDTO]) {

        if validSession == nil {
            return
        }

        var tokensArray: [[String: String]] = []

        for token in tokens {
            let currentTokenDict = ["name": token.getName(), "secret": token.getSecretSeed()]
            tokensArray.append(currentTokenDict)
        }

        self.wcSession?.transferUserInfo(["tokens" : tokensArray])
    }

}
