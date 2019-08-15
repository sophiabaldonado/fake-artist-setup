lovr.keyboard = require 'lovr-keyboard'
local words = require 'words'

function lovr.load()
    numPlayers = 5
    totalDraws = (numPlayers * 2) + 1
    setup()
    
    fillHat(numPlayers, hat)
end

function lovr.keyreleased(key)
    if key == 'f5' then
        lovr.event.quit('restart')
    elseif key == 'r' and canReRoll() then
        print('rerooll')
        fillHat(numPlayers, hat)
    elseif key == 'enter' then
        if draw == totalDraws then
            setup()
            fillHat(numplayers, hat)
        else
            draw = draw + 1
        end
    end
end

function lovr.draw()
    lovr.graphics.print(hat[draw])
    if canReRoll() then
        lovr.graphics.print('too hard? press R', 0, -1, 0, .5)
    end
    if isFirstToDraw() then
        lovr.graphics.print('You draw first!', 0, 1, 0, .5)
    end
end

function setup()
    hat = {}
    draw = 1
    X = lovr.math.random(numPlayers) * 2
    firstToDraw = lovr.math.random(numPlayers) * 2
    word = 'opps'
end

function fillHat(numPlayers, hat)
    word = getWord()

    hat[1] = 'START!'
    for i = 2, totalDraws, 2 do
        hat[i] = word
        if i == X then
            hat[i] = 'X  :('
        end
        hat[i + 1] = i + 1 == totalDraws and 'END!' or 'NEXT PLAYER...'
    end
end

function getWord()
    local rand = lovr.math.random(#words)
    return words[rand]
end

function canReRoll()
    return draw == 2 and X ~= 2 or draw == 4 and X == 2
end

function isFirstToDraw()
    return draw == firstToDraw
end
