-- Author: OlaHaldor
-- Name: Fence Corner Coordinates
-- Description:
-- Icon:
-- Hide: no

-- INSTRUCTIONS:
-- Create a spline. Make sure it's LINEAR type.
-- Make sure you select the spline, and not a spline point
-- Run the script
-- Copy-paste the coordinates from the console log.
-- Tip: pick your fence type here: https://olahaldor.net/fenceselection/

---Wrapper for print(string.format())
---@param formatText any
---@param ... unknown
_G.printf = function(formatText, ...)
    print(string.format(formatText, ...))
end

GHLib = {}

---Check if node is of type spline
---@param nodeID integer
---@return boolean isSpline Returns true if the node has the class id spline
function GHLib:IsSpline(nodeID)
    return getHasClassId(nodeID, ClassIds.SPLINE) or (getHasClassId(nodeID, ClassIds.SHAPE) and getSplineNumOfCV(nodeID) > 0)
end
-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

local selectedNodeID = getSelection(0)

if selectedNodeID == nil or selectedNodeID == 0 then
    print("ERROR: You must select a spline first, no node was selected!")
    return
elseif not GHLib:IsSpline(selectedNodeID) then
    printf("ERROR: The selected node [#%d] must be a spline, please select a spline node before you run the script again.", selectedNodeID)
    return
end

-- Function to print the X and Z coordinates of spline nodes
local function printSplineCoordinates()
    local numberOfCVs = getSplineNumOfCV(selectedNodeID)

    if numberOfCVs == 0 then
        print("The selected spline has no control points.")
        return
    end

    local xmlData = "<fence>\n\t<segments>\n"

    for i = 1, numberOfCVs - 2, 1 do -- Adjusted the upper bound to numberOfCVs - 2
        local x, _, z = getSplineCV(selectedNodeID, i - 1)
        local nextIndex = i % (numberOfCVs - 1) + 1
        local nextX, _, nextZ = getSplineCV(selectedNodeID, nextIndex - 1)

        local isFirst = i == 1
        local isFirstAttribute = isFirst and "" or " first=\"false\""

        xmlData = xmlData .. string.format("\t\t<segment start=\"%f %f\" end=\"%f %f\"%s/>\n", x, z, nextX, nextZ, isFirstAttribute)
    end

    -- Manually add the last segment
    local x, _, z = getSplineCV(selectedNodeID, numberOfCVs - 2)
    local nextX, _, nextZ = getSplineCV(selectedNodeID, numberOfCVs - 1)
    xmlData = xmlData .. string.format("\t\t<segment start=\"%f %f\" end=\"%f %f\" first=\"false\"/>\n", x, z, nextX, nextZ)

    xmlData = xmlData .. "\t</segments>\n</fence>"

    print(xmlData)
end

printSplineCoordinates()

