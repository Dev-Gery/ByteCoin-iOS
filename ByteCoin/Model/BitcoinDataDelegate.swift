//
//  BitcoinDataDelegate.swift
//  ByteCoin
//
//  Created by Gery Josua Sumual on 20/05/24.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

protocol BitcoinDataDelegate {
    func didFailWithError(_ error: Error)
    func getApiDidSuccess(rate: Double, curr: String)
}
