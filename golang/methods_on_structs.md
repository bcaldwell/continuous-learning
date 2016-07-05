# Methods on structs

In golang we can as methods to structs to give them more functionality. For example given the struct:

```
type Person struct {
	name string
	age  int
}
```

we can define a method on it as such

```
func (p Person) greet() {
	return "Hello " + p.name
}
```

## Types of Methods

### Pointer methods
Defined like `func (t *Type)` using the `*` operator. For example:

```
func (p *Person) growup() {
	p.age = 80
}
```

When using pointer methods you **can modify** the struct inside of them. Can be thought as pass by reference in C. This give you read and write access to the struct.

### Value Methods
Defined like `func (t Type)`. For example:

```
func (p *Person) intro() {
	return "My name is " + p.name
}
```

When using pointer methods you **cant modify** the struct inside of them. Can be thought as pass by value in C. This give you only read access to the struct.

### Example

##### Code

```
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
	p := &Person{"name", 10}
	fmt.Println(p)
	p.growup_value()
	fmt.Print("value: ")
	fmt.Println(p)
	p.growup_pointer()
	fmt.Print("pointer: ")
	fmt.Println(p)
}
```

##### Output
```
&{name 10}
value: &{name 10}
pointer: &{name 100}
```


## Methods on anonymous fields

#### Anonymous fields

[source](http://golangtutorials.blogspot.ca/2011/06/methods-on-structs.html)
[source](https://golang.org/doc/faq#methods_on_values_or_pointers)
