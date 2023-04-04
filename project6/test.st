| area volume |
mySphere := Sphere new: 'mySphere' radius: 2.0.
area := mySphere getArea.
volume := mySphere getVolume.
area printNl. 
volume printNl.
myCyl := Cylinder new: 'cyl' radius: 2.0 height: 2.0.
myCyl getArea printNl.
myCyl getVolume printNl.

box := Box new: 'box' length: 2.0 width: 2.0 height: 2.0.
box getArea printNl.
box getVolume printNl.

torus := Torus new: 'torus' smallRadius: 2.0 bigRadius: 4.0.
torus getArea printNl.
torus getVolume printNl.
box getInfo printNl.
mySphere getInfo printNl.
myCyl getInfo printNl.
torus getInfo printNl.
