//
//  TranslateManager.swift
//  Google Translate
//
//  Created by Abdulloh on 11/05/23.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var translation = ResponseModel(data: DataClass(translations: [Translation(translatedText: "")]))
    @Published var languages = ["ru", "en"]
    
    func postRequest(text: String) {
        let url = URL(string: "https://google-translate1.p.rapidapi.com/language/translate/v2")
        guard let requestURL = url else {
            fatalError()
        }
        
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "Accept-Encoding": "application/gzip",
            "X-RapidAPI-Key": "972c55be60mshff61dc08568ada7p1029f3jsn64e64966ab71",
            "X-RapidAPI-Host": "google-translate1.p.rapidapi.com"
        ]
        
        var request = URLRequest(url: requestURL)
        
        let postData = NSMutableData(data: "q=\(text)".data(using: String.Encoding.utf8)!)
        postData.append("&target=\(languages[0])".data(using: String.Encoding.utf8)!)
        postData.append("&source=\(languages[1])".data(using: String.Encoding.utf8)!)
        
        request.httpBody = postData as Data
        request.allHTTPHeaderFields = headers
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            if let error = error {
                print("Error took place \(error)")
            }
            if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let result = try decoder.decode(ResponseModel.self, from: data)
                    DispatchQueue.main.async {
                        self.translation = result
                    }
                } catch {
                    print("error: couldn't decode data")
                }
            }
        }
        task.resume()
    }
}
