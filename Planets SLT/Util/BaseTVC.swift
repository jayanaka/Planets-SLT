//
//  BaseTVC.swift
//  Planets SLT
//
//  Created by Chathura Jayanaka on 11/14/21.
//

import UIKit
import NVActivityIndicatorView
import SwiftMessages

class BaseTVC: UITableViewController {
    
    var activityIndicatorView: UIView?
    var activityIndicator: NVActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup activity indicator view
        setUpActivityIndicatorView()
    }
    
    //MARK: - Progress
    func showProgress() {
        activityIndicatorView?.isHidden = false
        activityIndicator?.startAnimating()
    }
    
    func hideProgress() {
        activityIndicatorView?.isHidden = true
        activityIndicator?.stopAnimating()
    }
    
    // Setup activity indicator view
    func setUpActivityIndicatorView() {
        activityIndicatorView = UIView(frame: self.view.bounds)
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView?.backgroundColor = UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5)

        let frame = CGRect(x: (self.view.frame.width - 60)/2, y: (self.view.frame.height - 60)/2, width: 60, height: 60)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator?.type = . ballScale
        activityIndicator?.color = UIColor.red
        
        activityIndicatorView!.addSubview(activityIndicator!)

        activityIndicatorView?.isHidden = true
        self.view.bringSubviewToFront(activityIndicatorView!)
        
    }
    
    // Show Message
    func showMessage(isError: Bool, title: String, message: String) {
        if !message.isEmpty {
            let error = MessageView.viewFromNib(layout: .messageView)
                var config = SwiftMessages.defaultConfig
                config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
              
              if isError {
                  error.configureTheme(.error)
              } else {
                  error.configureTheme(.success)
              }
                
              error.configureContent(title: "", body: message)
              error.button?.setTitle("Stop", for: .normal)
              error.button?.isHidden = true
            
              SwiftMessages.show(config: config, view: error)
        }
    }

}
