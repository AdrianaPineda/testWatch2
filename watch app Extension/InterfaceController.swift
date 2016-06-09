//
//  InterfaceController.swift
//  watch app Extension
//
//  Created by Adriana Pineda on 5/30/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, ViewObserver {

    @IBOutlet var tokensTable: WKInterfaceTable!

    private var tokens: [TokenDTO] = []

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.

        self.tokens = self.getSavedTokens()
        self.fillTable()

        WatchExtensionSessionManager.sharedManager.setObserver(self)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func fillTable() {
        self.tokensTable.setNumberOfRows(tokens.count, withRowType: "tokenRow")


        for (var i: Int = 0; i < self.tokensTable.numberOfRows; i += 1) {

            if let tokenRow: TokenRow = self.tokensTable.rowControllerAtIndex(i) as? TokenRow {

                let name = self.tokens[i].getName()
                tokenRow.tokenName.setText(name)
                tokenRow.tokenotp.setText("123456")
            }

        }

    }

    func updateTokens(tokens: [TokenDTO]) {
        self.tokens = tokens
        self.fillTable()
        self.locallySaveTokens(self.tokens)
    }


    func locallySaveTokens(tokens: [TokenDTO]) {

        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        var savedTokens: [[String: String]] = []
        for token in tokens {
            let currentTokenDict = ["name" : token.getName(), "seed" : token.getSecretSeed()]

            savedTokens.append(currentTokenDict)
        }

        userDefaults.setValue(savedTokens, forKey: "tokens")
        userDefaults.synchronize()
    }

    func getSavedTokens() -> [TokenDTO] {

        var tokens: [TokenDTO] = []

        let userDefaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()

        if let savedTokens = userDefaults.objectForKey("tokens") as? [[String: String]] {

            for savedToken: [String: String] in savedTokens {
                let currentToken: TokenDTO = TokenDTO(withName: savedToken["name"]!, logo: "logox", secretSeed: savedToken["seed"]!)
                tokens.append(currentToken)
            }
        }

        return tokens
    }
}
