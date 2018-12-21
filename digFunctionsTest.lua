os.loadAPI("digAPI.lua")

function checkBlocks(blocks,rows)
    if turtle.getItemCount(r) <= blocks*rows then
        for r = 2,16 do
            turtle.select(r + 1)
        end
    end
end
        

function fillRow(blocks)
    turtle.select(2)
    local k = 1
    while k <= blocks do
        turtle.back()
        turtle.place()
        k = k + 1
    end
end

function fillTurnRight(blocks)
    turtle.turnLeft()
    fillRow(1)
    turtle.turnLeft()
    fillRow(blocks)
    
end

function fillTurnLeft(blocks)
    turtle.turnRight()
    fillRow(1)
    turtle.turnRight()
    fillRow(blocks)
end

function fillLayer(blocks,rows)
    fillRow(blocks)
    local l = 1
    while l <= rows do
        checkBlocks(blocks,rows)
        fillTurnLeft(blocks)
        fillTurnRight(blocks)
        l = l + 2
    end
    turtle.up()
    turtle.placeDown()
end        

function fillSpace(blocks,rows,layers)
    local la = 1
    while la <= layers do
        fillLayer(blocks,rows)
        turtle.turnLeft()
        la = la + 1
    end
end
function quarryNoClimb(blocks,rows,layers)
    digAPI.digCheckFirst()
    local h = 1
    while h <= layers do
        digAPI.digLayerStart()
        digAPI.digLayer(blocks,rows)
        digAPI.endLayerNoClimb(rows)
        h = h + 1
    end
end

digAPI.fuelUp()
checkBlocks(5,8)
fillLayer(5,8)
print("Layer Filled!")
