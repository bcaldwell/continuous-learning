# OSI Model (network layers)


- main idea of networks is communication between systems
- OSI: open system interconnection
- logical model on how network systems are supposed to communicate with each other

![7 network layers](../pictures/network-layers.png)

- dotted lines represent communication protocols

## Application
- layer at which user communicate with the systems
- Example for a website would be firefox
- *protocol:* ATP 
- - **Potential Problems:** application is corrupted

## Presentation
- layer is concerned with the format of data exchanged between the end systems
- layer that the OS is on
- *protocol:* PLP 
- **Potential Problems:** device drivers, OS isnt allowing the user onto the internet 


## Session
- allows users on different machines to create sessions between them
- Example website has to create a session with the webserver you are trying to get data from
- connection between to two computers
- *protocol:* SLP 
- **Potential Problems:** webserver settings could be setup wrong


## Transport
- end to end communication of messages
- How much information should be sent at one time
- has to do with windowing: process where computers send information back and forth

## Network
- routing of packets to correct destination
- IP address is at the this layer
	- subnet masks, default gates, ect.
-  *protocol:* TCP

## Data Link
- transmission of error free data in the form of Frames
- where switching occurs (where the physical switching are)
- MAC addresses are part of this layer
- **Potential Problems:** Switch isnt working, network is slow

## Physical
- transmission of raw buts over the communication link
- the wiring
- **Potential Problems:** not plugged int

[source](https://www.youtube.com/watch?v=HEEnLZV2wGI)