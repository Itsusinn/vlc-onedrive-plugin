local json = require("JSON"):new()

-- https://itsusinn-onedrive.vercel.app/api/?path=%2FMusic%2F
function probe()
  if vlc.access ~= "http" and vlc.access ~= "https" then
    return false
  end
  if string.find(vlc.path, "vercel%.app/api/%?path=") ~= nil then
    if string.find(vlc.path, "raw=true") or string.find(vlc.path, "/api/raw/") ~= nil then
      return false
    end
    return true
  end
  return false
end

function parse()
    vlc.msg.err("ok")
    local line = vlc.readline()
    local json_dir = ""
    while line ~= nil do
      json_dir = json_dir .. line
      if line then
        break
      end
      line = vlc.readline()
    end
    local dir = json:decode(json_dir)
    local buf = {}
    for i,v in ipairs(dir.folder.value) do
      buf[#buf + 1 ] =
      {
        path = "https://" .. vlc.path .. v.name .. "&raw=true",
        title = v.name,
      }
    end
    return buf
end

