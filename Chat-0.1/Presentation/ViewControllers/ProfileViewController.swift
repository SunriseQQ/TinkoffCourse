//
//  ViewController.swift
//  Chat-0.1
//
//  Created by Sunrise on 13.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, ScrollViewKeyboardHandler {
    
    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var profileScrollView: UIScrollView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileImageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var informationTextField: UITextField!
    
    @IBOutlet weak var editButton: UIButton!
   // @IBOutlet weak var gcdButton: UIButton!
    @IBOutlet weak var coreButton: UIButton!
    
    var activeField: UITextField?
    var scrollView: UIScrollView {
        return profileScrollView
    }
    
    private var profile: Profile? = nil
//    private let gcdDataManager = GCDDataManager()
//    private let operationDataManager = OperationDataManager()
    private let storageManager = StorageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        profileImageButton.backgroundColor = UIColor(hex: "#3F78F0FF")
        profileImageButton.layer.cornerRadius = profileImageButton.frame.size.height / 2
        
        
        editButton.layer.cornerRadius = 10
        editButton.layer.borderColor = UIColor.black.cgColor
        editButton.layer.borderWidth = 0.75
        
        
        //gcdButton.isHidden = true
        coreButton.isHidden = true
        
        profileImage.layer.cornerRadius = profileImageButton.frame.size.height / 2
        
        nameTextField.delegate = self
        nameTextField.isHidden = true
        informationTextField.delegate = self
        informationTextField.isHidden = true
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0);
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style =
            UIActivityIndicatorView.Style.whiteLarge
        view.addSubview(activityIndicator)
        
        scrollView.keyboardDismissMode = .onDrag
        
        
        //readProfile(dataManager: gcdDataManager)
        readCoreData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.deregisterFromKeyboardNotifications()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        informationLabel.clipsToBounds =  true
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
    
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barButtonItemPressed))
    }
//
//    func readProfile(dataManager: DataManager){
//
//        dataManager.readFile(file: FilesManager.shared.fileForAll){
//            data in
//
//            self.editClose()
//            if let data = data,
//                let profile = NSKeyedUnarchiver.unarchiveObject(with: data) as? Profile {
//
//                self.profile = profile
//
//                self.nameLabel.text = profile.name
//                self.informationLabel.text = profile.about
//                self.profileImage.image = profile.image
//
//            }
//            if self.profileImage.image == nil {
//                self.profileImage.image = UIImage(named: "placeholder-user.png")
//            }
//        }
//
//    }
//
//    func writeProfile(dataManager: DataManager){
//        let textName = nameTextField.text ?? ""
//        let textInformation = informationTextField.text ?? ""
//        let image = (profileImage.image ?? UIImage(named: "plaseholder-user.png")) ?? UIImage()
//
//        let newProfile = Profile(name: textName, about: textInformation, image: image)
//
//        let newData = NSKeyedArchiver.archivedData(withRootObject: newProfile)
//
//        startWrite()
//        dataManager.writeFile(file: FilesManager.shared.fileForAll, data: newData){
//            completed in
//            self.endWrite()
//
//            if completed {
//                self.profile = newProfile
//                self.showCompletedAlert(title: "Editing was successful",
//                                        message: "Данные сохранены") {
//                                            self.readProfile(dataManager: dataManager)
//                }
//            }else{
//                self.showErrorAlert(message: "Ошибка сохраненния данных", repeatedBlock: {
//                    self.writeProfile(dataManager: dataManager)
//                }, okBlock: {
//                    self.editClose()
//                })
//
//            }
//        }
//
//    }
    
    @objc func barButtonItemPressed(sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK - IBActions
    
    @IBAction func profileImageButtonAction(_ sender: Any) {
        showImagePickerControllerActionSheet()
        saveButtonEnabled(enabled: true)
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        saveButtonEnabled(enabled: false)
        editButton.isHidden = true
       // gcdButton.isHidden = false
        coreButton.isHidden = false
        
        nameTextField.isHidden = false
        nameLabel.isHidden = true
        nameTextField.text = nameLabel.text
        
        profileImageButton.isHidden = false
        
        informationLabel.isHidden = true
        informationTextField.isHidden = false
        informationTextField.text = informationLabel.text
    }
    
//    @IBAction func gcdButtonPressed(_ sender: Any) {
//        writeProfile(dataManager: gcdDataManager )
//    }
    
    @IBAction func coreButtonPressed(_ sender: Any) {
        //writeProfile(dataManager: operationDataManager )
        saveCoreData()
    }
    
    //MARK - Private
    private func startWrite(){
        self.activityIndicator.startAnimating()
        saveButtonEnabled(enabled: false)
    }
    
    private func endWrite(){
        self.activityIndicator.stopAnimating()
    }
    
    private func editClose(){
        editButton.isHidden = false
        //gcdButton.isHidden = true
        coreButton.isHidden = true
        
        nameTextField.isHidden = true
        nameLabel.isHidden = false
        
        profileImageButton.isHidden = true
        informationLabel.isHidden = false
        informationTextField.isHidden = true
    }
    
    private func saveButtonEnabled(enabled: Bool) {
        //gcdButton.isEnabled = enabled
        coreButton.isEnabled = enabled
    }
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension ProfileViewController: UITextFieldDelegate  {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if !activityIndicator.isAnimating {
            saveButtonEnabled(enabled: true)
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
    }
}

extension UIViewController {
    
    
    func showErrorAlert(message: String,  repeatedBlock: @escaping (() -> Void), okBlock: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            okBlock()
        }
        
        alert.addAction(okAction)
        
        let repeateAction = UIAlertAction(title: "Повторить", style: .default) { action in
            repeatedBlock()
        }
        alert.addAction(repeateAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showCompletedAlert(title: String = "", message: String, okBlock: @escaping (() -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) {
            action in okBlock()
        }
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension ProfileViewController {
    func saveCoreData() {
        let textName = nameTextField.text ?? ""
        let textInformation = informationTextField.text ?? ""
        let image = (profileImage.image ?? UIImage(named: "plaseholder-user.png")) ?? UIImage()
        
        startWrite()
        
        let context = storageManager.privateContext
        
        context.perform {
            [weak self] in
            if let appUser = self?.storageManager.findOrInsertAppUser(with: "CURRENT_USER_IDENTIFIER", in: context),
                let currentUser = appUser.currentUser {
                
                currentUser.name = textName
                currentUser.information = textInformation
                currentUser.image = image
            }
            
            self?.storageManager.performSave(context: context) { (success) in
                self?.coreDataSavedUser(success)
            }
        }
    }
    
    private func coreDataSavedUser(_ success: Bool) {
        DispatchQueue.main.async {
            
            self.endWrite()
            if success {
                self.showCompletedAlert(title: "Editing was successful", message: "Данные сохранены") {
                    self.readCoreData()
                }
            } else {
               self.showErrorAlert(message: "Ошибка сохраненния данных", repeatedBlock: {
                    self.saveCoreData()
                }, okBlock: {
                    self.editClose()
                })
            }
        }
    }
    
    func readCoreData() {
        endWrite()
        editClose()
        if let appUser = storageManager.findOrInsertAppUser(with: "CURRENT_USER_IDENTIFIER", in: storageManager.mainContext) {
            
            nameLabel.text = appUser.currentUser?.name
            informationLabel.text = appUser.currentUser?.information
            profileImage.image = appUser.currentUser?.image
        }
        if self.profileImage.image == nil {
            self.profileImage.image = UIImage(named: "placeholder-user.png")
        }
    }
}


