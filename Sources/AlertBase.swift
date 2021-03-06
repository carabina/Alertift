//
//  AlertBase.swift
//  Alertift
//
//  Created by Suguru Kishimoto on 4/27/17.
//  Copyright © 2017 Suguru Kishimoto. All rights reserved.
//

import Foundation

extension Alertift {
    /// AlertBase
    /// superclass of Alert, ActionSheet.
    public class AlertBase {
        
        /// UIAlertController
        public var alertController: UIAlertController {
            return _alertController as UIAlertController
        }
        
        /// InnerAlertController (internal).
        let _alertController: InnerAlertController
        
        /// Handler for finally.
        private var finallyHandler: Alertift.FinallyHandler?
        
        
        /// Initializer
        ///
        /// - Parameters:
        ///   - title: The title of the alert. Use this string to get the user’s attention and communicate the reason for the alert.
        ///   - message: Descriptive text that provides additional details about the reason for the alert.
        ///   - style: The style to use when presenting the alert controller. Use this parameter to configure the alert controller as an action sheet or as a modal alert.
        init(title: String? = nil, message: String? = nil, style: UIAlertControllerStyle) {
            _alertController = InnerAlertController(title: title, message: message, preferredStyle: style)
        }
        
        /// Build **UIAlertAction** using **Alertift.Action** and handler.
        ///
        /// - Parameters:
        ///   - action: action
        ///   - handler: The handler to execute after the action selected.
        /// - Returns: **UIAlertAction**
        func buildAlertAction(_ action: Alertift.Action, handler: @escaping (UIAlertAction) -> Void) -> UIAlertAction {
            return action.buildAlertAction(handler: handler)
        }
        
        /// Add finally handler.
        ///
        /// - Parameter handler: The handler to execute after either alert selected.
        /// - Returns: Myself
        public func finally(handler: @escaping Alertift.FinallyHandler) -> Self {
            _alertController.finallyHandler = handler
            return self
        }
        
        /// Show alert (or action sheet).
        ///
        /// - Parameters:
        ///   - viewController: The view controller to display over the current view controller’s content. Default is **UIApplication.shared.keyWindow?.rootViewController**
        ///   - completion: The block to execute after the presentation finishes. This block has no return value and takes no parameters. You may specify nil for this parameter.
        final public func show(on viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController, completion: (() -> Void)? = nil) {
            viewController?.present(_alertController, animated: true, completion: completion)
        }        
    }
}
