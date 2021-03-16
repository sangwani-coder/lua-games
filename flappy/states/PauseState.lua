--[[
    PauseState Class
    Author: Peter Zyambo
    elsonpzyambo@gmail.com

    The PauseState is the screen shown when game is paused It should
    display "Press P" to resume.
]]

PauseState = Class{__includes = BaseState}

function PauseState:update(dt)
        
end

function PauseState:render()
    -- simple UI code
    love.graphics.setFont(hugeFont)
    love.graphics.printf('Paused', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press p to resume', 0, 160, VIRTUAL_WIDTH, 'center')
end
