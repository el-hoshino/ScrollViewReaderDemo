//
//  Swizzle.swift
//  ScrollViewReaderDemo
//
//  Created by 史 翔新 on 2021/08/18.
//

import UIKit

extension UITableView {
    
    private struct SwizzleStatic {
        static var once = true
    }
    
    static func swizzle() {
        guard SwizzleStatic.once else {
            return
        }
        
        SwizzleStatic.once = false
        
        let aClass: AnyClass! = object_getClass(UITableView())
        let originalMethod = class_getInstanceMethod(aClass, #selector(scrollToRow(at:at:animated:)))!
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(swizzledScrollToRow(at:at:animated:)))!
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func swizzledScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        var indexPath = indexPath
        print(indexPath)
        if indexPath.row == 0 {
            indexPath.row = NSNotFound
        }
        swizzledScrollToRow(at: indexPath, at: scrollPosition, animated: true)
    }
    
}
