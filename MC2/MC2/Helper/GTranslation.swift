//
//  GTranslation.swift
//  MC2
//
//  Created by Widya Limarto on 05/07/22.
//

import Foundation

class GTranslation {
    static var shared : GTranslation = GTranslation()
    let apiKey: String? = Bundle.main.infoDictionary?["TRANSLATE_API_KEY"] as? String
    let bundleIdentifier: String? = Bundle.main.bundleIdentifier as? String
    
    func translateText(q: String, targetLanguage: String, callback:@escaping (_ translatedText:String) -> ()) async {
        
        guard let pKey = apiKey, let bi = bundleIdentifier else {
            return
        }

        var request = URLRequest(url: URL(string: "https://translation.googleapis.com/language/translate/v2?key=\(pKey)")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(bi, forHTTPHeaderField: "X-Ios-Bundle-Identifier")

            let jsonRequest = [
                "q": q,
                "source": "en",
                "target": targetLanguage,
                "format": "text"
                ] as [String : Any]

            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonRequest, options: .prettyPrinted) {
                request.httpBody = jsonData
                let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    guard error == nil else {
                        print("Something went wrong: \(String(describing: error?.localizedDescription))")
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse {

                        guard httpResponse.statusCode == 200 else {
                            if let data = data {
                                print("Response [\(httpResponse.statusCode)] - \(data)")
                            }
                            return
                        }

                        do {
                            if let data = data {
                                if let json = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                                    if let jsonData = json["data"] as? [String : Any] {
                                        if let translations = jsonData["translations"] as? [NSDictionary] {
                                            if let translation = translations.first as? [String : Any] {
                                                if let translatedText = translation["translatedText"] as? String {
                                                    callback(translatedText)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } catch {
                            print("Serialization failed: \(error.localizedDescription)")
                        }
                    }
                }

                task.resume()
            }
    }
}
