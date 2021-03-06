# Idiomatic Go Tricks

## Line of sight
- as you scan down the first indentation you can figure out what is happening in the function
- when you scan down the second indentation you see error handling
![](../pictures/Line-of-sight.png)

### Tips
- make "happy" return statement last
- instead of writing else consider flipping the logic

  ``` go
  if something.Ok() {
    return true, nil
  } else
    return false, errors.New("something")
  }
  ```

   vs

  ``` go
  if !something.Ok() {
    return false, errors.New("something")
  }
  return true, nil
  ```


## Single method interfaces
 - easy to use
 - easy to implement
	 - more likely to use
 - simpler = more powerful and useful

## Function types alternative for signal method interface  
![](../pictures/function types alternative for signal method interface.png)   

## Printing to log blocks
- easier to see logs you care about

``` go
func something() {
   log.Println("---------")
   defer log.Println("--------")
}
```

## Return teardown function
- return a teardown function from setup function
- clean-up code is encapsulated
- caller doesnt need to worry about cleaning up
- if setup changes teardown code is with it

![](../pictures/teardown_1.png)
![](../pictures/teardown_2.png)
![](../pictures/teardown_3.png)

## Discovering interfaces
``` go
type Sizer interface {
  Size() int64
}
```
- can add a new type that is many of an interface `type Sizers []Sizer`
	- now the slice can implement the sizer interface...can treat many objects as one
- can write an ad-hoc size calculator that makes use of the same methods:

	``` go
	type SizeFunc func() int 64
	func (s SizeFun) Size() int64 {
	   return s()
	}
	```
- can just be the type itself
	``` go
	type Size int64
	func (s Size) Size() int64 {
	   return int64(s)
	}
	```

## Optional features
- function that calls options functions if that method exists. `obj, ok := v.(Valid)`
![](../pictures/optional_features.png)

## Simple mocks
- implement the interface but pass execution directly to the function fields
- only have to define functions that you need
![](../pictures/simple_mock_1.png)
![](../pictures/simple_mock_2.png)


## Mocking other people's structs
- sometimes a library provides a struct but no interface but we need to mock it in test code
- make your own interface which the struct already implements
``` go
package them
type Messenger struct{}
func (m *Messenger) Send(){}
```

``` go
type Messenger interface {
   Send(){}
}
```

## Retrying
![](../pictures/retrying.png)
- dont use library, just copy it
- usage with delay
![](../pictures/retry_delay.png)

## Empty struct implementations
![](../pictures/empty_struct.png)

## Semaphores
- limit number of go routines
- ![](../pictures/semaphores.png)

## Don't be clever
- example:
``` go
func something() {
    defer StartTimer("something")()
}
```
should be

``` go
func something() {
    stop := StartTimer("something")
    defer stop()    
```

## General Tips
- read the standard library
- write obvious code not clever
- dont surprise your users
- seek simplicity
- learn from others

[source](https://www.youtube.com/watch?v=yeetIgNeIkc&t=328s)
