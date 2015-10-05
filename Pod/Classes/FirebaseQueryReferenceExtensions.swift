//
//  FirebaseReferenceExtensions.swift
//  Pods
//
//  Created by Maximilian Alexander on 10/4/15.
//
//

import RxSwift

public extension FQuery {
    
    func rx_observe(eventType: FEventType) -> Observable<FDataSnapshot> {
        let ref = self;
        return create({ (observer : ObserverOf<FDataSnapshot>) -> Disposable in
            let listener = ref.observeEventType(eventType, withBlock: { (snapshot) -> Void in
                observer.on(.Next(snapshot))
            }, withCancelBlock: { (error) -> Void in
                observer.on(.Error(error))
            })
            return AnonymousDisposable{
                ref.removeObserverWithHandle(listener)
            }
        })
    }
    /**
        - Returns: A tuple `Observable<(FDataSnapshot, String)>` with the first value as the snapshot and the second value as the sibling key
    */
    func rx_observeWithSiblingKey(eventType: FEventType) -> Observable<(FDataSnapshot, String)> {
        let ref = self;
        return create({ (observer : ObserverOf<(FDataSnapshot, String)>) -> Disposable in
            let listener = ref.observeEventType(eventType, andPreviousSiblingKeyWithBlock: { (snapshot, siblingKey) -> Void in
                let tuple : (FDataSnapshot, String) = (snapshot, siblingKey)
                    observer.on(.Next(tuple))
                }, withCancelBlock: { (error) -> Void in
                    observer.on(.Error(error))
            })
            return AnonymousDisposable{
                ref.removeObserverWithHandle(listener)
            }
        })
    }
    
    /**
        - Returns: The firebase reference where the update occured
    */
    func rx_updateChildValues(values: [NSObject: AnyObject!]) -> Observable<Firebase> {
        let query = self
        return create({ (observer: ObserverOf<Firebase>) -> Disposable in
            query.ref.updateChildValues(values, withCompletionBlock: { (error, firebase) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                } else{
                    observer.on(.Next(firebase))
                    observer.on(.Completed)
                }
            })
            
            return AnonymousDisposable{}
        })
    }
    
    func rx_setValue(value: AnyObject!, priority: AnyObject? = nil) -> Observable<Firebase> {
        let query = self
        return create({ (observer: ObserverOf<Firebase>) -> Disposable in
            if let priority = priority {
                query.ref.setValue(value, andPriority: priority, withCompletionBlock: { (error, firebase) -> Void in
                    if let error = error {
                        observer.on(.Error(error))
                    } else{
                        observer.on(.Next(firebase))
                        observer.on(.Completed)
                    }
                })
            }else {
                query.ref.setValue(value, withCompletionBlock: { (error, firebase) -> Void in
                    if let error = error {
                        observer.on(.Error(error))
                    } else{
                        observer.on(.Next(firebase))
                        observer.on(.Completed)
                    }
                })
            }
            return AnonymousDisposable{}
        })
    }
    
    
    
}




