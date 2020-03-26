//
//  WRRuntime.swift
//  EmptyDemo
//
//  Created by 项辉 on 2020/3/25.
//  Copyright © 2020 项辉. All rights reserved.
//

import UIKit

public protocol WRRuntimeProtocol: WRLoadFunction {
    static var wr_swizzleMethods: [(Selector, Selector)] {get set}
}

extension WRRuntimeProtocol {
    public static func awake() {
        wr_swizzleMethods.forEach { swizzle(original: $0, replace: $1) }
    }
    
    fileprivate static func swizzle(original oldMethod: Selector, replace newMethod: Selector) {
        guard let classType = self as? AnyClass  else {
            return
        }
        
        self.wr_exchangeMethod(selector: oldMethod, replace: newMethod, class: classType)
    }

    public static func wr_exchangeMethod(selector: Selector, replace: Selector, class classType: AnyClass) {
        guard let oldSelector = class_getInstanceMethod(classType, selector), let newSelector = class_getInstanceMethod(classType, replace) else {
            return
        }
        method_exchangeImplementations(oldSelector, newSelector)
    }

    public static func wr_methods(from classType: AnyClass) -> [Method] {
        var methodNum: UInt32 = 0
        var list = [Method]()
        let methods = class_copyMethodList(classType, &methodNum)
        for index in 0..<numericCast(methodNum) {
            if let met = methods?[index] {
                list.append(met)
            }
        }
        free(methods)
        return list
    }

    public static func wr_properties(from classType: AnyClass) -> [objc_property_t] {
        var propNum: UInt32 = 0
        let properties = class_copyPropertyList(classType, &propNum)
        var list = [objc_property_t]()
        for index in 0..<Int(propNum) {
            if let prop = properties?[index]{
                list.append(prop)
            }
        }
        free(properties)
        return list
    }
    
    public static func wr_ivars(from classType: AnyClass) -> [Ivar] {
        var ivarNum: UInt32 = 0
        let ivars = class_copyIvarList(classType, &ivarNum)
        var list = [Ivar]()
        for index in 0..<numericCast(ivarNum) {
            if let ivar: objc_property_t = ivars?[index] {
                list.append(ivar)
            }
        }
        free(ivars)
        return list
    }

    
}

// MARK:- WRLoad 定义协议，使得程序在初始化的时候，将遵循该协议的类做了方法交换
public protocol WRLoadFunction {
    static func awake()
}

class WRNothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? WRLoadFunction.Type)?.awake()
        }
        //types.deallocate(capacity: typeCount)
        types.deallocate()
    }
}

extension UIApplication {
    private static let wt_runOnce: Void = {
        WRNothingToSeeHere.harmlessFunction()
    }()
    
    override open var next: UIResponder? {
        // Called before applicationDidFinishLaunching
        UIApplication.wt_runOnce
        return super.next
    }
}

