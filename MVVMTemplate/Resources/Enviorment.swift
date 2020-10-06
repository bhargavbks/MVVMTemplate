//
//  Enviorment.swift
//  MVVMTemplate
//
//  Created by Bhargav BKS on 03/10/2020.
//  Copyright © 2020 Bhargav BKS. All rights reserved.
//

import Foundation

public enum PlistKey: String {
  case baseUrl = "BaseUrl"
}

public struct Environment {
  fileprivate var infoDict: [String: Any] {
    get {
      if let dict = Bundle.main.infoDictionary {
        return dict
      }else {
        fatalError("Plist file not found")
      }
    }
  }
  
  public func config(_ key: PlistKey) -> String {
    switch key {
      case .baseUrl:
        return infoDict[PlistKey.baseUrl.rawValue] as! String
    }
  }
}
