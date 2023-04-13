//
//  ContentModel.swift
//  LearningApp
//
//  Created by Tien Bui on 11/4/2023.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
    
    
        //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    
    func getLocalData() {
        
        // Get a url to the json file
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            // Try to decode the json into anarray of modules
            let jsonDecoder = JSONDecoder()
            
            do {
                let modules = try jsonDecoder.decode([Module].self, from: jsonData)
                // Assign parsed modules to modules property
                self.modules = modules
            }
            catch {
                print(error)
            }
        
        }
        catch {
            // TODO log error
            print(error)
        }
        
        // Parse the style data
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        //Read the file into a data obejct
        do {
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch {
            print(error)
        }
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleid: Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            if modules[index].id == moduleid {
                
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
    }
    
}
