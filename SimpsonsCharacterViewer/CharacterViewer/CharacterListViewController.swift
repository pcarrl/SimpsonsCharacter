import Foundation
import UIKit

class CharacterListViewController: UIViewController {
    private let urlBasePath = "https://duckduckgo.com/"

    private let contentView: CharacterListContentView
    private let viewModel: CharacterListViewModel
    private let isIpad = UIScreen.main.traitCollection.userInterfaceIdiom == .pad

    init(characters: [Character]) {
        self.viewModel = CharacterListViewModel(characters: characters)
        self.contentView = CharacterListContentView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable) required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.backgroundColor = .white
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

        setupTableView()
        setupTextfield()
        setupButton()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTable),
                                               name: Notification.Name("RefreshTable"), object: nil)
    }

    private func setupTableView() {
        if isIpad {
            contentView.tableView.register(CharacterListIPadTableViewCell.self, forCellReuseIdentifier: "cell")
        } else {
            contentView.tableView.register(CharacterListTableViewCell.self, forCellReuseIdentifier: "cell")
        }
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }

    private func setupTextfield() {
        contentView.searchField.delegate = self
    }

    private func setupButton() {
        contentView.searchButton.addTarget(self, action: #selector(goTapped), for: .touchUpInside)
    }

    @objc func goTapped(_ sender: UIButton) {
        contentView.searchField.resignFirstResponder()
    }
    @objc func refreshTable(_ sender: Any) {
        contentView.tableView.reloadData()
    }
}

extension CharacterListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isIpad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterListIPadTableViewCell else {
                return UITableViewCell()
            }
            let character = viewModel.filteredList[indexPath.row]
            let name = viewModel.getCharacterName(name: character.name ?? "")
            let url = URL(string: urlBasePath + (character.icon.url ?? ""))
            cell.setupCell(imageUrl: url, name: name, description: character.text)
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterListTableViewCell else {
            return UITableViewCell()
        }
        let character = viewModel.filteredList[indexPath.row]
        let name = viewModel.getCharacterName(name: character.name ?? "")
        cell.setupCell(name: name)
        return cell
    }
    
    
}

extension CharacterListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isIpad == false else { return }
        let character = viewModel.filteredList[indexPath.row]
        DispatchQueue.main.async {
            let viewController = CharacterDetailViewController(character: character)
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}

extension CharacterListViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let query = textField.text ?? ""
        viewModel.searchList(query: query)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text ?? ""
        viewModel.searchList(query: query)
        return true
    }
}
