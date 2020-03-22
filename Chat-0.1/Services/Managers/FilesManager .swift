//
//  FileManager .swift
//  Chat-0.1
//
//  Created by Sunrise on 13.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation

class FilesManager: FileManager {
    
    static let shared = FilesManager()
    
    // для варианта с тремя файлами
    //вместо дата использовать String, но столкнулся с проблемой вывода алерта в мейн потоке
    //после завершения записи, так как вывод производился раньше
    //учитывая реализацию чтения/записи в GCD/Operation Manager, работа с одним файлом более подходящая
    
    let fileForName = "fileForName.txt"
    let fileForAbout = "fileForText.txt"
    let fileForImage = "fileForImage.txt"
    //для варианиа с одним
    //использование Data -> создание класса Profile
    let fileForAll = "fileForAll"
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    
    func readFile(file: String) -> Data? {
        guard let fileURL = path?.appendingPathComponent(file) else {return(nil)}
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        }
        catch {
            return nil
            
        }
        
    }
    func writeFile(file: String, data: Data) -> Bool {
        let oldData = readFile(file: file)
        //при трех файлах работает; при одном при использовании одной Data нет
        if  oldData == data {
            return true
            
        }
        
        guard let fileURL = path?.appendingPathComponent(file) else {return false}
        do {
            try data.write(to: fileURL)
            return true
        } catch {
            return false
        }
    }
}
