//
//  EditProfileViewController.swift
//  BeNote
//

import Foundation
import UIKit
import PhotosUI
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class EditProfileViewController: UIViewController {
    let editProfileScreen = EditProfileScreenView()
    let db = Firestore.firestore()
    let defaults = UserDefaults.standard
    var pickedImage: UIImage?
    let storage = Storage.storage()
    var loadingAlert: UIAlertController?
    
    override func loadView() {
        view = editProfileScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Edit Profile"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelTapped)
        )
        
        editProfileScreen.buttonChangePhoto.addTarget(self, action: #selector(changePhotoTapped), for: .touchUpInside)
        editProfileScreen.buttonSave.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        loadCurrentUserData()
    }
    
    func loadCurrentUserData() {
        if let currentUserID = defaults.string(forKey: Configs.defaultUID) {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .getDocument { [weak self] document, error in
                    if let error = error {
                        self?.showAlert(message: "Error loading user data: \(error.localizedDescription)")
                        return
                    }
                    
                    if let userData = document?.data() {
                        // Get name from Firestore
                        if let name = userData["name"] as? String {
                            DispatchQueue.main.async {
                                self?.editProfileScreen.textFieldName.text = name
                                // Clear placeholder when there's text
                                self?.editProfileScreen.textFieldName.placeholder = nil
                            }
                        } else {
                            // Set placeholder if no name is set
                            DispatchQueue.main.async {
                                self?.editProfileScreen.textFieldName.placeholder = "Name"
                            }
                        }
                        
                        // Load profile picture if available
                        if let base64String = userData["profilePicture"] as? String,
                           let imageData = Data(base64Encoded: base64String),
                           let image = UIImage(data: imageData) {
                            DispatchQueue.main.async {
                                self?.editProfileScreen.imageViewProfile.image = image
                            }
                        }
                    }
                }
        }
    }
    
    @objc func saveTapped() {
        guard let currentUserID = defaults.string(forKey: Configs.defaultUID),
              let currentUser = Auth.auth().currentUser,
              let newName = editProfileScreen.textFieldName.text,
              !newName.isEmpty else {
            showAlert(message: "Please enter a valid name")
            return
        }
        
        // Add a loading indicator
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
        
        // Prepare update data
        var updateData: [String: Any] = ["name": newName]
        
        // Store the new name in UserDefaults
        defaults.set(newName, forKey: Configs.defaultName)
        
        if let image = pickedImage,
           let imageData = image.jpegData(compressionQuality: 0.5) {
            
            currentUser.getIDToken { idToken, error in
                if let error = error {
                    DispatchQueue.main.async {
                        loadingIndicator.removeFromSuperview()
                        self.showAlert(message: "Authentication error: \(error.localizedDescription)")
                    }
                    return
                }
                
                let storageRef = Storage.storage().reference()
                let profilePicsRef = storageRef.child("profile_pictures")
                let imageRef = profilePicsRef.child("\(currentUserID).jpg")
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                imageRef.putData(imageData, metadata: metadata) { [weak self] metadata, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            loadingIndicator.removeFromSuperview()
                            self?.showAlert(message: "Error uploading image: \(error.localizedDescription)")
                        }
                        return
                    }
                    
                    imageRef.downloadURL { [weak self] url, error in
                        if let error = error {
                            DispatchQueue.main.async {
                                loadingIndicator.removeFromSuperview()
                                self?.showAlert(message: "Error getting download URL: \(error.localizedDescription)")
                            }
                            return
                        }
                        
                        guard let downloadURL = url else { return }
                        
                        updateData["profilePictureURL"] = downloadURL.absoluteString
                        
                        self?.updateFirestore(currentUserID: currentUserID, data: updateData, loadingIndicator: loadingIndicator)
                    }
                }
            }
        } else {
            updateFirestore(currentUserID: currentUserID, data: updateData, loadingIndicator: loadingIndicator)
        }
    }
    
    private func updateFirestore(currentUserID: String, data: [String: Any], loadingIndicator: UIActivityIndicatorView) {
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .setData(data, merge: true) { [weak self] error in
                DispatchQueue.main.async {
                    loadingIndicator.removeFromSuperview()
                    
                    if let error = error {
                        self?.showAlert(message: "Error saving changes: \(error.localizedDescription)")
                        return
                    }
                    
                    NotificationCenter.default.post(name: Configs.notificationRefresh, object: nil)
                    self?.dismiss(animated: true)
                }
            }
    }
    
    // Existing methods remain unchanged
    @objc func changePhotoTapped() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        config.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension EditProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        guard let result = results.first else { return }
        
        result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
            if let image = object as? UIImage {
                DispatchQueue.main.async {
                    self?.pickedImage = image
                    self?.editProfileScreen.imageViewProfile.image = image
                }
            }
        }
    }
}
