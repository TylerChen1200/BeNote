import UIKit
import FirebaseFirestore
import FirebaseAuth

class ManageFriendsViewController: UIViewController {
    // MARK: - Properties
    let friendScreen = FriendScreenView()
    let db = Firestore.firestore()
    let notificationCenter = NotificationCenter.default
    let defaults = UserDefaults.standard
    
    var friendsArray = [User]()
    var pendingRequests = [FriendRequest]()
    var requestsTableView: UITableView!
    
    // MARK: - Models
    struct FriendRequest {
        let id: String
        let senderID: String
        let senderName: String
        let senderEmail: String
        let status: String
        let timestamp: Date
    }
    
    // MARK: - Lifecycle Methods
    override func loadView() {
        view = friendScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViews()
        setupObservers()
        getAllFriends()
        fetchPendingRequests()
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        title = "Friends"
        navigationController?.navigationBar.prefersLargeTitles = true
        friendScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    private func setupTableViews() {
        friendScreen.tableViewFriends.dataSource = self
        friendScreen.tableViewFriends.delegate = self
        
        requestsTableView = friendScreen.requestsTableView
        requestsTableView.delegate = self
        requestsTableView.dataSource = self
    }
    
    private func setupObservers() {
        notificationCenter.addObserver(
            self,
            selector: #selector(notificationReceived),
            name: Configs.notificationRefresh,
            object: nil
        )
    }
    
    // MARK: - Friend Request Methods
    func sendFriendRequest(toEmail: String) {
        guard let currentUserID = defaults.object(forKey: Configs.defaultUID) as? String,
              let currentUserEmail = defaults.object(forKey: Configs.defaultEmail) as? String,
              let currentUserName = defaults.object(forKey: Configs.defaultName) as? String
        else { return }
        
        // Find recipient user
        db.collection(FirebaseConstants.Users)
            .whereField("email", isEqualTo: toEmail)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    self?.showErrorAlert("Error finding user: \(error.localizedDescription)")
                    return
                }
                
                guard let recipientDoc = querySnapshot?.documents.first else {
                    self?.showErrorAlert("User not found with that email")
                    return
                }
                
                let recipientID = recipientDoc.documentID
                
                // Check for existing request
                self?.db.collection(FirebaseConstants.FriendRequests)
                    .whereField(FirebaseConstants.RequestSender, isEqualTo: currentUserID)
                    .whereField(FirebaseConstants.RequestReceiver, isEqualTo: recipientID)
                    .getDocuments { [weak self] (requestSnapshot, error) in
                        if let _ = requestSnapshot?.documents.first {
                            self?.showErrorAlert("A friend request to this user already exists")
                            return
                        }
                        
                        // Create new request
                        let requestData: [String: Any] = [
                            FirebaseConstants.RequestSender: currentUserID,
                            "senderName": currentUserName,
                            "senderEmail": currentUserEmail,
                            FirebaseConstants.RequestReceiver: recipientID,
                            FirebaseConstants.RequestStatus: FirebaseConstants.StatusPending,
                            FirebaseConstants.RequestTimestamp: Timestamp(date: Date())
                        ]
                        
                        self?.db.collection(FirebaseConstants.FriendRequests)
                            .addDocument(data: requestData) { [weak self] error in
                                if let error = error {
                                    self?.showErrorAlert("Error sending request: \(error.localizedDescription)")
                                } else {
                                    self?.showSuccessAlert("Friend request sent!")
                                    self?.clearAddViewFields()
                                }
                            }
                    }
            }
    }
    
    func fetchPendingRequests() {
        guard let currentUserID = defaults.object(forKey: Configs.defaultUID) as? String else { return }
        
        db.collection(FirebaseConstants.FriendRequests)
            .whereField(FirebaseConstants.RequestReceiver, isEqualTo: currentUserID)
            .whereField(FirebaseConstants.RequestStatus, isEqualTo: FirebaseConstants.StatusPending)
            .addSnapshotListener { [weak self] (querySnapshot, error) in
                if let error = error {
                    print("Error fetching requests: \(error)")
                    return
                }
                
                self?.pendingRequests = querySnapshot?.documents.map { document in
                    let data = document.data()
                    return FriendRequest(
                        id: document.documentID,
                        senderID: data[FirebaseConstants.RequestSender] as? String ?? "",
                        senderName: data["senderName"] as? String ?? "Unknown",
                        senderEmail: data["senderEmail"] as? String ?? "",
                        status: data[FirebaseConstants.RequestStatus] as? String ?? "",
                        timestamp: (data[FirebaseConstants.RequestTimestamp] as? Timestamp)?.dateValue() ?? Date()
                    )
                } ?? []
                
                self?.requestsTableView.reloadData()
            }
    }
    
    func handleFriendRequest(request: FriendRequest, accepted: Bool) {
        let newStatus = accepted ? FirebaseConstants.StatusAccepted : FirebaseConstants.StatusDenied
        
        db.collection(FirebaseConstants.FriendRequests)
            .document(request.id)
            .updateData([FirebaseConstants.RequestStatus: newStatus]) { [weak self] error in
                if let error = error {
                    self?.showErrorAlert("Error updating request: \(error.localizedDescription)")
                    return
                }
                
                if accepted {
                    self?.addFriendToCurrentUser(
                        friendID: request.senderID,
                        name: request.senderName,
                        email: request.senderEmail
                    )
                }
            }
    }
    
    // MARK: - Friend Management Methods
    func getAllFriends() {
        guard let currentUserID = defaults.object(forKey: Configs.defaultUID) as? String else { return }
        
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .collection(FirebaseConstants.Friends)
            .getDocuments { [weak self] (querySnapshot, error) in
                if let error = error {
                    self?.showErrorAlert("Error fetching user data: \(error)")
                    return
                }
                
                self?.friendsArray = querySnapshot?.documents
                    .map { document in
                        let data = document.data()
                        return User(
                            name: data["name"] as? String ?? "No Name",
                            email: data["email"] as? String ?? "No Email",
                            _id: data["id"] as? String ?? "No ID"
                        )
                    } ?? []
                
                DispatchQueue.main.async {
                    self?.friendScreen.tableViewFriends.reloadData()
                }
            }
    }
    
    func deleteFriend(id: String) {
        guard let currentUserID = defaults.object(forKey: Configs.defaultUID) as? String else { return }
        
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .collection(FirebaseConstants.Friends)
            .document(id)
            .delete { [weak self] error in
                if let error = error {
                    print("Error removing friend: \(error)")
                } else {
                    self?.getAllFriends()
                    NotificationCenter.default.post(name: Configs.notificationRefresh, object: nil)
                }
            }
    }
    @objc func acceptRequest(_ sender: UIButton) {
        let request = pendingRequests[sender.tag]
        handleFriendRequest(request: request, accepted: true)
    }

    @objc func denyRequest(_ sender: UIButton) {
        let request = pendingRequests[sender.tag]
        handleFriendRequest(request: request, accepted: false)
    }
    
    func addFriendToCurrentUser(friendID: String, name: String, email: String) {
        guard let currentUserID = defaults.object(forKey: Configs.defaultUID) as? String else { return }
        
        db.collection(FirebaseConstants.Users)
            .document(currentUserID)
            .collection(FirebaseConstants.Friends)
            .document(friendID)
            .setData([
                "name": name,
                "email": email,
                "id": friendID
            ]) { [weak self] error in
                if let error = error {
                    self?.showErrorAlert("Error adding friend: \(error.localizedDescription)")
                } else {
                    self?.getAllFriends()
                    NotificationCenter.default.post(name: Configs.notificationRefresh, object: nil)
                }
            }
    }
    
    // MARK: - Helper Methods
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func clearAddViewFields() {
        friendScreen.textFieldAddFriend.text = ""
    }
    
    // MARK: - Actions
    @objc func onButtonAddTapped() {
        if let emailText = friendScreen.textFieldAddFriend.text?.lowercased() {
            if emailText.isEmpty || !validateEmail(emailText) {
                showErrorAlert("Please enter a valid email")
            } else {
                sendFriendRequest(toEmail: emailText)
            }
        }
    }
    
    @objc func notificationReceived(notification: Notification) {
        getAllFriends()
    }
    
    // MARK: - Alert Methods
    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
        present(alert, animated: true)
    }
    
    func showSuccessAlert(_ message: String) {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
