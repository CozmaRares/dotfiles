local id = 0

local function iota()
  id = id + 1
  return id
end

return {
  volume = iota(),
  brightness = iota(),
  battery = iota(),
}
