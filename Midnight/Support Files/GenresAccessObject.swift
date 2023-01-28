//
//  GenresAccessObject.swift
//  Midnight
//
//  Created by Victor Mendes on 12/12/22.
//

import Foundation

class GenresAccessObject {
    static func saveData(_ object: [Genre]) {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: PropertyKey.genres)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    static func loadData() -> [Genre]? {
        var decodedData: [Genre]? = nil
        do {
            let defaults = UserDefaults.standard
            if let data = defaults.object(forKey: PropertyKey.genres) as? Data {
                decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Genre]
            }
        } catch {
            print(error.localizedDescription)
        }
        return decodedData
    }
    
    static func organizedGenres(_ genreId: [Int]?) -> String {
        guard let genres = loadData() else { return "" }
        return genreId?.compactMap { number -> String in
            genres.filter({ $0.id == number }).map({ $0.name}).joined()
        }.filter({ $0 != "" }).prefix(2).sorted(by: <).joined(separator: ", ") ?? ""
    }
    
    struct PropertyKey {
        static let genres = "genres"
    }
}
