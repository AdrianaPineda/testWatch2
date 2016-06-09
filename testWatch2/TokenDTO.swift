//
//  TokenDTO.swift
//  testWatch2
//
//  Created by Adriana Pineda on 6/2/16.
//  Copyright © 2016 Adriana Pineda. All rights reserved.
//

import UIKit

class TokenDTO: NSObject {

    private let name: String
    private let logo: String
    private let secretSeed: String

    init(withName name: String, logo: String, secretSeed: String) {
        self.name = name
        self.logo = logo
        self.secretSeed = secretSeed
    }

    func getName() -> String {
        return self.name
    }

    func getSecretSeed() -> String {
        return self.secretSeed
    }
}
