--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
local PRIZE_1 = love.graphics.newImage('tro1.png')
local PRIZE_2 = love.graphics.newImage('tro2.png')
local PRIZE_3 = love.graphics.newImage('tro3.png')

function ScoreState:enter(params)
    self.score = params.score
end

FLIGHT = -4

function ScoreState:init()
    -- load balloon image from disk and assign its width and height
    self.image = love.graphics.newImage('bal.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    -- position balloon in the bottom of the screen
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT
    -- Y velocity; gravity
    self.dy = 0
end

function ScoreState:update(dt)
    -- apply gravity to velocity
        self.dy = self.dy + FLIGHT * dt
       
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
      self.y = self.y + self.dy
end

function ScoreState:render()
    -- First prize for min awardable score 
    if self.score >= 1 and self.score <= 4 then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Well done!', 0,66, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(PRIZE_3, 200, 92)
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 180, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
    -- Second prize for medium score
    elseif self.score >= 5 and self.score <= 9 then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Good work!', 0, 56, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(PRIZE_2, 200, 90)
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 210, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 230, VIRTUAL_WIDTH, 'center')
    
    -- Highest score prize
    elseif self.score >= 10 then      
        sounds['victory']:play()
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Excellent!', 0, 56, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(PRIZE_1, 200, 100)
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 210, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 230, VIRTUAL_WIDTH, 'center')
        
        -- Ballons fly over the  trophy
        love.graphics.draw(self.image, 50, self.y)
        love.graphics.draw(self.image, self.x, self.y)
        love.graphics.draw(self.image, 350, self.y)
        

    -- Display score and loss messsage
    else
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Oof! You lost!', 0, 66, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Score: ' .. tostring(self.score), 0, 140, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end