//
//  LikeListAccessObject.swift
//  Midnight
//
//  Created by Victor Mendes on 28/01/23.
//

import Foundation

final class LikeListAccessObject {
    static var lastItemChanged: (id: Int?, liked: Bool) = (id: nil, liked: false)

    static func saveData(_ object: Int) {
        var listObjects: [Int] = []
        
        if let objectsLoaded = loadData() {
            listObjects = objectsLoaded
        }
        
        listObjects.append(object)
        
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: listObjects, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: Movie.PropertyKey.id)
        } catch {
            debugPrint(error.localizedDescription)
        }
        lastItemChanged = (id: object, liked: true)
    }
    
    static func loadData() -> [Int]? {
        var decodedData: [Int]? = nil
        do {
            let defaults = UserDefaults.standard
            if let data = defaults.object(forKey: Movie.PropertyKey.id) as? Data {
                decodedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Int]
            }
        } catch {
            print(error.localizedDescription)
        }
        lastItemChanged = (id: nil, liked: false)
        return decodedData
    }
    
    static func removeItem(_ item: Int) {
        guard let itemsSaved = loadData() else { return }
        let updatedList = itemsSaved.filter { $0 != item }
    
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: updatedList, requiringSecureCoding: false)
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: Movie.PropertyKey.id)
        } catch {
            debugPrint(error.localizedDescription)
        }
        lastItemChanged = (id: item, liked: false)
    }
}
