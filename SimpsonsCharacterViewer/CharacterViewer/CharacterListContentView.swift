import Foundation
import UIKit

class CharacterListContentView: UIView {
    private let viewModel: CharacterListViewModel

    init(viewModel: CharacterListViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }


    private var logo: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.black.cgColor
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.widthAnchor.constraint(equalToConstant: 200).isActive = true
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "The Character Viewer"
        title.frame.size.height = 50
        title.frame.size.width = 100
        view.addSubview(title)
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var searchField: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.placeholder = "Search Character..."
        textfield.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textfield.borderStyle = .roundedRect
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 15
        textfield.layer.borderColor = UIColor.systemBlue.cgColor
        return textfield
    }()

    var searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.setTitle("GO", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = .systemBlue
        return button
    }()

    var tableView: UITableView = {
       let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 15
        table.layer.borderWidth = 2
        return table
    }()

    private func setupUI() {
        self.addSubview(logo)
        logo.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        logo.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        self.addSubview(searchField)
        searchField.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 25).isActive = true
        searchField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

        self.addSubview(searchButton)
        searchButton.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 25).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        searchButton.leadingAnchor.constraint(equalTo: searchField.trailingAnchor, constant: 10).isActive = true

        self.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 25).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
    }
}
