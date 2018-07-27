Articles Review it's a project where the user should mark a list of article as “liked” or ”disliked”, one by one. After that, the user has the possibility to review his choices by pressing the "Review" button. Consuming the Home24 public API to load the articles and using [RxSwift](https://github.com/ReactiveX/RxSwift) to handle asynchronous events. MVVM is used as the design pattern and concepts as Clean Code and Dependency Injection are also present. A small number of Unit tests are included in the application, as future steps, more Unit and UI tests would be written.

## Setup:

This application uses:

* macOS High Sierra 10.13.6
* Xcode 9.4.1
* Swift 4.1
* iOS 10+

## Dependencies

Carthage is used for dependency management. It involves less friction than e.g. Cocoapods.

To run the application, get started with development or after an update by another developer, simply run:

```
$ carthage update --platform ios
```
Ensure that Carthage is set up. To know how to install, check [Carthage docs](https://github.com/Carthage/Carthage#installing-carthage)

## Built With

*[RxSwift](https://github.com/ReactiveX/RxSwift) - To handle asynchronous events. Reactive programming was chosen because of it possible to express static and dynamic data streams with ease and in a more readable way.
*[RxAlamofire](https://github.com/RxSwiftCommunity/RxAlamofire) - To perform networking tasks using RxSwift.
*[Nimble](https://github.com/Quick/Nimble) - To make tests more pleasant to read.


## Run Tests

### Xcode

Go to `Product > Test` or press `command + U`
