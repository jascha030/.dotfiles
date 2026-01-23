local audioSwitcher = {}

audioSwitcher.devices = {}
audioSwitcher.currentIndex = 1
audioSwitcher.isActive = false
audioSwitcher.modal = nil
audioSwitcher.alert = nil

local function get_output_devices()
    local devices = hs.audiodevice.allOutputDevices()

    return hs.fnutils.filter(devices, function(device)
        return device:name() ~= nil
    end)
end

function audioSwitcher:findCurrentDeviceIndex()
    local currentDevice = hs.audiodevice.defaultOutputDevice()

    for i, device in ipairs(self.devices) do
        if currentDevice and device:uid() == currentDevice:uid() then
            return i
        end
    end

    return 1
end

function audioSwitcher:showPreview()
    if self.alert then
        hs.alert.closeAll()
    end

    local device = self.devices[self.currentIndex]

    if device then
        local deviceList = {}

        for i, dev in ipairs(self.devices) do
            local marker = (i == self.currentIndex) and '► ' or '  '
            table.insert(deviceList, marker .. dev:name())
        end

        local message = table.concat(deviceList, '\n')
        self.alert = hs.alert.show(message, 999)
    end
end

function audioSwitcher:start()
    self.devices = get_output_devices()

    if #self.devices <= 1 then
        hs.alert.show('No audio devices found', 1)
        return
    end

    self.currentIndex = self:findCurrentDeviceIndex()
    self.isActive = true
    self.modal = hs.hotkey.modal.new()

    self.modal:bind({}, "a", function()
        self.currentIndex = (self.currentIndex % #self.devices) + 1
        self:showPreview()
    end)

    self.modal:bind({}, 'escape', function()
        self:cancel()
    end)

    self.modal:enter()
    self:showPreview()
end

function audioSwitcher:finish()
    if not self.isActive then
        return
    end

    local selectedDevice = self.devices[self.currentIndex]

    if selectedDevice then
        selectedDevice:setDefaultOutputDevice()
        hs.alert.closeAll()
    end

    self:cleanup()
end

function audioSwitcher:cancel()
    if not self.isActive then
        return
    end

    hs.alert.closeAll()
    self:cleanup()
end

function audioSwitcher:cleanup()
    self.isActive = false

    if self.modal then
        self.modal:exit()
        self.modal = nil
    end

    if self.alert then
        hs.alert.closeAll()
        self.alert = nil
    end
end

return audioSwitcher
