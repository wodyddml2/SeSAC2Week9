import Foundation

extension URLSession {
    
    typealias completionHandler = (Data?, URLResponse?, Error?) -> Void
    
    @discardableResult // 반환 값 안쓰게
    func customDatTask(_ endpoint: URLRequest, completionHandler: @escaping completionHandler) -> URLSessionDataTask {
        let task = dataTask(with: endpoint, completionHandler: completionHandler)
        task.resume()
        
        return task
    }
    
    static func request<T: Codable>(_ session: URLSession = .shared, endpoint: URLRequest, completionHandler: @escaping(T?, APIError?) -> Void) {
        
        session.customDatTask(endpoint) { data, response, error in
            DispatchQueue.main.async {
                
                guard error == nil else {
                    print("Fail Request")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("No Data Returned")
                    completionHandler(nil, .noData)
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    print("Unable Response")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {
                    print("Failed Response")
                    completionHandler(nil, .failedRequest)
                    return
                }

                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }
    }
}
