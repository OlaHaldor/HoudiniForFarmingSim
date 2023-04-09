# HoudiniForFarmingSim
A kit of tools to ease the process of creating maps for Farming Simulator 22 with Houdini, Blender and Substance Designer

<details>
    <summary>Read more</summary>
    
### What's the purpose of the kit?
The kit is tailor made for use with Farming Simulator 22 and Giants Editor, and make the process involved a lot faster, less boring, and give you plenty of time for the fun stuff of map making.
The kit will contain a Houdini Digital Asset (HDA) with an optimized interface with a focus on making the process as easy as possible with little or no interaction with the nodes that are used to create the tool.

The current version contains the field dimension tool. A future version of the kit will add the Road Tool and other scripts.


### The Field Dimension Tool
- HDA specific for the creaton of Field Dimensions, to be used with *Modelleicher*'s script.
- You can load a PNG with masks for the fields, or create curves directly in Houdini.
- A Substance Designer file to get you started with converting field dimension masks to Dirt texture on your map.

[Get the Blender addon by NMC T-Bone](https://github.com/NMC-TBone/Addon---import_field_shapes) to make the process even more streamlined.
Link to modelleicher's script coming as soon as it is published!

### The Road Tool
- You can load an external curve from OBJ, FBX etc. or create your own directly in Houdini.
- It will create a road mesh which will lay flush with the terrain.
- The surrounding terrain will flatten and have a smooth transition, to make it look very natural.

### Future development
I'm looking into finalizing the road tool. There is still a few moving parts I'd like to set in stone.
For a Houdini newbie like me, it's still a bit complex to iterate while maintaining loads of flexibility.
The road tool will come soon enough. :)

### Backstory
I began using Houdini for flow maps, as seen in [my map Rennebu](https://farming-simulator.com/mod.php?lang=en&country=us&mod_id=250208&title=fs2022).

Then I wanted to explore whether I could create roads which also could adjust the surrounding terrain. This proved successful, and the result can be seen in the current version of Rennebu.
Some forestry/dirt roads have been created with early versions of the tool, flattening the surrounding terrain, creating a UV unwrapped road mesh, completed with vertex colors and separate low poly collision mesh.

The idea for the Field Dimension tool sprung to life after I saw the script from *Modelleicher*, as I found the process quite interesting, especially as it seems to produce very clean field dimensions compared to other options.
With this I also explored methods I could expand on the feature set. With the tool you can not only prepare objects for the field dimension script, but also flatten or smooth the areas where the fields are located, and make them blend better into the surrounding terrain. Please see the videos below for reference.

### Videos
[Playlist on YouTube](https://youtu.be/ITUCDfB2fvc) of the different iterations of the tools in use.</details>

<details>
    <summary>Tutorials</summary>

### Field Dimension Tool in Houdini
<details>
    <summary>Read the tutorial</summary>

The UI of the Houdini tool is quite straight forward, and is operated in the order it's laid out.
#### Prerequisite 

1. Install the HDA. 
    - File -> Import -> Houdini Digital Asset.
    - Browse to the downloaded HDA file.
    - Click Install and Create if it's the first time.
    - Next time you want to create field definitions in a new map, you can simply right click in the node graph and select **Farming Simulator -> Field Dimensions**

2. Have a heightmap ready. Optionally also a mask for field definitions.

4. Load a heightmap and set the size and height scale to match your map in GE.
5. Either load an external mask or create curves in Houdini.
    
    **Note about external masks**
    - The way Houdini works is it will create data from the external file, going bottom right to top left. This means that Field 1 will be bottom right to top left.
    - To counter this, rotate the mask image 180 degrees. This will trick the system, and your fields will actually start the count from top left to bottom right.
    - Make sure you select the correct setting in the tool as well.

6. Adjust the settings for field shape and terrain smoothing as you please.
7. Export! 
    - You can export the updated heightmap with smooth fields.
    - You can export field definition objects as FBX.
    - You can export a mask of the field definitions to edit texture weight files (for example in Substance Designer, for a fully automated process).
</details>

### METools Loop V2
<details>
    <summary>Read the tutorial</summary>

#### Prerequisite 
1. Add the script into your scripts folder.
2. In your map you should already have a *fields* transform group with the required attributes.
    - script callback: onCreate = FieldUtil.onCreate

3. You should already have a field dimension transform group with the required attributes. This will from now on be the template for which all the field dimensions will copy the values of. For the purpose of this tutorial I will name it *field_template*
    - integer: fieldAngle
    - integer: fieldDimensionIndex
    - boolean: fieldGrassMission
    - integer: nameIndicatorIndex

![Fields](https://github.com/OlaHaldor/HoudiniForFarmingSim/blob/main/TutorialImages/field.jpg?raw=true)

The default values are
    - fieldAngle: 90
    - fieldDimensionIndex: 0
    - fieldGrassMission: (unticked)
    - nameIndicatorIndex: 1

![Template](https://github.com/OlaHaldor/HoudiniForFarmingSim/blob/main/TutorialImages/fieldtemplate.jpg?raw=true)

4. Create a transform group where you put all your transform groups containing the field dimension temp objects from Houdini/Blender. For the purpose of this example I will name it *Temp Field Dimension Objects*
5. This is the procedure to generate all field dimensions in one click.
    1. Select the *Temp Field Dimension Objects* transform group.
    2. Select the *fields* transform group.
    3. Select the *field_template* transform group.
    4. run the script.
6. Select the *fields* transform group and **Toggle Render Field Areas**, this is a default script in GE. You should now be able to see the field definitions overlay on your map.

Here's a sample hierarchy. Notice how the transform groups are placed in order of operation to make it easier to remember in which order to select each group.

![Sample](https://github.com/OlaHaldor/HoudiniForFarmingSim/blob/main/TutorialImages/setup.jpg?raw=true)

**Note:** It does not matter how man field definition transform groups you have. You can add more fields at any time. 
</details>