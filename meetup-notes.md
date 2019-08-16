### Different ways to save date

`UserDefaults`, files (`Codable`), SQLite (not great option), Core Data

Core Data:
	- a bit old
	- OBjective-C --> not `Codable`; Core Data "optionals" are not Swift `optionals`

## Core Data

built around SQLite	

a common mistake is  to forget to specificy the tpye for `NSFetchRequest` generics (this is the same for other parts  of Core Data)


### Questions

What is a "context"?

What is a singleton?

When to make things private.

What is static?


### NB

[Sourcery](https://github.com/krzysztofzablocki/Sourcery) - "Meta-programming for Swift, stop writing boilerplate code."

Ask Zev about his Terminal set-up (code completion, next line thing)
 - he uses `zsh` and the functionality comes from `Oh-my-zsh`
 - this is somethign I should look into switching to, anyway
 
SimSim (app on GitHub) to locate file in Xcode simulator

Base - App on Mac AppStore for viewing SQL dbs

Look up mapping on optionals

[Core Data Debugging in Xcode using launch arguments](https://www.avanderlee.com/debugging/core-data-debugging-xcode/)

[Realm](https://realm.io) - an alternative to Core Data
