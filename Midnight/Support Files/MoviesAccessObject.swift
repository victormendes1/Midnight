//
//  MoviesAccessObject.swift
//  Midnight
//
//  Created by Victor Mendes on 01/02/23.
//

import Foundation

final class MoviesAccessObject {
    static var favoriteMovies: [Movie]?
    
    static func saveData(_ object: Movie) {
        var listObjects: [Movie] = []
        
        if let objectsLoaded = loadData() {
            listObjects = objectsLoaded
        }
        
        listObjects.append(object)
        
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: listObjects, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: "movies")
        } catch {
            debugPrint(error.localizedDescription)
        }
        favoriteMovies = listObjects
    }
    
    static func loadData() -> [Movie]? {
        var decodedData: [Movie]? = nil
        do {
            let defaults = UserDefaults.standard
            if let data = defaults.object(forKey: "movies") as? Data {
                decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Movie]
            }
        } catch {
            debugPrint(error.localizedDescription)
            favoriteMovies = nil
        }
        favoriteMovies = decodedData == nil ? [] : decodedData
        return favoriteMovies
    }
    
    static func removeItem(_ item: Movie) {
        guard let itemsSaved = loadData() else { return }
        let updatedList = itemsSaved.filter { $0.id != item.id }
        
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: updatedList, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: "movies")
        } catch {
            debugPrint(error.localizedDescription)
        }
        favoriteMovies = updatedList
    }
}
