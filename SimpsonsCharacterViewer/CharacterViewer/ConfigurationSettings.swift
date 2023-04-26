import Foundation

struct Settings {
    let appName: String?
    let dataUrl: String?
}

class ConfigurationSettings {
    static let shared = ConfigurationSettings()

    var settings: Settings? = nil
    private let configurationFileName: String

    private init() {
        #if Wire
        self.configurationFileName = "TheWire"
        #else
        self.configurationFileName = "Simpsons"
        #endif
    }
    
    var targetSettings: Settings {
        get {
            guard let settings = self.settings else {
                if let path = Bundle.main.path(forResource: self.configurationFileName, ofType: "plist"),
                    let dictionary = NSDictionary(contentsOfFile: path) {
                        let appName = dictionary["appName"] as? String
                        let dataUrl = dictionary["dataUrl"] as? String
                        let newSettings = Settings(appName: appName, dataUrl: dataUrl)
                        self.settings = newSettings
                        return newSettings
                    }
                return Settings(appName: nil, dataUrl: nil)
            }
            return settings
        }
    }
}
