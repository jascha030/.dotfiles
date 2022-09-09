local utils = require('jascha030.utils')

local M = {}

local function next()
    hs.itunes.next()
    hs.itunes.displayCurrentTrack()
end

local function previous()
    hs.itunes.previous()
    hs.itunes.displayCurrentTrack()
end

function M.play()
    hs.itunes.playpause()
end

function M.next()
    utils.alert(next)
end

function M.previous()
    utils.alert(previous)
end

function M.display()
    utils.alert(hs.itunes.displayCurrentTrack)
end

return M
