//
//  ImageDownloader.swift
// CoreDataMVC
//
//  Created by Arun Jangid on 01/05/20.
//

import UIKit

class ImageDownloader {
    
    fileprivate let operationQueue = OperationQueue()
    let imageUrl : URL!
    var imageCache : UIImage?
    
    init(_ url:URL, completion: @escaping (UIImage?) -> ()) {
        imageUrl = url
        // Create the operation
        let dataLoad = DataLoadOperation(url: url) { (data) in
            if let data = data{
                let image = UIImage(data: data)
                // Strore downloaded Image to image cache
                self.imageCache = image
                completion(image)
            }
        }
        let operations = [dataLoad]
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    func cancel() {
        operationQueue.cancelAllOperations()
    }

}

extension ImageDownloader: Hashable {
    func hash(into hasher: inout Hasher) {
        
    }
}

func ==(lhs: ImageDownloader, rhs: ImageDownloader) -> Bool {
    return lhs.imageUrl == rhs.imageUrl
}

class DataLoadOperation:Operation {
    
    fileprivate let url: URL
    fileprivate let completion: ((Data?) -> ())?
    fileprivate var loadedData: Data?
    
    init(url: URL, completion: ((Data?) -> ())? = nil) {
        self.url = url
        self.completion = completion
    }
    
    override func main() {

        NetworkSimulator.asyncLoadDataAtURL(url) {
            data in
            self.loadedData = data
            self.completion?(data)
        }
    }
}

// Fetch Image URL
struct NetworkSimulator {
    static func asyncLoadDataAtURL(_ url: URL, completion: @escaping ((_ data: Data?) -> ())) {
        DispatchQueue.global(qos: .default).async {
            let data = syncLoadDataAtURL(url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    static func syncLoadDataAtURL(_ url: URL) -> Data? {
        return (try? Data(contentsOf: url))
    }
}
