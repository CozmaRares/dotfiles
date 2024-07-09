local nvim = vim

-- open nvim tree
-- recenter nv dash
if #nvim.v.argv <= 2 then
  nvim.cmd "NvimTreeFocus"
  nvim.cmd "Nvdash"
end
