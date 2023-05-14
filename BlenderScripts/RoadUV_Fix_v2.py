import bpy
import math

ob = bpy.context.active_object
print(ob.name)
# Loops per face
for face in ob.data.polygons:
    boolReset = False
    intMoveX = 0
    intMoveY = 0
    for vert_idx, loop_idx in zip(face.vertices, face.loop_indices):
        uv_coords = ob.data.uv_layers.active.data[loop_idx].uv
        print("face idx: %i, vert idx: %i, uvs: %f, %f" % (face.index, vert_idx, uv_coords.x, uv_coords.y))
        if uv_coords.x>7:
            boolReset=True
            if math.floor(uv_coords.x)>intMoveX:
                intMoveX=math.floor(uv_coords.x)
        if uv_coords.x<-7:
            boolReset=True
            if math.floor(uv_coords.x)<intMoveX:
                intMoveX=math.floor(uv_coords.x)
                
        if uv_coords.y>7:
            boolReset=True
            if math.floor(uv_coords.y)>intMoveY:
                intMoveY=math.floor(uv_coords.y)
        if uv_coords.y<-7:
            boolReset=True
            if math.floor(uv_coords.y)<intMoveY:
                intMoveY=math.floor(uv_coords.y)        
    if boolReset:
        for vert_idx, loop_idx in zip(face.vertices, face.loop_indices):
            uv_coords = ob.data.uv_layers.active.data[loop_idx].uv
        
            ob.data.uv_layers.active.data[loop_idx].uv = (uv_coords.x -intMoveX,uv_coords.y -intMoveY)