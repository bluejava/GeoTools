# GeoTools
A Swift Library to Aid in the Creation of Custom Geometry for SceneKit (OS X)

I am working on a project that requires custom mesh geometry using Swift and SceneKit. 
When I began looking into how to do this I didn't find any complete examples which also
went into texture mapping and/or dealt with some of the idiosyncrasies of doing it in Swift.
So once I figured it out and got things working I thought maybe others could benefit from this
as well.

My goal was to make it as simple as possible to build complex custom geometries with minimal code.
So I based it on Quads (though internally the mesh is built using Triangles) - as it is easier to
think of custom shapes as built up from quads.  

Building custom geometry entails creating a GeometryBuilder instance - adding quads to it to form your
shape, then calling getGeometry() on it to obtain your geometry.

A Quad is made up of four vertices on a plane which make up a quadrilateral shape.  Think of vertices as labeled v0 through v3 - starting with v0 
at the upper right corner - v1 at upper left - v2 at bottom left - and v3 at lower right.

An example of building custom geometry:
```Swift
  // First, define the four vertices of a Quad
	var v0 = SCNVector3(x: 6, y: 6.0, z: 6)
	var v1 = SCNVector3(x: 1, y: 4, z: 1)
	var v2 = SCNVector3(x: 2, y: 0, z: 2)
	var v3 = SCNVector3(x: 5, y: -2, z: 5)
		
	// Instantiate a GeometryBuilder and add a Quad
	var geobuild = GeometryBuilder()
	geobuild.addQuad(Quad(v0: v0,v1: v1,v2: v2,v3: v3))
	
	// And here is our new Geometry
	var geo = geobuild.getGeometry()

  // Now we can simply create a node using that geometry		
	var node = SCNNode(geometry: geo)
```

That's it - the above code will create a node with the non-square quadrilateral shaped plane
visible from one side only.  Of course you can add materials and textures to the geometry just
like any other.

## Vertice definition
The order of defining your vertices is important. The order determines the "normal" of the face which
dictates which side of the face is visible.  My code assumes a counter-clockwise order of vertices

##### From code comments:
```Swift
  // Always keep in mind the orientation of the verticies when looking at the face from the "front"
  // With single-sided faces, we only see from the front side - so this is important.
  //  v1 --------------v0
  //  |             __/ |
  //  | face     __/    |
  //  | 1     __/       |
  //  |    __/     face |
  //  | __/           2 |
  //  v2 ------------- v3
  // Two triangular faces are created from the 4 vertices - think of drawing the letter C when considering the order
  // to enter your vertices - top right, then top left, then bottom left, then bottom right - But of course, this is
  // relative only to your field of view - not the global coordinate system - "bottom" for your shape may be "up" in 
  // the world view!

