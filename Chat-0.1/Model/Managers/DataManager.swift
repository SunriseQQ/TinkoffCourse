//
//  DataManager.swift
//  Chat-0.1
//
//  Created by Sunrise on 14.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

protocol DataManager {
    
    func readFile(file: String, callback: @escaping (Data?) -> Void)
    func writeFile(file: String, data: Data, callback: @escaping (Bool) -> Void)
}
