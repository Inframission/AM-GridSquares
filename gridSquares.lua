-- FUNCTION DEFINITIONS -------------------------------------

function spawnBlockAt(x,y,z, color)
        local hb = hud3D.newBlock(x,y,z)
        hb.enableDraw()
        hb.overlay()
        hb.setColor(color)
        -- hb.xray(true)
        hb.setWidth( 1 )
end

colors = {
    blue = {
        -- red
            [1] = 0,
        -- green
            [2] = 0,
        -- blue
            [3] = 1,
        -- opacity
            [4] = 1     
    },
    green = {
        -- red
            [1] = 0,
        -- green
            [2] = 1,
        -- blue
            [3] = 0,
        -- opacity
            [4] = 1     
    }

}

local y = math.floor(getPlayer().pos[2])

function renderNewGrid(x,z)
-- Calc current grid position from coordinates
    xGrid = ( math.floor((getPlayer().pos[1])/interval)*interval ) - xoffset -- find z-coord of which grid player is currently in
    yGrid = ( math.floor((getPlayer().pos[2])/interval)*interval ) - yoffset -- find z-coord of which grid player is currently in
    zGrid = ( math.floor((getPlayer().pos[3])/interval)*interval ) - zoffset -- find z-coord of which grid player is currently in

    -- log("xGrid: "..xGrid)
    -- log("zGrid: "..zGrid)

-- Render New Grid
    hud3D.clearAll()
    for i=0,8,1 do
        xtarg = (xGrid + i*interval)-0.5*8*interval
        for j=0,8,1 do  
            ztarg = (zGrid+j*interval)-0.5*8*interval
            for l=0,8,1 do
                ytarg = (yGrid+l*interval)-0.5*8*interval
                spawnBlockAt(xtarg,ytarg,ztarg, color)
            end
        end
    end

end

-- USER VARIABLES -------------------------------------------

interval = 23


-- INITIALIZATION -------------------------------------------

    color = colors.blue
    xPreGrid = math.floor((getPlayer().pos[1])/interval)*interval
    yPreGrid = math.floor((getPlayer().pos[2])/interval)*interval
    zPreGrid = math.floor((getPlayer().pos[3])/interval)*interval  -- find grid position if grid centers at 0,0
    xoffset = xPreGrid - math.floor((getPlayer().pos[1]))
    yoffset = yPreGrid - math.floor((getPlayer().pos[2]))
    zoffset = zPreGrid - math.floor((getPlayer().pos[3]))          -- find how offset player is from current grid

-- MAIN
rendering = not rendering
if rendering == true then
    log("&7[&6Bots&7] &6* &aRENDERING...")

    while rendering do
        renderNewGrid(xGrid,zGrid)
        sleep(3000)
    end

else
    log("&7[&6Bots&7] &6* &cRENDERING...")
    -- clear all rendered
        hud3D.clearAll()
end