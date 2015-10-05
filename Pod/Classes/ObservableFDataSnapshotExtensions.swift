//
//  ObservableFDataSnapshotExtensions.swift
//  Pods
//
//  Created by Maximilian Alexander on 10/4/15.
//
//

import RxSwift

public extension ObservableType where E : FDataSnapshot {
    
    func rx_filterWhenNSNull() -> Observable<E> {
        return self.filter { (snapshot) -> Bool in
            return snapshot.value is NSNull
        }
    }
    
    func rx_filterWhenNotNSNull() -> Observable<E> {
        return self.filter { (snapshot) -> Bool in
            return !(snapshot.value is NSNull)
        }
    }
    
}
