//
//  Publisher+Assign.swift
//  Log
//
//  Created by AzumaSato on 2021/01/01.
//

import Combine

extension Publisher where Failure == Never {
  func assign<Root: AnyObject>(to keyPath: ReferenceWritableKeyPath<Root, Output>, on root: Root)
    -> AnyCancellable
  {
    sink { [weak root] in
      root?[keyPath: keyPath] = $0
    }
  }
}
