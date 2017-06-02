local firebaseDatabase = require "plugin.firebaseDatabase"
firebaseDatabase.init()

local widget = require("widget")
local json = require("json")
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 1,.5,0 )

local title = display.newText( {text = "Firebase Database", fontSize = 30} )
title.width, title.height = 300, 168
title.x, title.y = display.contentCenterX, 168*.5
title:setFillColor(1,0,0)

local getButton
getButton = widget.newButton( {
  x = display.contentCenterX,
  y = display.contentCenterY-100,
  id = "Get Test Data",
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
  label = "Get Test Data",
  onEvent = function ( e )
    if (e.phase == "ended") then
      firebaseDatabase.get("testData", function (ev)
        if(ev.isError) then
            native.showAlert( "Could not Get Data", ev.error , {"Ok"} )
        else
            native.showAlert( "Data received", json.encode( ev.data ) , {"Ok"} )
        end
      end)
    end
  end
} )
local setButton
setButton = widget.newButton( {
  x = display.contentCenterX,
  y = display.contentCenterY,
  id = "Set Hello World",
  labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
  label = "Set Hello World",
  onEvent = function ( e )
    if (e.phase == "ended") then
        firebaseDatabase.set("testData",{firstEntry = "Hello World"}, function (ev)
            if(ev.isError) then
                native.showAlert( "Could not Upload Data", ev.error , {"Ok"} )
            else
                native.showAlert( "Data send", "" , {"Ok"} )
            end
        end
       )
    end
  end
} )
