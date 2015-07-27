# FirebaseRxSwiftExtensions

[![CI Status](http://img.shields.io/travis/Maximilian Alexander/FirebaseRxSwiftExtensions.svg?style=flat)](https://travis-ci.org/Maximilian Alexander/FirebaseRxSwiftExtensions)
[![Version](https://img.shields.io/cocoapods/v/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![License](https://img.shields.io/cocoapods/l/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![Platform](https://img.shields.io/cocoapods/p/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)

## Requirements

You will need `ios 8.0` or higher. OSX support is coming soon.

## Installation

FirebaseRxSwiftExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FirebaseRxSwiftExtensions"
```

In your code use:

    import FirebaseRxSwiftExtensions

## Description

This is a set of helper extension methods for Firebase's iOS library that creates `Observable<FDataSnapshot>` and `Observable<FAuthData>`
from their listener APIs.

For example a regular Firebase listener without RxSwift might look like this:

    // Get a reference to our posts
    var ref = Firebase(url:"https://docs-examples.firebaseio.com/web/saving-data/fireblog/posts")

    // Attach a closure to read the data at our posts reference
    ref.observeEventType(FEventType.Value, withBlock: { snapshot in
        println(snapshot.value)
    }, withCancelBlock: { error in
        println(error.description)
    })

With these extensions you can create `Observable<FDataSnapshot>`

    ref.rx_firebaseObserveEvent(FEventType.Value)
        >- subscribeNext { snapshot in
            println(snapshot.value)
        }

## Retrieve Data Examples

Perpetually listening to an event is rather simple. Just specify the `FEventType`.

    ref.rx_firebaseObserveEvent(FEventType.Value)
        >- subscribeNext { snapshot in
            println(snapshot.value)
        }

Or you can listen to all the events. Just beware, that `rx_firebaseObserveEvent` only sends "next". It never completes because it will always listen to that path until it's disposed.

    ref.rx_firebaseObserveEvent(.Value)
        >- subscribe(next: { (snapshot: FDataSnapshot) -> Void in
            println(snapshot.value)  
        }, error: { (error: NSError!) -> Void in
            println("Uh oh")
        }, completed: { () -> Void in
            println("This signal never completes")
        })

Retrieving a *single* event will also fire a "completed" signal

    ref.rx_firebaseObserveSingleEvent(FEventType.Value)
        >- subscribeNext { snapshot in
            println(snapshot.value)
        }
Unlike `rx_firebaseObserveEvent`, `rx_firebaseObserveSingleEvent` *does* complete

    ref.rx_firebaseObserveSingleEvent(.Value)
        >- subscribe(next: { (snapshot: FDataSnapshot) -> Void in
            println(snapshot.value)  
        }, error: { (error: NSError!) -> Void in
            println("Uh oh")
        }, completed: { () -> Void in
            println("This signal does complete")
        })

You can also observe an `Observable<FAuthData>`

    ref.rx_firebaseObserveAuth()
        >- subscribeNext { (authData: FAuthData) in
            println(snapshot.value)
        }

This will not fire unless the user is logged in. There is no current API from Firebase that exposes an error. This is not a signal that completes.

In addition, I've added two methods that extend Firebase's login methods

    rx_firebaseAuthUser(email: String, password: String) -> Observable<FAuthData>
    rx_firebaseAuthAnonymousUser() -> Observable<FAuthData>

Support for their 3rd party authentication (Twitter, Facebook etc...) is coming soon.

## Update or Insert Data Examples

You can also update or insert data with:

    rx_firebaseSetValue(value: AnyObject!) -> Observable<Firebase>
    rx_firebaseSetValue(value: AnyObject!, priority : AnyObject! ) -> Observable<Firebase>

These signals are atomic and do complete.

## Author

Maximilian Alexander, mbalex99@gmail.com

## License

FirebaseRxSwiftExtensions is available under the MIT license. See the LICENSE file for more info.
