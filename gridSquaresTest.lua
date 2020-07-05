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
xcount = 6
ycount = 0
zcount = 6

xinterval = 5
yinterval = 1
zinterval = 5

function renderNewGrid(x,z)
-- Calc current grid position from coordinates
    xGrid = ( math.floor((getPlayer().pos[1])/xinterval)*xinterval ) - xoffset -- find z-coord of which grid player is currently in
    yGrid = ( math.floor((getPlayer().pos[2])/yinterval)*yinterval ) - yoffset -- find z-coord of which grid player is currently in
    zGrid = ( math.floor((getPlayer().pos[3])/zinterval)*zinterval ) - zoffset -- find z-coord of which grid player is currently in
    -- log("xGrid:"..xGrid)
    -- log("yGrid:"..yGrid)
    -- log("zGrid:"..zGrid)
-- Cald distance from center of Grid render
    xdiff = math.abs( xGrid - math.floor((getPlayer().pos[1])) )
    ydiff = math.abs( yGrid - math.floor((getPlayer().pos[2])) )
    zdiff = math.abs( zGrid - math.floor((getPlayer().pos[3])) )
-- If out of center ... render new grid
    -- if(xdiff > xinterval or ydiff > yinterval or zdiff > zinterval)then
        hud3D.clearAll()
        for i=0,xcount,1 do
            xtarg = (xGrid + i*xinterval)-0.5*xcount*xinterval
            for j=0,zcount,1 do  
                ztarg = (zGrid+j*zinterval)-0.5*zcount*zinterval
                for l=0,ycount,1 do
                    ytarg = (yGrid+l*yinterval)-0.5*ycount*yinterval
                    -- log("yGrid:"..yGrid)
                    -- log("yinterval:"..yinterval)
                    -- log("ycount:"..ycount)
                    spawnBlockAt(xtarg,ytarg,ztarg, color)
                end
            end
        end

    end
-- end

-- USER VARIABLES -------------------------------------------

interval = 23
color = colors.blue



-- INITIALIZATION -------------------------------------------


xPreGrid = math.floor((getPlayer().pos[1])/xinterval)*xinterval
yPreGrid = math.floor((getPlayer().pos[2])/yinterval)*yinterval
zPreGrid = math.floor((getPlayer().pos[3])/zinterval)*zinterval  -- find grid position if grid centers at 0,0
xoffset = xPreGrid - math.floor((getPlayer().pos[1]))
yoffset = yPreGrid - math.floor((getPlayer().pos[2]))
zoffset = zPreGrid - math.floor((getPlayer().pos[3]))          -- find how offset player is from current grid

-- MAIN
rendering = not rendering
if rendering == true then
log("&7[&6Bots&7] &6* &aRENDERING...")

while rendering do
    renderNewGrid(xGrid,zGrid)
    sleep(100)
end

else
log("&7[&6Bots&7] &6* &cRENDERING...")
-- clear all rendered
    hud3D.clearAll()
end