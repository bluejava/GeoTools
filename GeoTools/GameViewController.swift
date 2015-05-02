//
//  GameViewController.swift
//  GeoTools
//
//  Created by Glenn Crownover on 4/30/15.
//  Copyright (c) 2015 bluejava. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController
{
	@IBOutlet weak var gameView: GameView!
	
	override func awakeFromNib()
	{
		/* First, some boilerplate SceneKit setup - lights, camera, (action comes later)  */

		// create a new scene
		let scene = SCNScene()
		
		// create and add a camera to the scene
		let cameraNode = SCNNode()
		cameraNode.camera = SCNCamera()
		scene.rootNode.addChildNode(cameraNode)
		
		// place the camera
		cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
		
		// create and add a light to the scene
		let lightNode = SCNNode()
		lightNode.light = SCNLight()
		lightNode.light!.type = SCNLightTypeOmni
		lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
		scene.rootNode.addChildNode(lightNode)
		
		// create and add an ambient light to the scene
		let ambientLightNode = SCNNode()
		ambientLightNode.light = SCNLight()
		ambientLightNode.light!.type = SCNLightTypeAmbient
		ambientLightNode.light!.color = NSColor.darkGrayColor()
		scene.rootNode.addChildNode(ambientLightNode)
		
		/*
			Here are the actual custom geometry test functions
		*/

		textureTileExample(scene.rootNode)			// A parallelogram with stretched texture
		textureTileExampleNonPar(scene.rootNode)	// A non-parallel quadrilateral shape with tiled texture
		textureTileExample3d(scene.rootNode)		// A 3d custom shape with tiled texture

		
		/*  Now, some more boilerplate…  */
		
		// set the scene to the view
		self.gameView!.scene = scene
		
		// allows the user to manipulate the camera
		self.gameView!.allowsCameraControl = true
		
		// show statistics such as fps and timing information
		self.gameView!.showsStatistics = true
		
		// configure the view
		self.gameView!.backgroundColor = NSColor.whiteColor()
	}
	
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
	
	// This function creates a quadrilateral shape with non-parallel sides. Note how the
	// texture originates at v2 and tiles to the right, up and to the left seamlessly.
	func textureTileExample(pnode: SCNNode)
	{
		// First, we create the 4 vertices for our custom geometry - note, they share a plane, but are otherwise irregular
		var v0 = SCNVector3(x: 6, y: 6.0, z: 6)
		var v1 = SCNVector3(x: 1, y: 4, z: 1)
		var v2 = SCNVector3(x: 0, y: 0, z: 0)
		var v3 = SCNVector3(x: 5, y: 2, z: 5)

		// Now we create the GeometryBuilder - which allows us to add quads  to make up a custom shape
		var geobuild = GeometryBuilder(uvMode: GeometryBuilder.UVModeType.StretchToFitXY)
		
		geobuild.addQuad(Quad(v0: v0,v1: v1,v2: v2,v3: v3)) // only the one quad for us today, thanks!
		var geo = geobuild.getGeometry()					// And here we get an SCNGeometry instance from our new shape
		
		// Lets setup the diffuse, normal and specular maps - located in a subdirectory
		geo.materials = [ SCNUtils.getMat("diffuse.jpg", normalFilename: "normal.jpg", specularFilename: "specular.jpg", directory: "textures/brickTexture") ]

		// Now we simply create the node, position it, and add to our parent!
		var node = SCNNode(geometry: geo)
		node.position = SCNVector3(x: 5, y: 2, z: 0)
		
		pnode.addChildNode(node)
	}

	// This function creates a quadrilateral shape with parallel sides to demonstrate
	// a stretchedToFit texture mapping. Of course, since it is non-square, the texture is
	// skewed.
	func textureTileExampleNonPar(pnode: SCNNode)
	{
		var v0 = SCNVector3(x: 6, y: 6.0, z: 6)
		var v1 = SCNVector3(x: 1, y: 4, z: 1)
		var v2 = SCNVector3(x: 2, y: 0, z: 2)
		var v3 = SCNVector3(x: 5, y: -2, z: 5)
		
		var geobuild = GeometryBuilder(uvMode: GeometryBuilder.UVModeType.StretchToFitXY)
		geobuild.addQuad(Quad(v0: v0,v1: v1,v2: v2,v3: v3)) // simple
		var geo = geobuild.getGeometry()
		
		geo.materials = [ SCNUtils.getMat("diffuse.jpg", normalFilename: "normal.jpg", specularFilename: "specular.jpg", directory: "textures/brickTexture") ]
		
		var node = SCNNode(geometry: geo)
		node.position = SCNVector3(x: 5, y: -6, z: 0)
		
		pnode.addChildNode(node)
	}
	
	
	// And finally, here is a full 3d object with six sides.  We only create the 8 vertices of the shape once, 
	// but they are replicated for each quad and then for each face as they have their own normals, texture coordinates, etc.
	// But it sure makes our job easy at this point - just enter your vertices, build your quads and generate the shape!
	func textureTileExample3d(pnode: SCNNode)
	{
		var f0 = SCNVector3(x: 6, y: 6.0, z: 2)
		var f1 = SCNVector3(x: 1, y: 4, z: 2)
		var f2 = SCNVector3(x: 2, y: 0, z: 2)
		var f3 = SCNVector3(x: 5, y: -2, z: 2)
		
		var b0 = SCNVector3(x: 6, y: 6.0, z: 0)
		var b1 = SCNVector3(x: 1, y: 4, z: 0)
		var b2 = SCNVector3(x: 2, y: 0, z: 0)
		var b3 = SCNVector3(x: 5, y: -2, z: 0)

		// Note: This uvMode will consider 1 by 1 coordinate units to coorespond with one full texture.
		// This works great for drawing large irregularly shaped objects made with tile-able textures.
		// The textures tile across each face without stretching or skewing regardless of size.
		var geobuild = GeometryBuilder(uvMode: .SizeToWorldUnitsXY)
		geobuild.addQuad(Quad(v0: f0,v1: f1,v2: f2,v3: f3)) // front
		geobuild.addQuad(Quad(v0: b1,v1: b0,v2: b3,v3: b2)) // back
		geobuild.addQuad(Quad(v0: b0,v1: b1,v2: f1,v3: f0)) // top
		geobuild.addQuad(Quad(v0: f1,v1: b1,v2: b2,v3: f2)) // left
		geobuild.addQuad(Quad(v0: b0,v1: f0,v2: f3,v3: b3)) // right
		geobuild.addQuad(Quad(v0: f3,v1: f2,v2: b2,v3: b3)) // bottom
		
		var geo = geobuild.getGeometry()
		
		geo.materials = [ SCNUtils.getMat("diffuse.jpg", normalFilename: "normal.jpg", specularFilename: "specular.jpg", directory: "textures/brickTexture") ]
		
		var node = SCNNode(geometry: geo)
		node.position = SCNVector3(x: -5, y: 2, z: 0)
		
		pnode.addChildNode(node)
	}
}
	