import Foundation

@objc public class PullToRefresh: NSObject {
    @objc public func enable(completion: @escaping (Bool, Error?) -> Void) {
        print("PullToRefresh Enabled")
        // Simulate an async operation
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(true, nil)
        }
    }
    
    @objc public func disable(completion: @escaping (Bool, Error?) -> Void) {
        print("PullToRefresh Disabled")
        // Simulate an async operation
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(true, nil)
        }
    }
    
    @objc public func endRefreshing(completion: @escaping (Bool, Error?) -> Void) {
        print("PullToRefresh EndRefreshing")
        // Simulate an async operation
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            completion(true, nil)
        }
    }
}