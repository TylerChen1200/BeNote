//
//  EditProfileViewController.swift
//  BeNote
//
//  Created by Ty C on 12/4/24.
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
        if let currentUserName = defaults.string(forKey: Configs.defaultName) {
            editProfileScreen.textFieldName.text = currentUserName
        }
        
        if let currentUserID = defaults.string(forKey: Configs.defaultUID) {
            db.collection(FirebaseConstants.Users)
                .document(currentUserID)
                .getDocument { [weak self] document, error in
                    if let base64String = document?.data()?["profilePicture"] as? String,
                       let imageData = Data(base64Encoded: base64String),
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            self?.editProfileScreen.imageViewProfile.image = image
                        }
                    }
                }
        }
    }
    
    @objc func changePhotoTapped() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        config.preferredAssetRepresentationMode = .current
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func saveTapped() {
        guard let currentUserID = defaults.string(forKey: Configs.defaultUID),
              let currentUser = Auth.auth().currentUser,  // Add this check
              let newName = editProfileScreen.textFieldName.text,
              !newName.isEmpty else {
            showAlert(message: "Please enter a valid name")
            return
        }
        
        // Add a loading indicator directly to the view
        let loadingIndicator = UIActivityIndicatorView(style: .large)
        loadingIndicator.center = self.view.center
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
        
        // Prepare update data
        var updateData: [String: Any] = ["displayName": newName]
        
        if let image = pickedImage,
           let imageData = image.jpegData(compressionQuality: 0.5) {
            
            // Get a fresh ID token
            currentUser.getIDToken { idToken, error in
                if let error = error {
                    DispatchQueue.main.async {
                        loadingIndicator.removeFromSuperview()
                        self.showAlert(message: "Authentication error: \(error.localizedDescription)")
                    }
                    return
                }
                
                // Create storage reference
                let storageRef = Storage.storage().reference()
                let profilePicsRef = storageRef.child("profile_pictures")
                let imageRef = profilePicsRef.child("\(currentUserID).jpg")
                
                // Set metadata
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                // Upload the image data
                imageRef.putData(imageData, metadata: metadata) { [weak self] metadata, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            loadingIndicator.removeFromSuperview()
                            self?.showAlert(message: "Error uploading image: \(error.localizedDescription)")
                        }
                        return
                    }
                    
                    // Get the download URL
                    imageRef.downloadURL { [weak self] url, error in
                        if let error = error {
                            DispatchQueue.main.async {
                                loadingIndicator.removeFromSuperview()
                                self?.showAlert(message: "Error getting download URL: \(error.localizedDescription)")
                            }
                            return
                        }
                        
                        guard let downloadURL = url else { return }
                        
                        // Add the download URL to the update data
                        updateData["profilePictureURL"] = downloadURL.absoluteString
                        
                        // Update Firestore with both name and profile picture URL
                        self?.updateFirestore(currentUserID: currentUserID, data: updateData, loadingIndicator: loadingIndicator)
                    }
                }
            }
        } else {
            // If no new image, just update the name
            updateFirestore(currentUserID: currentUserID, data: updateData, loadingIndicator: loadingIndicator)
        }
    }
    
    @objc func cancelTapped() {
        dismiss(animated: true)
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
                    
                    // Post notification to refresh profile
                    NotificationCenter.default.post(name: Configs.notificationRefresh, object: nil)
                    
                    // Dismiss the edit screen
                    self?.dismiss(animated: true)
                }
            }
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
