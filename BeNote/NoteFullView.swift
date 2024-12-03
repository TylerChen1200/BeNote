import UIKit

class NoteFullView: UIView {
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    var labelPrompt: UILabel!
    var labelLocation: UILabel!
    var labelTimestampCreated: UILabel!
    var labelCreatorReply: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupScrollView()
        setupContentView()
        setupLabels()
        
        initConstraints()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(scrollView)
    }
    
    func setupContentView() {
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }

    func setupLabels() {
        // Setup for the prompt label (larger font)
        labelPrompt = UILabel()
        labelPrompt.font = UIFont.boldSystemFont(ofSize: 24)
        labelPrompt.numberOfLines = 0
        labelPrompt.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelPrompt)
        
        // Setup for the location label
        labelLocation = UILabel()
        labelLocation.font = UIFont.systemFont(ofSize: 14)
        labelLocation.textColor = .gray
        labelLocation.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelLocation)
        
        // Setup for the timestamp label
        labelTimestampCreated = UILabel()
        labelTimestampCreated.font = UIFont.systemFont(ofSize: 12)
        labelTimestampCreated.textColor = .lightGray
        labelTimestampCreated.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelTimestampCreated)
        
        // Setup for the creator's reply label (regular font)
        labelCreatorReply = UILabel()
        labelCreatorReply.font = UIFont.systemFont(ofSize: 16)
        labelCreatorReply.numberOfLines = 0
        labelCreatorReply.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(labelCreatorReply)
    }

    private func initConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Content view inside scroll view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            // Prompt label constraints
            labelPrompt.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelPrompt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelPrompt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            // Location label constraints
            labelLocation.topAnchor.constraint(equalTo: labelPrompt.bottomAnchor, constant: 8),
            labelLocation.leadingAnchor.constraint(equalTo: labelPrompt.leadingAnchor),
            labelLocation.trailingAnchor.constraint(equalTo: labelPrompt.trailingAnchor),
            
            // Timestamp label constraints
            labelTimestampCreated.topAnchor.constraint(equalTo: labelLocation.bottomAnchor, constant: 8),
            labelTimestampCreated.leadingAnchor.constraint(equalTo: labelLocation.leadingAnchor),
            labelTimestampCreated.trailingAnchor.constraint(equalTo: labelLocation.trailingAnchor),
            
            // Creator's reply label constraints
            labelCreatorReply.topAnchor.constraint(equalTo: labelTimestampCreated.bottomAnchor, constant: 25),
            labelCreatorReply.leadingAnchor.constraint(equalTo: labelTimestampCreated.leadingAnchor),
            labelCreatorReply.trailingAnchor.constraint(equalTo: labelTimestampCreated.trailingAnchor),
            labelCreatorReply.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
