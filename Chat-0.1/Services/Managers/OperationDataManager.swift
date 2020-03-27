//
//  OperationDataManager.swift
//  Chat-0.1
//
//  Created by Sunrise on 14.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

class DataReadOperation: Operation {
    var data: Data?
    let file: String
    
    init(sourceFile: String) {
        self.file = sourceFile
        
        super.init()
        
        self.qualityOfService = .background
        self.queuePriority = .veryHigh
    }
    
    override func main() {
        if isCancelled { return }
        let data = FilesManager.shared.readFile(file: file)
        if isCancelled { return }
        self.data = data
    }
}

class DataWriteOperation: Operation {
    var result = false
    let file: String
    let data: Data
    
    init(data: Data, file: String) {
        self.file = file
        self.data = data
        
        super.init()
        
        self.qualityOfService = .background
        self.queuePriority = .veryHigh
    }
    
    override func main() {
        if isCancelled { return }
        let result = FilesManager.shared.writeFile(file: file, data: data)
        if isCancelled { return }
        self.result = result
    }
}

class OperationDataManager: DataManager {
    let queue = OperationQueue()
    
    func writeFile(file: String, data: Data, callback: @escaping (Bool) -> Void) {
        let operation = DataWriteOperation(data: data, file: file)
        operation.completionBlock = {
            OperationQueue.main.addOperation {
                callback(operation.result)
            }
        }
        
        queue.addOperation(operation)
    }
    
    func readFile(file: String, callback: @escaping (Data?) -> Void) {
        //queue.maxConcurrentOperationCount = 1
        let operation = DataReadOperation(sourceFile: file)
        operation.completionBlock = {
            OperationQueue.main.addOperation {
                callback(operation.data)
            }
        }
        
        queue.addOperation(operation)
    }
}
