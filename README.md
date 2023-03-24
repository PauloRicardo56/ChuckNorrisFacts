# Chuck Norris Facts

## Code
- The way the ViewController communicates with the ViewModel has been changed, so that the Observable is no longer a function return, but a bind to the ViewModel property (facts). This was done with the aim of having the same communication with the API errors, and also to make ViewModel inputs/outputs more defined.
- The search bar query observable was changed to a trait (Driver) so that any event is observable on the main thread and it can not error out.
- The View Controller subscription setup was passed to a method, so that it can be called after the View Controller is instantiated. This was done due to the tests with screenshots, when a screenshot was taken the viewDidLoad was called again (making new subscriptions), this meant that the previously emitted events (PublishObject) were not captured by the 'new' subscriptions.
- The URLSession request method was changed from .data(request:) to .response(request:) in order to process returned REST errors.
- Custom lane created so that, in a single line, all the application's tests are run, including the option to take, or not, screenshots during tests.
- At first, Nimble-Snapshots would be used for view tests, but as this has already been used in previous projects, I decided to use FBSnapshotTestCase for learning purposes.

### UI
- Color palette was chosen over the API logo.
- Fonts used were based on the ones used in the API documentation.

### Do not insert Pods/ in .gitignore
- The machine that will run the project doesn't need to have CocoaPods installed.
- After cloning the repository, the project will be ready to run.
- The CocoaPods documentation recommends to not add the Pods folder to `.gitignore`.


## Project execution
- Minimum iOS version: 14.0
