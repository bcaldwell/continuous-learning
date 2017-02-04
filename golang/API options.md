# API Options in Go

## Function parameters
``` go
type Server struct {
}

func NewServer(addr string) (*Server, error)
```

#### Pros
- simple API to start with
- easy to use

#### Cons
- gets confusing as the API grows (more features are added)
	- Becomes:
	```
	func NewServer(addr string, clientTimeout time.Duration, maxconns, maxconcurrent isnt cert *tls.Cert)
	```
	- Easy to break code
	- cumbersome and brittle
	- API not easily discoverable
	- unclear which oarameters are optional
	- what is the default value??? 0 vs inf, ect.

## Many functions
```
NewServer(addr string) (*Server, error)

NewTLSServer(addr string, cert *tls.Cert) (*Server,error)

NewServerWithTimeout(addr string, timeout time.Duration)((*Server,error)

NewTLSServerWithTimeout(addr string, timeout time.Duration, cert *tls.Cert)(*Server,error)
```

#### Cons
- very hard to think of all possibilities

## Configuration struct
```
type Config struct {
  Timeout time.Duration
  Cert *tls.Cert
  Port int
}
func NewServer (addr string, config Config)(*Server,error)
```

#### Pros
- configuration struct can grow over time as new options are added which the public api remains constant
- can lead to better documentation
	- massive comment block required to desribe NewServer become nicely documented struct
- has zero value to represent default value

####Cons
- cant tell difference between 0 value and wanting that value....cant pass in 0 for an int
- user is required to pass in a value for the second parameter..an empty config...`Config{}`

## nil configuration struct
```
func NewServer(addr string, config *Config)(*Server,error)

NewServer("localhost", nil)
conf := Config{Port: 9000}
NewServer("localhost", &conf)
```
#### cons
- same as configuration struct
- difference between nil and &config{}
- shared refference to a config struct
	- how happens when it changes

## Optional configuration struct
```
func NewServer(add string, conf ...Config) (*Server,error)

NewServer("localhost")
conf := Config{Port: 9000}
NewServer("localhost", &conf)
```

#### Pros
- default dehaviour is as concise as possible
- NewServer doesnt accept a pointer

#### Cons
- possible to pass in multiple config structs...then what happens?

## Functional options
### Best
```
func NewServer(addr string, options ...func(*Server)) (*Server, error)

NewServer("localhost") //default
timeout := func(srv *Server) {
  srv.timeout = 60 * time.Second)
}

port := func(p int) func(*Server) {
  return func(srv *Server) {
     srv.Port = p
  }
}

tls := func(srv *Server) {
  config := loadTLSConfig()
  srv.listener = tls.NewListener(srv.listener, &config)
}

// New server with options
NewServer("localhost", timeout, tls, port(80))
```

#### Pros
- clear
- all options are optional
- compact default case

**Useful function**

```
// Option sets the options specified.
func (f *Foo) Option(opts ...option) {
    for _, opt := range opts {
        opt(f)
    }
}
```

```
// SetOption takes one or more option function and applies them in order to Term.
func (f *Foo) SetOption(options ...func(*Foo) error) error {
	for _, opt := range options {
		if err := opt(f); err != nil {
			return err
		}
	}
	return nil
}
```

[Functional options for friendly APIs](https://dave.cheney.net/2014/10/17/functional-options-for-friendly-apis)
[Rob Pike self-referential functions](https://commandcenter.blogspot.ca/2014/01/self-referential-functions-and-design.html)