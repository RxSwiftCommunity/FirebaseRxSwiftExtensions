import Foundation
import RxSwift
import Firebase

public extension Firebase {
    
    func rx_firebaseObserveEvent(eventType: FEventType) -> Observable<FDataSnapshot> {
        return create { (observer: ObserverOf<FDataSnapshot>) -> Disposable in
            
            let handle = self.observeEventType(eventType, withBlock: { (snapshot: FDataSnapshot!) -> Void in
                sendNext(observer, snapshot)
            }, withCancelBlock: { (error: NSError!) -> Void in
                sendError(observer, error)
            })
            
            return AnonymousDisposable{
                self.removeObserverWithHandle(handle)
            }
            
        }
        
    }
    
    func rx_firebaseObserveSingleEvent(eventType: FEventType) -> Observable<FDataSnapshot> {
        return create { (observer: ObserverOf<FDataSnapshot>) -> Disposable in
            
            self.observeSingleEventOfType(eventType, withBlock: { (snapshot: FDataSnapshot!) -> Void in
                sendNext(observer, snapshot)
                sendCompleted(observer)
            }, withCancelBlock: { (error: NSError!) -> Void in
                sendError(observer, error)
            })
            
            return AnonymousDisposable{
                
            }
        }
    }
    
    func rx_firebaseSetValue(value: AnyObject!) -> Observable<Firebase> {
        return create({ (observer :ObserverOf<Firebase>) -> Disposable in
            
            self.setValue(value, withCompletionBlock: { (error, firebase) -> Void in
                if error != nil {
                    sendError(observer, error)
                }else{
                    sendNext(observer, firebase)
                    sendCompleted(observer)
                }
            })
            
            return AnonymousDisposable{}
        })
    }
    
    func rx_firebaseSetValue(value: AnyObject!, priority : AnyObject! ) -> Observable<Firebase> {
        return create({ (observer :ObserverOf<Firebase>) -> Disposable in
            
            self.setValue(value, andPriority: priority, withCompletionBlock: { (error, firebase) -> Void in
                if error != nil {
                    sendError(observer, error)
                }else{
                    sendNext(observer, firebase)
                    sendCompleted(observer)
                }
            })
            
            return AnonymousDisposable{}
        })
    }
    
}