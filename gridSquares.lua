-- USER VARIABLES -------------------------------------------

    local xcount = 7
    local ycount = 1
    local zcount = 7

    local xinterval = 10
    local yinterval = 10
    local zinterval = 10

    local showGridThroughBlocks = false

-- INITIALIZATION -------------------------------------------
    -- Preprocessing
        xcount = xcount-1
        ycount = ycount-1
        zcount = zcount-1
        -- find smallest interval

        -- smallestInterval = 

    -- find grid position if grid centers at 0,0
        local xPreGrid = math.floor((getPlayer().pos[1])/xinterval)*xinterval
        local yPreGrid = math.floor((getPlayer().pos[2])/yinterval)*yinterval
        local zPreGrid = math.floor((getPlayer().pos[3])/zinterval)*zinterval  
    -- find how offset player is from current grid
        local xoffset = xPreGrid - math.floor((getPlayer().pos[1]))
        local yoffset = yPreGrid - math.floor((getPlayer().pos[2]))
        local zoffset = zPreGrid - math.floor((getPlayer().pos[3]))

    local colors = {
        blue = {
            -- red
                [1] = 0,
            -- green
                [2] = 0,
            -- blue
                [3] = 1,
            -- opacity
                [4] = 1     
        }
    }

    local color = colors.blue

-- FUNCTION DEFINITIONS -------------------------------------

    local function spawnBlockAt(x,y,z, color)
        local hb = hud3D.newBlock(x,y,z)
        hb.enableDraw()
        hb.overlay()
        hb.setColor(color)
        hb.xray(showGridThroughBlocks)
        hb.setWidth( 1 )
    end

    local function distanceTo(x,y,z)
        local xpos = getPlayer().pos[1]
        local ypos = getPlayer().pos[2]
        local zpos = getPlayer().pos[3]
        return ( ( (xpos-x-0.5)^2 + (xpos-x-0.5)^2 + (zpos-z-0.5)^2 )^(1/2) )
    end

    local function renderNewGrid()
    -- Calc current grid position from coordinates
        xGrid = ( math.floor((getPlayer().pos[1])/xinterval)*xinterval ) - xoffset -- find x-coord of which grid player is currently in
        yGrid = ( math.floor((getPlayer().pos[2])/yinterval)*yinterval ) - yoffset -- find y-coord of which grid player is currently in
        zGrid = ( math.floor((getPlayer().pos[3])/zinterval)*zinterval ) - zoffset -- find z-coord of which grid player is currently in
    -- Render new grid
        log("xGrid "..xGrid)
        log("yGrid "..yGrid)
        log("zGrid "..zGrid)
        log("Distance to Grid: "distanceTo(xGrid,zGrid) )
        -- if (distanceTo(xGrid, yGrid, zGrid) > smallestInterval) then
        hud3D.clearAll()
        for i=0,xcount,1 do
            xtarg = (xGrid + i*xinterval)-0.5*xcount*xinterval
            for j=0,zcount,1 do  
                ztarg = (zGrid+j*zinterval)-0.5*zcount*zinterval
                for l=0,ycount,1 do
                    ytarg = (yGrid+l*yinterval)-0.5*ycount*yinterval
                    spawnBlockAt(xtarg,ytarg,ztarg, color)
                end
            end
        end

    end


-- MAIN -----------------------------------------------------

gridSquares = not gridSquares
if gridSquares == true then
    log("&7[&6Bots&7] &6* &aRENDERING...")

    while gridSquares do
        renderNewGrid()
        sleep(100)
    end

else
    log("&7[&6Bots&7] &6* &cRENDERING...")
    hud3D.clearAll() -- clear all rendered
end
