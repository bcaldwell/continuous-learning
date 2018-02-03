# Dockerfiles

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}


- about a year ago docker froze the syntax of docker files
	- docker files are "stable"
- 1.12 add some new commands
	- healthcheck
	- shell

## Why dockefiles are great
- simplicity
- multi-platform support
- linting
- editor support

## Why dockerfile are problematic
- complexity
	- multi-line `RUN` commands
- dockerfile proliferation
- only two approaches to reuse
	- inheritance `FROM`
	- copy and paste
- is not the source of truth for you image

> "The Dockerfile is a tool for creating images, but it is not the only weapon in your arsenal" - Nathan Leclair

### The big questions
- If we dockerize all of our applications how many Dockerfiles is that?
- If we build a complex hierarchy of Dockerfiles, how quickly can we trace/rebuild a specific image
- As best-pactices develops how can we refactor our Dockerfiles with confidence?
- Are Dockerfiles best managed centrally or on a team-by-team basis?

## Community solutions
- generate dockerfiles
	- build dockerfiles with OCAML
	- gradle-docker
	- dockerfile-javascript
	- shutIt (python)
	- **PROS**
		- powerful abstractions
		- mature language tooling
	- **CONS**
		- need to compile down to Dockerfile
		- Everyone has their favorite language
- without Dockerfile
	- Docker Image Specification is published
	- Open container initiative is another image specification
	- Example:
		- Packer: docker builder
		- Source-to-Image (s2i)
		- Nix
		- Habitat
	- **PROS**
		- Powerful
	- **CONS**
		- OCI image spec not final
		- Higher barrier to entry than Dockerfile
		- Limited support for things like labels
- Expand on Dockerfiles
	- Rocker
		- add crucial features while keeping the original design
	- Dockramp
	- Dockerfile pre-processors
		- ex: dockerfilepp
		- domain-specific extensions
	- **PROS**
		- simple and familiar
		- great proving ground for upstream
	- **CONS**
		- still line-oriented
		- limited tooling available (yet)

## Future
- formal specification for dockerfile
- RUN, FROM, COPY as first class API primitives so we can build better high level tools
- opinionated workflow tooling around image build
- shared libraries and support for pre-processors
- better tools for managing dockerfiles
