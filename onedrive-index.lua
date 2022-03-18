---@diagnostic disable: undefined-global, lowercase-global

local json = require("JSON"):new()

function probe()
  if vlc.access ~= "http" and vlc.access ~= "https" then
    return false
  end
  if string.find(vlc.path, "vercel%.app/api/%?path=") ~= nil then
    if string.find(vlc.path, "raw=true") ~= nil or string.find(vlc.path, "/api/raw/") ~= nil or string.find(vlc.path, "loop=false") ~= nil then
      return false
    end
    return true
  end
  return false
end

function get(url)
  local stream = vlc.stream(url)
  local buf = ""
  while true do
    local ret = stream:read(1024)
    if ret == nil or ret == 0 then
      break
    end
    buf = buf .. ret
  end
  return buf
end

function get_next(next,buf)
  local next_page_json = ""
  if next == nil then
    next_page_json = get("https://"..vlc.path.."&loop=false")
  else
    next_page_json = get("https://"..vlc.path.."&next="..next.."&loop=false")
  end
  vlc.msg.err("next_page_json: "..next_page_json)
  local next_page = json:decode(next_page_json)
  for i,v in ipairs(next_page.folder.value) do
    if v.folder == nil then
      vlc.msg.err("https://" .. vlc.path .. v.name .. "&raw=true")
      buf[#buf + 1 ] =
      {
        path = "https://" .. vlc.path .. v.name .. "&raw=true",
        title = v.name,
      }
    end
  end
  if next_page.next ~= nil then
    buf = get_next(next_page.next,buf)
  end
  return buf
end

function parse()
  local buf = {}
  buf = get_next(nil,buf)
  return buf
end
