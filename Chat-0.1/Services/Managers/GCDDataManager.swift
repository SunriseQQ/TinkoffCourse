//
//  GCDDataManager.swift
//  Chat-0.1
//
//  Created by Sunrise on 14.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

class GCDDataManager: DataManager {
    //  let queue = DispatchQueue(label: "com.app.queue")
    let queue = DispatchQueue.global(qos: .utility)
    
    func readFile(file: String, callback: @escaping (Data?) -> Void) {
        queue.async {
            let data = FilesManager.shared.readFile(file: file)
            
            DispatchQueue.main.async {
                callback(data)
            }
        }
    }
    
    func writeFile(file: String, data: Data, callback: @escaping (Bool) -> Void) {
        queue.async {
            let result = FilesManager.shared.writeFile(file: file, data: data)
            
            DispatchQueue.main.async{
                callback(result)
            }
            
        }
    }
}
