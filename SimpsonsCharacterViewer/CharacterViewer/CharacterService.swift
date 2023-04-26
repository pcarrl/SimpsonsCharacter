import Foundation

class CharacterService {
    static let shared = CharacterService()

    private init() {}

    func getListOfCharacters(completion: @escaping (ServiceResponse?) -> Void) {
        guard let url = URL(string: ConfigurationSettings.shared.targetSettings.dataUrl ?? "") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil,
                  let responce = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let list = responce["RelatedTopics"],
                  let results = try? JSONSerialization.data(withJSONObject: ["RelatedTopics": list]),
                  let characters = try? JSONDecoder().decode(ServiceResponse.self, from: results) else {
                completion(nil)
                return
            }
            completion(characters)
            print(characters)
        }
        task.resume()
    }
}
