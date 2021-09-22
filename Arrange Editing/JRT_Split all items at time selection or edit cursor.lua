-- @description JRT_Split all items at time selection or edit cursor
-- @author JRTaylorMusic
-- @version 1.0
-- @provides [main]

-- SAVE INITIAL SELECTED ITEMS
    init_sel_items = {}
    function SaveSelectedItems (sel_items)
      for i = 0, reaper.CountSelectedMediaItems(0)-1 do
        sel_items[i+1] = reaper.GetSelectedMediaItem(0, i)
      end
    end

-- RESTORE INITIAL SELECTED ITEMS
    function RestoreSelectedItems (sel_items)
      reaper.Main_OnCommand(40289, 0) -- Unselect all items
      for _, item in ipairs(sel_items) do
        reaper.SetMediaItemSelected(item, true)
      end
    end
  
-- GET IN/OUT POINTS
    in_point, out_point = reaper.GetSet_LoopTimeRange( false, false, 0, 0, false )

-- Main function
    function main()
      if in_point == out_point
        then 
        reaper.SelectAllMediaItems(0, true)
        reaper.Main_OnCommand(40012, 0) --split at edit or play cursor
        RestoreSelectedItems(init_sel_items)
        else
        reaper.SelectAllMediaItems(0, true)
        reaper.Main_OnCommand(40061, 0) --split at time selection
        RestoreSelectedItems(init_sel_items)
      end
    end

reaper.PreventUIRefresh(1)

reaper.Undo_BeginBlock() -- Begining of the undo block. Leave it at the top of your main function.

main()

reaper.Undo_EndBlock("JRT_Split all items at time selection or edit cursor", -1) -- End of the undo block. Leave it at the bottom of your main function.

reaper.UpdateArrange()

reaper.PreventUIRefresh(-1)
