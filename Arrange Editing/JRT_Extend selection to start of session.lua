-- @description Display name/short description
-- @version 1.0.1
-- @author JRTaylorMusic


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
reaper.Undo_EndBlock("JRT_Extend selection to start of session", -1)
