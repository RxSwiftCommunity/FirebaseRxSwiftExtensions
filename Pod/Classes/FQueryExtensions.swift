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
    
    func run(){
        rx_firebaseObserveSingleEvent(.Value)
            >- subscribe(next: { (snapshot) -> Void in
                
            }, error: { (error) -> Void in
                
            }, completed: { () -> Void in
                println("This signal never completes")
            })
    }
    
}