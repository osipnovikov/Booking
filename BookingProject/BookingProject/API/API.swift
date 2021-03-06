import Foundation
import UIKit.UIImage

final class API {
    
    static let shared = API()
    private let storage = Storage.shared
    
    func loadData(from url: String) -> Data? {
        guard let url = URL(string: url) else { fatalError() }
        
        let semaphore = DispatchSemaphore(value: 0)
        let data: Data
        
        do {
            data = try Data(contentsOf: url, options: [.uncachedRead,.mappedRead])
            let nsdata = NSData(data: data)
            storage.cache.setObject(nsdata, forKey: url as NSURL)
            semaphore.signal()
        } catch {
            data = .init()
            semaphore.signal()
        }
        
        semaphore.wait()
        return data
    }
    
//    func imageData(url: String) -> Data? {
//        guard let url = URL(string: url) else { fatalError() }
//
//        let semaphore = DispatchSemaphore(value: 0)
//        var data: Data! = .init() {
//            didSet { semaphore.signal() }
//        }
//        do {
//            data = try Data(contentsOf: url, options: [.uncachedRead,.mappedRead])
//        } catch {
//            data = UIImage(named: "imagecomingsoon")?.pngData()
//        }
//        semaphore.wait()
//        return data
//    }
    
    private init() { }
}
