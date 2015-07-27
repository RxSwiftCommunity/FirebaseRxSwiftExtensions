# FirebaseRxSwiftExtensions

[![CI Status](http://img.shields.io/travis/Maximilian Alexander/FirebaseRxSwiftExtensions.svg?style=flat)](https://travis-ci.org/Maximilian Alexander/FirebaseRxSwiftExtensions)
[![Version](https://img.shields.io/cocoapods/v/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![License](https://img.shields.io/cocoapods/l/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)
[![Platform](https://img.shields.io/cocoapods/p/FirebaseRxSwiftExtensions.svg?style=flat)](http://cocoapods.org/pods/FirebaseRxSwiftExtensions)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FirebaseRxSwiftExtensions is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FirebaseRxSwiftExtensions"
```

In your code use:

    import FirebaseRxSwiftExtensions

## Description

This is a set of helper extension methods for Firebase's iOS library that creates Observable<FDataSnapshot> and Observable<FAuthData>
from their listener APIs.

For example a regular Firebase listener without RxSwift might look like this:

    // Get a reference to our posts
    var ref = Firebase(url:"https://docs-examples.firebaseio.com/web/saving-data/fireblog/posts")

    // Attach a closure to read the data at our posts reference
    ref.observeEventType(.Value, withBlock: { snapshot in
        println(snapshot.value)
    }, withCancelBlock: { error in
        println(error.description)
    })

With these extensions you can create Observable<FDataSnapshot> 

    ref.rx_firebaseObserveEvent(.Value)
        >- subscribeNext { snapshot in
            println(snapshot.value)
        }

## Author

Maximilian Alexander, mbalex99.com

## License

FirebaseRxSwiftExtensions is available under the MIT license. See the LICENSE file for more info.
