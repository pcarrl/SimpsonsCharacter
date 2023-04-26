import Foundation
import UIKit

class CharacterDetailViewController: UIViewController {
    private let character: Character
    private let contentView: CharacterDetailContentView
    private let urlBasePath = "https://duckduckgo.com/"

    init(character: Character) {
        self.character = character
        self.contentView = CharacterDetailContentView(character: character)
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
        
        getContent()
    }

    private func getContent() {
        guard let url = URL(string: urlBasePath + (character.icon.url ?? "")) else { return}
        contentView.imageView.load(url: url)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
