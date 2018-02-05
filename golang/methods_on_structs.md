# Methods on structs

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


In golang we can as methods to structs to give them more functionality. For example given the struct:

``` go
type Person struct {
	name string
	age  int
}
```

we can define a method on it as such

``` go
func (p Person) greet() {
	return "Hello " + p.name
}
```

## Types of Methods

### Pointer methods
Defined like `func (t *Type)` using the `*` operator. For example:

``` go
func (p *Person) growup() {
	p.age = 80
}
```

When using pointer methods you **can modify** the struct inside of them. Can be thought as pass by reference in C. This give you read and write access to the struct.

### Value Methods
Defined like `func (t Type)`. For example:

``` go
func (p *Person) intro() {
	return "My name is " + p.name
}
```

When using pointer methods you **cant modify** the struct inside of them. Can be thought as pass by value in C. This give you only read access to the struct.

### Example

##### Code

``` go
package main

import "fmt"

type Person struct {
    name string
    age  int
}

func (p *Person) growup_pointer() {
    p.age = 100
}

func (p Person) growup_value() {
    p.age = 100
}

func main() {
    p := Person{"name", 10}
    fmt.Printf("%+v\n", p)
    p.growup_value()
    fmt.Printf("value: %+v\n", p)
    p.growup_pointer()
    fmt.Printf("pointer: %+v\n", p)
}
```

##### Output
``` go
{name:name age:10}
value: {name:name age:10}
pointer: {name:name age:100}
```


## Methods on anonymous fields

#### Anonymous fields
Anonymous fields are fields in a struct that have no variable names

##### Example
``` go
type Child struct {
	Person
}
```
Doing this allows child to access the member functions of Person. Composed field (ie field that belong to the anonymous field) can also be accessed by its type. Ex `c.Person.age` or `c.age`. Additionally we need to use the type name when initializing the values of child. Ex `Child{Person{"name", 10}}`. In the case of a name conflict for methods the outer struct is accessible by default. The inner struct can be reference by use the inner struct's type.

#### Anonymous methods
Methods can also be attached to structs with anonymous methods. Inside these methods the properties of the inner struct can be referenced.

##### Example
``` go
package main

import "fmt"
import "time"

type myTime struct {
    time.Time //anonymous field
}

func (t myTime) first5Chars() string {
    return t.String()[0:5]
}

func (t myTime) first5Chars_2() string {
    return t.Time.String()[0:5]
}

func main() {
    m := myTime{time.Now()}
    fmt.Println("Full time now:", m.String())
    fmt.Println("First 5 chars:", m.first5Chars())
    fmt.Println("First 5 chars:", m.first5Chars_2())
}
```

##### Output

``` go
Full time now: 2016-07-06 00:17:54.986496857 -0400 EDT
First 5 chars: 2016-
First 5 chars: 2016-
```

- **kind of like inheritance **


[source](http://golangtutorials.blogspot.ca/2011/06/methods-on-structs.html)
[source](https://golang.org/doc/faq#methods_on_values_or_pointers)
