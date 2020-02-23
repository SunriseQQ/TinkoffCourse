//
//  ViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 13.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var informationLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // print(editButton.frame)
        //Причина ошибки попытка вывести значения frame до полной инициализации editButton.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageButton.backgroundColor = UIColor(hex: "#3F78F0FF")
        profileImageButton.layer.cornerRadius = profileImageButton.frame.size.height / 2
        
        editButton.layer.cornerRadius = 10
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 0.75
        
        profileImage.layer.cornerRadius = profileImageButton.frame.size.height / 2
        
        print(editButton.frame)
        //Показывается значения frame выгруженные из .storyboard файла
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print(editButton.frame)
        /* Причина различия свойства frame от frame в viewDidLoad заключается в том что:
         в отличии от значений frame загруженных
         из .storyboard, в методе viewDidAppear свойства UIButton
         и остальных компонентов уже измененны в
         соответсвии с AutoLayout для устройства указанного в симуляторе. */
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        informationLabel.frame.size.width = UIScreen.main.bounds.width * 0.9
        informationLabel.frame.size.height = UIScreen.main.bounds.height * 0.5
        informationLabel.sizeToFit()
    }
    
    func showImagePickerControllerActionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let choosePhotoButton = UIAlertAction(title: "Choose from Library", style: .default) {action in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        let takePhotoButton = UIAlertAction(title: "Take from Camera", style: .default) {action in
            self.showImagePickerController(sourceType: .camera)
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(choosePhotoButton)
        alert.addAction(takePhotoButton)
        alert.addAction(cancelButton)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func profileImageButtonAction(_ sender: Any) {
        showImagePickerControllerActionSheet()
    }
    
}


extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerController.SourceType){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = sourceType
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
}
