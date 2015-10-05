import Firebase
import RxSwift

//Authentication Extension Methods
public extension FQuery {
    
    
    /**
        - Returns: An `Observable<FAuthData?>`, `FAuthData?` will be nil if the user is logged out.
    */
    var rx_observeAuth :Observable<FAuthData?> {
        get {
            return create({ (observer: ObserverOf<FAuthData?>) -> Disposable in
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
        return create({ (observer: ObserverOf<FAuthData>) -> Disposable in
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
}

