import Firebase
import RxSwift

//Authentication Extension Methods
public extension FQuery {
    /**
        - Returns: An `Observable<FAuthData?>`, `FAuthData?` will be nil if the user is logged out.
    */
    var rx_authObservable :Observable<FAuthData?> {
        get {
            return Observable.create({ (observer: AnyObserver<FAuthData?>) -> Disposable in
                let ref = self.ref;
                let listener = ref.observeAuthEventWithBlock({ (authData: FAuthData?) -> Void in
                    observer.on(.Next(authData))
                })
                return AnonymousDisposable {
                    self.ref.removeAuthEventObserverWithHandle(listener)
                }
            })
        }
    }
    
    func rx_authUser(email: String, password: String) -> Observable<FAuthData> {
        let query = self;
        return Observable.create({ (observer: AnyObserver<FAuthData>) -> Disposable in
            query.ref.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                }else{
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            })
            return AnonymousDisposable{}
        })
    }
    
    
    func rx_authAnonymously() -> Observable<FAuthData> {
        let query = self;
        return Observable.create({ (observer: AnyObserver<FAuthData>) -> Disposable in
            query.ref.authAnonymouslyWithCompletionBlock({ (error, authData) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                }else{
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            })
            
            return AnonymousDisposable{}
        })
    }
    
    func rx_authWithOAuthProvider(provider: String, parameters: [NSObject: AnyObject]) -> Observable<FAuthData> {
        let query = self;
        return Observable.create({ (observer: AnyObserver<FAuthData>) -> Disposable in
            query.ref.authWithOAuthProvider(provider, parameters: parameters, withCompletionBlock: { (error, authData) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                }else{
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            })
            return AnonymousDisposable{}
        })
    }
    
    
    func rx_authWithOAuthProvider(provider: String, token: String) -> Observable<FAuthData> {
        let query = self;
        return Observable.create({ (observer: AnyObserver<FAuthData>) -> Disposable in
            query.ref.authWithOAuthProvider(provider, token: token, withCompletionBlock: { (error, authData) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                }else{
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            })
            return AnonymousDisposable{}
        })
    }
    
    func rx_authWithCustomToken(customToken: String) -> Observable<FAuthData> {
        let query = self;
        return Observable.create({ (observer: AnyObserver<FAuthData>) -> Disposable in
            query.ref.authWithCustomToken(customToken, withCompletionBlock: { (error, authData) -> Void in
                if let error = error {
                    observer.on(.Error(error))
                }else{
                    observer.on(.Next(authData))
                    observer.on(.Completed)
                }
            })
            return AnonymousDisposable{}
        })
    }
    
    
    func rx_observe(eventType: FEventType) -> Observable<FDataSnapshot> {
        let ref = self;
        return Observable.create({ (observer : AnyObserver<FDataSnapshot>) -> Disposable in
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
    func rx_observeWithSiblingKey(eventType: FEventType) -> Observable<(FDataSnapshot, String?)> {
        let ref = self;
        
        return Observable.create({ (observer : AnyObserver<(FDataSnapshot, String?)>) -> Disposable in
            let listener = ref.observeEventType(eventType, andPreviousSiblingKeyWithBlock: { (snapshot, siblingKey) -> Void in
                let tuple : (FDataSnapshot, String?) = (snapshot, siblingKey)
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
        return Observable.create({ (observer: AnyObserver<Firebase>) -> Disposable in
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
        
        
        
        return Observable.create({ (observer: AnyObserver<Firebase>) -> Disposable in
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
    
    func rx_removeValue() -> Observable<Firebase> {
        let query = self
        return Observable.create({ (observer: AnyObserver<Firebase>) -> Disposable in
            query.ref.removeValueWithCompletionBlock({ (err, ref) -> Void in
                if let err = err {
                    observer.onError(err)
                }else if let ref = ref {
                    observer.onNext(ref)
                    observer.onCompleted()
                }
            })
            return AnonymousDisposable{}
        })
    }
    
    func rx_runTransactionBlock(block: ((FMutableData!) -> FTransactionResult!)!) -> Observable<(isCommitted: Bool, snapshot : FDataSnapshot)> {
        let query = self
        return Observable.create({ (observer) -> Disposable in
            query.ref.runTransactionBlock(block) { (err, isCommitted, snapshot) -> Void in
                if let err = err {
                    observer.onError(err)
                } else if let snapshot = snapshot {
                    observer.onNext((isCommitted: isCommitted, snapshot: snapshot))
                    observer.onCompleted()
                }
            }
            return AnonymousDisposable {}
        })
    }
}

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


