--[[
 * ReaScript Name: JRT_Move selection start to beginning
 * Author: JR Taylor
 * Licence: GPL v3
 * REAPER: 6.26
 * Version: 1.0
--]]
 
--[[
 * Changelog:
 * v1.0 (2021-04-01)
  + Initial Release
--]]

reaper.Undo_BeginBlock()
reaper.PreventUIRefresh(1)
local pos = reaper.GetCursorPosition()

in_point, out_point = reaper.GetSet_LoopTimeRange( false, false, 0, 0, false )

start = 0.0

if in_point == out_point
  then 
  reaper.GetSet_LoopTimeRange(1, 0, start, pos, 0)  
  else
  reaper.GetSet_LoopTimeRange(1, 0, start, out_point, 0)
end

reaper.Main_OnCommand(40718, 0)

reaper.PreventUIRefresh(-1)
reaper.Undo_EndBlock("JRT_Move selection start to beginning", -1)
