# 7 common mistakes in Go

## Not accepting interfaces

- State and behavior
	- types can express and behavior
	- state = data structure
	- behavior = methods
- Interfaces
	- permit extensibility
	- defined by methods
	- adherence is only satisfied by behavior
- ![](../pictures/7-common-mistakes-in-go-2015-14-638.jpg)
- ![](../pictures/7-common-mistakes-in-go-2015-15-638.jpg)

## Note using io.Reader and io.Writer

- simple and flexible interfaces for many operations around input and output
- provide access to a huge wealth of functionality
- keeps operations extensive
- ![](../pictures/7-common-mistakes-in-go-2015-18-638.jpg)
- ![](../pictures/7-common-mistakes-in-go-2015-22-638.jpg)
- ![](../pictures/7-common-mistakes-in-go-2015-23-638.jpg)

## Requiring broad interfaces
- interfaces are compossible
	- functions should **only accept** interfaces that require the **methods they need**
	- functions should not accept a broad interface when a narrow one would work
	- compose broad interfaces made from narrower ones

## Methods vs functions
- too many methods
- a lot of people from OO backgrounds overuse methods
- natural draw to define everything via structs and methods
- what is a function
	- operations performed on N inputs that result in N outputs
	- the same inputs will always result in the same outputs
	- functions should not depend on state
- what is a method
	- defines a behavior of a type
	- a function that operates against a value
	- should use state
	- logically connected
- functions can be used with interfaces
	- methods are bound to a specific type
	- functions can accept interfaces as input
- **methods should manipulate the struct**

## Pointer vs values
- its **not** a question of performance (generally), but one of shared access
- if you want to share the value with a function or method, then use a pointer
- if you dont want to share it, then use a value
- pointer receivers
	- if you want to share a value with its method use a pointer receiver
	- since methods commonly manage state, this is a the common usage
	- not safe for concurrent access
- value receivers
	- if you want the value copied
	- if the type is an empty struct just use values
	- sage for concurrent access

## Thinking of errors as strings
- error is an interface

``` go
type error interface {
	Error() string
}
```
- standard errors
	- errors.New("error here") is usually sufficient
	- exported error variables can be easily checked
- Example:
	- okay but not great:

``` go
func NewPage() {
return errors.New("some error")
}
```

   - better: export error value

``` go
var SomeError = errors.New("some error")
func NewPage() {
return SomeError
}
```

- custom errors
	- can provide context to guarantee consistent feedback
	- provide a type which can be different from the error value
	- can provide dynamic values (based on internal error state)


##TO be safe or not to be
- if you provide a library someone will use it concurrently
- data structures are not safe for concurrent access
- values arent safe, you need to create safe behavior around them
- making it safe
	- sync package provides behavior to make a value safe (atomix/mutex)
	- channels coordinate values across go routines by permitting one go routine to access at a time
- keeping it unsafe
	- safety comes at a cost
	- imposes behaviors on consumer
	- proper API allows consumers to add safety as needed
	- consumers can choose how to do it
