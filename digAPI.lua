--Digging commands. Everywhere you see (<value>) 
--you have to put a custom number in the line
--in order for it to execute. You can also group them.
--Otherwise, I don't think it'll do anything.
--This is made for the mining turtle. 
--DO NOT USE THE DIGGING TURTLE.
--IT WILL MAKE PATH BLOCKS!! :(

function startDig()
--Orients the turtle on the layer below it 
--so it can dig the next row.
    turtle.turnRight()
    turtle.forward()
    turtle.turnLeft()
    turtle.digDown()
    turtle.down()
end

function dig(blocks)
--Makes the turtle dig (blocks) blocks 
--in a straight line.
    local a = 1
    while a <= blocks do
        turtle.dig()
        turtle.forward()
        a = a + 1
    end
end

function backToStartDig(blocks)
--Returns the turtle to the start 
--of the line so it can be reoriented.
    turtle.up()
    local b = 1
    while b <= blocks do
        turtle.back()
        b = b + 1
    end
end

function digCompleteA(rows)
--This assumes your turtle dug 
--from left to right, and returns 
--it to (rows) row.
--If you want it to go back to 
--the first you need to count how 
--many rows you've done
--and use that number.
    turtle.up()
    turtle.turnLeft()
    local c = 1
    while c <= rows do
        turtle.forward()
        c = c + 1
    end
end

function digCompleteB(blocks)
--This can send the turtle back 
--to the beginning, (blocks) blocks away.
--You have to count how many blocks it dug 
--per row and send it back that many.
--You could also set everything to use the
--same (num) like in the quarry function.
--This also finishes turning the turtle 360 
--so it can execute a new program.
    turtle.turnLeft()
    local d = 1
    while d <= blocks do
        turtle.forward()
        d = d + 1
    end
    turtle.turnLeft()
    turtle.turnLeft()
end

function digCompleteC(layers)
--This returns the turtle up (layers) 
--layers if you used this to make a quarry 
--and want him back.
    local e = 1
    while e <= layers do
        turtle.up()
        e = e + 1
    end
end

function digLayerStart()
	turtle.digDown()
	turtle.down()
end

function digQuarry(blocks,rows,layers)
    digCheckFirst(layers)
    local ab = 1
    while ab <= layers do
        fuelUp()
        digLayer(blocks,rows)
        endLayer(rows)
        ab = ab + 1
    end
    digCompleteC(layers)
    clearInventory(2,15)
end

function fuelUp()
    turtle.select(1)
    if turtle.getFuelLevel() < 100 then
        turtle.refuel()
    end
end

function clearInventory(slotA,slotB)
--Assumes you placed a chest or other
--inventory to the turtle's left before
--starting, and attempts to dump items in.
--If no inventory, it'll dump on the ground.
    turtle.turnLeft()
    for i = slotA,slotB do
        turtle.select(i)
        turtle.drop()
    end
    turtle.turnRight()
    print("Inventory cleared!")
end

function digLayer(blocks,rows)
    local m = 1
    digLayerStart()
    while m <= rows do
        dig(blocks)
        backToStartDig(blocks)
        startDig()
        m = m + 1
    end
end

function endLayer(rows)
--Ends each layer by placing
--a ladder and reorienting
--for the next layer.
    turtle.turnRight()
    turtle.dig()
    turtle.select(16)
    turtle.place()
    turtle.turnLeft()
    digCompleteA(rows)
    turtle.turnRight()
    turtle.down()
end

function endLayerNoClimb(rows)
--Reorients to the next layer
--without placing a ladder.
    digCompleteA(rows)
    turtle.turnRight()
    turtle.down()
end

function digCheckFirst(layers)
--Tells you if you need coal and
--ladders. Will only pause turtle
--15 seconds if it doesn't have enough.
--Then it will resume.
--Assumes coal is in 1 and ladders in 16.
    if turtle.getItemCount(1) <= 15 then
        print("I need more fuel!")
        os.sleep(15)
    else
        print("Plenty of fuel!")
    end
    if turtle.getItemCount(16) <= layers then
        print("I need ".. layers .." ladders!")
        os.sleep(15)
    else
        print("I have enough ladders!")
    end
end

function digMineshaft(layers)
    digCheckFirst(layers)
    local f = 1
    while f <= layers do
        digLayerStart()
        endLayer(0)
        f = f + 1
    end
    digCompleteC(layers)
    clearInventory(2,15)
end
