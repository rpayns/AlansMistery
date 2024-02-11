Player = {}

local idleQuads = {} -- animacion para cuando anda chill
local walkRQuads = {} -- animacion para cuando camina a la derecha
local walkLQuads = {} -- animacion paracuando camina a la izquierda
local jumpQuads = {} -- animacion para cuando salte

function Player:load() -- cargar los assets del personaje
    self.spritesheet = love.graphics.newImage("assets/jugador64x64.png")
    self.height = 64
    self.width = 64
    self.x = self.width * 2
    self.y = love.graphics.getHeight() - self.height
    self.speed = 200

    -- separamos el sprite sheet en diferentes animaciones

    local flag = 0
    
    for y = 0 , self.spritesheet:getHeight() - self.height , self.height do
       for  x = 0, self.spritesheet:getWidth() - self.width , self.width do
            if flag == 0 then
                table.insert(idleQuads,love.graphics.newQuad(x,y,self.width,self.height,self.spritesheet:getDimensions()))
            elseif flag == 1 then
                table.insert(walkRQuads,love.graphics.newQuad(x,y,self.width,self.height,self.spritesheet:getDimensions()))
            elseif flag == 2 then
                table.insert(jumpQuads,love.graphics.newQuad(x,y,self.width,self.height,self.spritesheet:getDimensions()))
            else
                table.insert(walkLQuads,love.graphics.newQuad(x,y,self.width,self.height,self.spritesheet:getDimensions()))
            end

        end

        flag = flag + 1
    end

    self.animation = {
        direction = "right",
        type = idleQuads, -- la animacion por defecto sera de chill
        frame = 1 ,
        max_frames = 4,
        speed = 20,
        timer = 0.1
    }

end

function Player:update(dt)
    Player:eventsHandler(dt)
    
end


function Player:draw()
    love.graphics.draw(self.spritesheet,self.animation.type[self.animation.frame],self.x,self.y)
end

function Player:runAnimations(dt)
    self.animation.timer = self.animation.timer + dt

    -- Ajusta la velocidad de la animación para lograr 4 FPS
    local velocidad_animacion = 1 / 4  -- 1 segundo / 4 fotogramas

    if self.animation.timer > velocidad_animacion then
        self.animation.timer = 0  -- Reinicia el temporizador

        -- Incrementa la frame
        self.animation.frame = self.animation.frame + 1

        -- Verifica si es necesario reiniciar la animación
        if self.animation.frame > self.animation.max_frames then
            self.animation.frame = 1
        end
    end
end


function Player:eventsHandler(dt)
    if love.keyboard.isDown('d') then
        Player:walkRight(dt)
    elseif love.keyboard.isDown('a') then
        Player:walkLeft(dt)
    else
        Player:idle()
    end

    Player:runAnimations(dt)
end


function Player:walkRight(dt)
    self.x = self.x + (self.speed * dt)
    self.animation.type = walkRQuads
end

function Player:walkLeft(dt)
    self.x = self.x - (self.speed * dt)
    self.animation.type = walkLQuads
end

function Player:idle()
    self.animation.type = idleQuads
end




