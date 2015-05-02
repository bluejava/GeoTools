//
//  Quad.swift
//  GeoTools
//
//  Created by Glenn Crownover on 4/28/15.
//  Copyright (c) 2015 bluejava. All rights reserved.
//

// A four vertice quad - must either be planar, or if non-planar, texture maps may not work
// as expected - and shared edge will be v0->v2
//
//  v1 --------v0
//  |        _/ |
//  |      _/   |
//  |    _/     |
//  |  _/       |
//  | /         |
//  v2 ------- v3

import SceneKit

class Quad
{
	let v0: SCNVector3
	let v1: SCNVector3
	let v2: SCNVector3
	let v3: SCNVector3
	
	init(v0: SCNVector3, v1: SCNVector3, v2: SCNVector3, v3: SCNVector3)
	{
		self.v0 = v0
		self.v1 = v1
		self.v2 = v2
		self.v3 = v3
	}
}
