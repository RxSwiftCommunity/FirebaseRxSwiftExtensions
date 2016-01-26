# FirebaseRxSwiftExtensions

[![CI Status](http://img.shields.io/travis/Maximilian Alexander/FirebaseRxSwiftExtensions.svg?style=flat)](https://travis-ci.org/Maximilian Alexander/FirebaseRxSwiftExtensions)
[![Version](https://img.shields.io/cocoapods/v/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![License](https://img.shields.io/cocoapods/l/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![Platform](https://img.shields.io/cocoapods/p/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

This library is built on Swift 2.1 and needs Xcode 7 to work.
This library is build for RxSwift 2.0.0-alpha 4 or higher. Please take note of the syntax changes when migrating from an
older version of Swift to Swift 2 or higher.

## Installation

FirebaseRxSwiftExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FirebaseRxSwiftExtensions"
```

## Modules Needed

import Firebase
import RxSwift
import FirebaseRxSwiftExtensions

### Highly Recommended

## Use DisposeBags
I highly recommend always having a `disposeBag` available in every controller.
It's very important to dispose the subscription or else Firebase may never stop listening when ViewControllers are deallocated

If you are referencing a weak variable in your `subscribe` or `subscribeNext` blocks, please make sure to use `[unowned self]` to prevent
a retain cycle.

For example:

```swift
    var disposeBag = DisposeBag()
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad(animated: bool)
        // .. stuff

        query.rx_observe(FEventType.ChildAdded)
            .subscribeNext{ [unowned self] snapshot in
                self.nameLabel.text = snapshot.value["name"] as! String
            }
            .addDisposableTo(disposeBag)
    }
```

### Observe a Snapshot

The `rx_observe(eventType: FEventType)` method observes a Firebase reference or a FQuery for its snapshot.

```swift
    let query = Firebase(url: "myUrl").queryOrderedByChild("height")
    query.rx_observe(.ChildAdded)
        .subscribeNext{ (snapshot: FDataSnapshot) in
            //do something with your snapshot
        }

To listen for a snapshot and it's siblingKey. This is useful events like FEventType.ChildMoved and FEventType.ChildChanged

    let query = Firebase(url: "myUrl").queryOrderedByChild("height")

    query.rx_observeWithSiblingKey(.ChildRemoved)
        .subscribeNext{ (tuple: (FDataSnapshot, String) in
            // The tuple contains the snapshot and the sibling key
        }
```

Cool hint: You can name parts of your tuple to make things easier

```swift
    let query = Firebase(url: "myUrl").queryOrderedByChild("height")

    query.rx_observeWithSiblingKey(.ChildRemoved)
        .subscribeNext{ (tuple: (snapshot: FDataSnapshot, siblingKey: String) in
            // The tuple contains the snapshot and the sibling key
            print(tuple.snapshot)
            print(tuple.siblingKey)
        }
```


### Observe a Snapshot Once

I didn't create an observeSingleEvent rx method. Simply just do a `take(1)` on an FQuery or Firebase reference.

```swift
    queryOrRef.rx_observe(.ChildAdded).take(1)
        .subscribeNext{ (snapshot: FDataSnapshot) in
            //this snapshot is fired once and the listener is disposed of as soon as it fires just once.
        }
```

### Set and Update values

These are relatively straight forward. The operate exactly like their native Firebase equivalents

- `rx_setValues`
- `rx_updateChildValues`

## Authentication

You can easily observe your authentication state

```swift
    let ref = Firebase(url: "myUrl")
    ref.rx_authObservable()
        .subscribeNext{ authData in
            if let authData == authData {
                print("You're logged in, authData is not nil")
            }else{
                print("You are NOT logged in")
            }
        }
```

You can authenticate with respective methods

```swift
    rx_auth(email: String, password: String) -> Observable<FAuthData>
    rx_authWithCustomToken(customToken: String) -> Observable<FAuthData>
    rx_authWithOAuthProvider(provider: String, token: String) -> Observable<FAuthData>
    rx_authWithOAuthProvider(provider: String, parameters: [NSObject: AnyObject]) -> Observable<FAuthData>
    rx_authAnonymously() -> Observable<FAuthData>
```

More authentication methods to come!

## Convenience methods

You can check if a snapshot has a value or not by these two extension methods. They operate on `Observable<FDataSnapshot>`

- `rx_filterWhenNSNull()`
- `rx_filterWhenNotNSNull()`

## Author

Maximilian Alexander, mbalex99@gmail.com

## License

FirebaseRxSwiftExtensions is available under the MIT license. See the LICENSE file for more info.
