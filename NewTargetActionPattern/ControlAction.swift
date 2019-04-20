//
//  ControlAction.swift
//  NewTargetActionPattern
//
//  Created by Iragam Reddy, Sreekanth Reddy on 3/31/19.
//  Copyright © 2019 Iragam Reddy, Sreekanth Reddy. All rights reserved.
//

import UIKit

// MARK: - UIControl / ControlAction -

public protocol ControlActionConfigurable {}
extension UIControl: ControlActionConfigurable {}

/// Encapsulates a closure that will run in response to a specified UIControlEvent sent by a specific type of UIControl
public final class ControlAction<ControlType: UIControl>: NSObject {
    
    private let action: (ControlType, UIControl.Event) -> ()
    fileprivate let controlEvents: UIControl.Event
    
    public static func touchDown(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDown { action($0) }}, for: [.touchDown])
    }
    
    public static func touchDownRepeat(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDownRepeat { action($0) }}, for: [.touchDownRepeat])
    }
    
    public static func touchDragInside(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDragInside { action($0) }}, for: [.touchDragInside])
    }
    
    public static func touchDragOutside(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDragOutside { action($0) }}, for: [.touchDragOutside])
    }
    
    public static func touchDragEnter(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDragEnter { action($0) }}, for: [.touchDragEnter])
    }
    
    public static func touchDragExit(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchDragExit { action($0) }}, for: [.touchDragExit])
    }
    
    public static func touchUpInside(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchUpInside { action($0) }}, for: [.touchUpInside])
    }
    
    public static func touchUpOutside(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchUpOutside { action($0) }}, for: [.touchUpOutside])
    }
    
    public static func touchCancel(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .touchCancel { action($0) }}, for: [.touchCancel])
    }
    
    public static func valueChanged(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .valueChanged { action($0) }}, for: [.valueChanged])
    }
    
    public static func primaryActionTriggered(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .primaryActionTriggered { action($0) }}, for: [.primaryActionTriggered])
    }
    
    public static func editingDidBegin(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .editingDidBegin { action($0) }}, for: [.editingDidBegin])
    }
    
    public static func editingChanged(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .editingChanged { action($0) }}, for: [.editingChanged])
    }
    
    public static func editingDidEnd(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: { if $1 == .editingDidEnd { action($0) }}, for: [.editingDidEnd])
    }
    
    public static func editingDidEndOnExit(_ action: @escaping (ControlType) -> ()) -> ControlAction<ControlType> {
        // action()
        return ControlAction<ControlType>(action: {
            if $1 == .editingDidEndOnExit { action($0) }
            
        }
            , for: [.editingDidEndOnExit])
    }
    
    private init(action: @escaping (ControlType, UIControl.Event) -> (), for controlEvents: UIControl.Event) {
        self.action = action
        self.controlEvents = controlEvents
    }
    
    /// Returns a new ControlAction which, when triggered, will first call the original action, and then call the action passed in as a parameter.
    public func followed(by action: ControlAction<ControlType>) -> ControlAction<ControlType> {
        return ControlAction<ControlType>(action: {
            [original = self.action, following = action.action] in
            original($0, $1)
            following($0, $1)
            }, for: action.controlEvents.union(self.controlEvents))
    }
    
    @objc fileprivate func touchDownAction(sender: Any) {
        action(sender as! ControlType, .touchDown)
    }
    
    @objc fileprivate func touchDownRepeatAction(sender: Any) {
        action(sender as! ControlType, .touchDownRepeat)
    }
    
    @objc fileprivate func touchDragInsideAction(sender: Any) {
        action(sender as! ControlType, .touchDragInside)
    }
    
    @objc fileprivate func touchDragOutsideAction(sender: Any) {
        action(sender as! ControlType, .touchDragOutside)
    }
    
    @objc fileprivate func touchDragEnterAction(sender: Any) {
        action(sender as! ControlType, .touchDragEnter)
    }
    
    @objc fileprivate func touchDragExitAction(sender: Any) {
        action(sender as! ControlType, .touchDragExit)
    }
    
    @objc fileprivate func touchUpInsideAction(sender: Any) {
        action(sender as! ControlType, .touchUpInside)
    }
    
    @objc fileprivate func touchUpOutsideAction(sender: Any) {
        action(sender as! ControlType, .touchUpOutside)
    }
    
    @objc fileprivate func touchCancelAction(sender: Any) {
        action(sender as! ControlType, .touchCancel)
    }
    
    @objc fileprivate func valueChangedAction(sender: Any) {
        action(sender as! ControlType, .valueChanged)
    }
    
    @objc fileprivate func primaryActionTriggeredAction(sender: Any) {
        action(sender as! ControlType, .primaryActionTriggered)
    }
    
    @objc fileprivate func editingDidBeginAction(sender: Any) {
        action(sender as! ControlType, .editingDidBegin)
    }
    
    @objc fileprivate func editingChangedAction(sender: Any) {
        action(sender as! ControlType, .editingChanged)
    }
    
    @objc fileprivate func editingDidEndAction(sender: Any) {
        action(sender as! ControlType, .editingDidEnd)
    }
    
    @objc fileprivate func editingDidEndOnExitAction(sender: Any) {
        action(sender as! ControlType, .editingDidEndOnExit)
    }
}

// Adds operator overload for combining control actions
public extension ControlAction {
    /// Combines / composes the left and right ControlActions into a single ControlAction that first runs the action from the left side and then runs the action from the right side
    public static func +(left: ControlAction<ControlType>, right: ControlAction<ControlType>) -> ControlAction<ControlType> {
        return left.followed(by: right)
    }
}

/// Combines / composes the optional left and right ControlActions into a single optional ControlAction that first runs the action from the left side and then runs the action from the right side
public func +<ControlType>(left: ControlAction<ControlType>?, right: ControlAction<ControlType>?) -> ControlAction<ControlType>? {
    switch (left, right) {
    case (.some(let leftAction), .some(let rightAction)):
        return leftAction.followed(by: rightAction)
    case (.some(let leftAction), .none):
        return leftAction
    case (.none, .some(let rightAction)):
        return rightAction
    case (.none, .none):
        return nil
    }
}

/// Allows using a single closure for multiple UIControlEvents. For example, if you wanted to change the tint color of a button in reponse to the touchUpInside, the touchUpOutside AND the touchCancel UIControlEvents, you could write (ControlAction.touchUpInside + ControlAction.touchUpOutside + ControlAction.touchCancel){ (button: UIButton) in button.tintColor = .blue }
public func +<ControlType>(left: @escaping (@escaping (ControlType) -> ()) -> ControlAction<ControlType>, right: @escaping (@escaping (ControlType) -> ()) -> ControlAction<ControlType>) -> (@escaping (ControlType) -> ()) -> ControlAction<ControlType> {
    return {
        left($0) + right($0)
    }
}

extension ControlActionConfigurable where Self: UIControl {
    
    public func setAction(_ controlAction: ControlAction<Self>?) {
       objc_setAssociatedObject(self, &AssociationKey.controlAction, controlAction, .OBJC_ASSOCIATION_RETAIN)
        if controlAction?.controlEvents.contains(.touchDown) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDownAction(sender:)), for: .touchDown)
        }
        if controlAction?.controlEvents.contains(.touchDownRepeat) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDownRepeatAction(sender:)), for: .touchDownRepeat)
        }
        if controlAction?.controlEvents.contains(.touchDragInside) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDragInsideAction(sender:)), for: .touchDragInside)
        }
        if controlAction?.controlEvents.contains(.touchDragOutside) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDragOutsideAction(sender:)), for: .touchDragOutside)
        }
        if controlAction?.controlEvents.contains(.touchDragEnter) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDragEnterAction(sender:)), for: .touchDragEnter)
        }
        if controlAction?.controlEvents.contains(.touchDragExit) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchDragExitAction(sender:)), for: .touchDragExit)
        }
        if controlAction?.controlEvents.contains(.touchUpInside) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchUpInsideAction(sender:)), for: .touchUpInside)
        }
        if controlAction?.controlEvents.contains(.touchUpOutside) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchUpOutsideAction(sender:)), for: .touchUpOutside)
        }
        if controlAction?.controlEvents.contains(.touchCancel) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.touchCancelAction(sender:)), for: .touchCancel)
        }
        if controlAction?.controlEvents.contains(.valueChanged) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.valueChangedAction(sender:)), for: .valueChanged)
        }
        if controlAction?.controlEvents.contains(.primaryActionTriggered) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.primaryActionTriggeredAction(sender:)), for: .primaryActionTriggered)
        }
        if controlAction?.controlEvents.contains(.editingDidBegin) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.editingDidBeginAction(sender:)), for: .editingDidBegin)
        }
        if controlAction?.controlEvents.contains(.editingChanged) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.editingChangedAction(sender:)), for: .editingChanged)
        }
        if controlAction?.controlEvents.contains(.editingDidEnd) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.editingDidEndAction(sender:)), for: .editingDidEnd)
        }
        if controlAction?.controlEvents.contains(.editingDidEndOnExit) == true {
            addTarget(controlAction, action: #selector(ControlAction<Self>.editingDidEndOnExitAction(sender:)), for: .editingDidEndOnExit)
        }
    }
}

internal extension UIControl {
    internal struct AssociationKey {
        static var controlAction = "controlAction"
    }
}


// MARK: - TargetAction -

public protocol TargetActionConfigurable {}
extension UIGestureRecognizer: TargetActionConfigurable {}
extension UIBarButtonItem: TargetActionConfigurable {}

/// Encapsulates a closure that will run as the action triggered by a UIGestureRecognizer or UIBarButtonItem
public final class TargetAction<SenderType>: NSObject {
    private let action: (SenderType) -> ()
    public init(action: @escaping (SenderType) -> ()) {
        self.action = action
    }
    
    /// Returns a new TargetAction which, when triggered, will first call the original action, and then call the action passed in as a parameter.
    public func followed(by action: TargetAction<SenderType>) -> TargetAction<SenderType> {
        return TargetAction<SenderType> {
            [original = self.action, following = action.action] in
            original($0)
            following($0)
        }
    }
    
    @objc fileprivate func action(sender: Any) {
        action(sender as! SenderType)
    }
}

public extension TargetAction {
    /// Combines / composes the left and right TargetActions into a single ControlAction that first runs the action from the left side and then runs the action from the right side
    public static func +(left: TargetAction<SenderType>, right: TargetAction<SenderType>) -> TargetAction<SenderType> {
        return left.followed(by: right)
    }
}

/// Combines / composes the optional left and right TargetActions into a single TargetAction that first runs the action from the left side and then runs the action from the right side
public func +<SenderType>(left: TargetAction<SenderType>?, right: TargetAction<SenderType>?) -> TargetAction<SenderType>? {
    switch (left, right) {
    case (.some(let leftAction), .some(let rightAction)):
        return leftAction.followed(by: rightAction)
    case (.some(let leftAction), .none):
        return leftAction
    case (.none, .some(let rightAction)):
        return rightAction
    case (.none, .none):
        return nil
    }
}

public extension TargetActionConfigurable where Self: UIGestureRecognizer {
    public func setAction(_ targetAction: TargetAction<Self>?) {
        objc_setAssociatedObject(self, &AssociationKey.targetAction, targetAction, .OBJC_ASSOCIATION_RETAIN)
        if let targetAction = targetAction {
            addTarget(targetAction, action: #selector(TargetAction<Self>.action(sender:)))
        } else {
            removeTarget(objc_getAssociatedObject(self, &AssociationKey.targetAction), action: #selector(TargetAction<Self>.action(sender:)))
        }
    }
}

public extension TargetActionConfigurable where Self: UIBarButtonItem {
    public func setAction(_ targetAction: TargetAction<Self>?) {
        objc_setAssociatedObject(self, &AssociationKey.targetAction, targetAction, .OBJC_ASSOCIATION_RETAIN)
        target = targetAction
        action = targetAction != nil ? #selector(TargetAction<Self>.action(sender:)) : nil
    }
}

internal extension UIGestureRecognizer {
    internal struct AssociationKey {
        static var targetAction = "targetAction"
    }
}

internal extension UIBarButtonItem {
    internal struct AssociationKey {
        static var targetAction = "targetAction"
    }
}


