import Foundation
import Capacitor

@objc(PullToRefreshPlugin)
public class PullToRefreshPlugin: CAPPlugin {

    var refreshControl: UIRefreshControl?

    override public func load() {
        super.load()
        
        if let webView = self.bridge?.webView {
            webView.scrollView.bounces = true
        }
    }
    
    @objc func isRefreshing() {
        guard let control = self.refreshControl else { return print("[IOS] refreshControl is undefined") }
        
        self.notifyListeners("state", data: ["refreshing": true])
   }
    
    @objc func manuallyTriggerRefreshingState(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            guard let refreshControl = strongSelf.refreshControl else { 
                print("[IOS] refreshControl is undefined")
                return
            }
            
            let offset: CGFloat = CGFloat(call.getInt("offset") ?? -30)

            if let scrollView = strongSelf.bridge?.webView?.scrollView {

                if !refreshControl.isRefreshing {
                    refreshControl.beginRefreshing()

                    strongSelf.isRefreshing()

                    scrollView.setContentOffset(CGPoint(x: 0, y: offset), animated: false)
                }
            }
        }
    }

    @objc func setScrollPosition(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            guard let scrollView = strongSelf.bridge?.webView?.scrollView, let refreshControl = strongSelf.refreshControl, !refreshControl.isRefreshing else { return }
            guard let value = call.getInt("scroll_position") else {
                call.reject("Missing or invalid 'scroll_position' parameter")
                return
            }
            let threshold: CGFloat = CGFloat(call.getInt("threshold") ?? -100)

            let scroll_position: CGFloat = CGFloat(value)
            
            if scroll_position == threshold {
                // Provide haptic feedback
                let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
                feedbackGenerator.prepare()
                feedbackGenerator.impactOccurred()
            }
            
            scrollView.setContentOffset(CGPoint(x: 0, y: scroll_position), animated: false)
        }
    }

    @objc func enable(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            if strongSelf.refreshControl == nil {
                // Initialize the UIRefreshControl on the main thread
                let refreshControl = UIRefreshControl()
                refreshControl.addTarget(strongSelf, action: #selector(strongSelf.isRefreshing), for: .valueChanged)
                strongSelf.refreshControl = refreshControl

                // Attach the UIRefreshControl to the WKWebView's scrollView
                if let webView = strongSelf.bridge?.webView {
                    if #available(iOS 10.0, *) {
                        webView.scrollView.refreshControl = refreshControl
                    } else {
                        webView.scrollView.addSubview(refreshControl)
                    }
                    webView.scrollView.bringSubviewToFront(refreshControl)
                }
            }

            call.resolve([
                "enabled": true
            ])
        }
    }

    @objc func disable(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self, let refreshControl = strongSelf.refreshControl else { 
                print("[IOS] refreshControl is undefined")
                return 
            }
            
            refreshControl.removeFromSuperview()
            strongSelf.refreshControl = nil

            call.resolve([
                "enabled": false
            ])
        }
    }

    @objc func endRefreshing(_ call: CAPPluginCall) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            guard let refreshControl = strongSelf.refreshControl else { 
                print("[IOS] refreshControl is undefined")
                return
            }

            refreshControl.endRefreshing()

            strongSelf.notifyListeners("state", data: ["refreshing": false])

            call.resolve([
                "refreshing": false
            ])
        }
    }
}
