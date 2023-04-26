import UIKit

class ViewController: UIViewController {
    private var logo: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 5
        view.layer.borderColor = UIColor.black.cgColor
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(logo)
        logo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        logo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.layoutIfNeeded()
        getAppConfiguration()
        }
    
    private func getAppConfiguration() {
        CharacterService.shared.getListOfCharacters { response in
            guard let response = response else {
                return
            }
            DispatchQueue.main.async {
                let viewController = CharacterListViewController(characters: response.characters)
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true)
            }
        }
    }

}

