# Streaming in Sinatra

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


Allows for data to be sent over the connection while still generated part of the response.

## Stream helper
``` ruby
get '/' do
  stream do |out|
    out << "It's gonna be legen -\n"
    sleep 0.5
    out << " (wait for it) \n"
    sleep 1
    out << "- dary!\n"
  end
end
```

**Note:**

- streaming behaviour for concurrent requests dependants high on the web server used. Puma seems to work well from my tests.
- some may not support it as all

Optional parameter `keep_open` can be used to not call close on the stream object. This allows for you to close the connection at any point. **Note:** only works with evented servers like Thin or Rainbows

``` ruby
# long polling

set :server, :thin
connections = []

get '/subscribe' do
  # register a client's interest in server events
  stream(:keep_open) do |out|
    connections << out
    # purge dead connections
    connections.reject!(&:closed?)
  end
end

post '/:message' do
  connections.each do |out|
    # notify client that a new message has arrived
    out << params['message'] << "\n"

    # indicate client to connect again
    out.close
  end

  # acknowledge
  "message received"
end
```

## IO stream

`IO.popen -> IO`  can be returned from the handler. 

When using a synchronous server (Unicorn):

``` ruby
get '/' do
    content_type :txt
    IO.popen("ls")
end
```

When using Thin, the following can be used:
``` ruby
get '/' do
  content_type :txt
  IO.popen('tail -f some.log') do |io|
    stream do |out|
      io.each { |s| out << s }
    end
  end
end
```


``` ruby
require 'sinatra/streaming'
class myApp < Sinatra::Base
  helpers Sinatra::Streaming
  get '/log' do
    stream do |out|
      out.puts "Hello World!", "How are you? arhs"
	    sleep 1
			out.puts "That was a good nap"
      out.write "Written #{out.pos} bytes so far!\n"
      out.putc(65) unless out.closed?
      out.flush
    end
  end
end
```

[sinatra](http://www.sinatrarb.com/intro#Streaming%20Responses)

[IO](https://ruby-doc.org/core-2.3.1/IO.html)

[IO stackoverflow](http://stackoverflow.com/questions/7684784/stream-console-output-through-http-with-ruby)