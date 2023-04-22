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
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    //Current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // Current lesson explanation
    @Published var codeText = NSAttributedString()
    var styleData: Data?
    
    // Current selected content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected: Int?
    
    
    
    init() {
        // Parse local included json data
        getLocalData()
        
        // Download remote json file and parse data
        getRemoteData()
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
    
    func getRemoteData() {
        let urlString = "https://tienbui1508.github.io/swiftui-learning-app/LearningApp/Resources/data2.json"
        
        // Create a url object
        let url = URL(string: urlString)
        
        // Create a URLRequest object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
       
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check if there's an error
            guard error == nil else {
                return
            }
            // Handle the response
            
            do {
                let decoder = JSONDecoder()
                
                
                let modules = try decoder.decode([Module].self, from: data!)
                
                DispatchQueue.main.async {
                    self.modules += modules
                }
            }
            catch {
                // Couldn't parse json
                print(error)
            }
        }
        // Kick off data task
        dataTask.resume()
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
    
    func beginLesson(_ lessonIndex: Int) {
        
        // CHeck that the lesson index is within the rang of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
            
        } else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        codeText = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson() {
        
        // Advance the lesson incex
        currentLessonIndex += 1
        
        // Check that it is within range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            //Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            // Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func nextQuestion() {
        
        // Advance the question incex
        currentQuestionIndex += 1
        
        // Check that it is within range
        if currentQuestionIndex < currentModule!.content.lessons.count {
            //Set the current lesson property
            
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
            
        }
        else {
            // Reset the lesson state
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    
     
        
    }
    
    func hasNextLesson() -> Bool {
        guard currentModule != nil else {
            return false
        }
        
        return (currentLessonIndex + 1 < currentModule!.content.lessons.count)
    }
    
    
    func beginTest(_ moduleId:Int) {
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question
        currentQuestionIndex = 0
        
        // iF there are questions, set the current question to the 1st one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
    }
    // MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var data = Data()
        var resultString = NSAttributedString()
        
        if styleData != nil {
            data.append(self.styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            
            resultString = attributedString
        }
        
        return resultString
    }
}
