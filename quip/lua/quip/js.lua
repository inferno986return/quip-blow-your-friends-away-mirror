-- copy all globals into locals, some locals are prefixed with a G to reduce name clashes
local coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,Gload,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require=coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,load,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require

local pack=require("wetgenes.pack")
local wwin=require("wetgenes.win")
local wstr=require("wetgenes.string")
local tardis=require("wetgenes.tardis")	-- matrix/vector math

module(...)

local ps3=true

bake=function(game)
	local js={}
	game.js=js
		
	js.read=function()
		local loop=true
		while loop do
		loop=false
		for i=1,4 do
			local pfix="p"..i.."_"
			local tab=game.state.win:jread(i-1)
			if tab then
				loop=true

-- this is a ps3 pad, since I'm the only one with an unbranded ps2 converter thingy :)

-- you can get ps2 to ps3 usb adapters for a couple of quid so lets go with that option
-- just plug a powered hub and some converters into a PI and away you go

if tab.value==1 then
-- uncomment this to dump out info from whatever joystick is plugged in
--				print(i,wstr.dump(tab))
end

if ps3 then
				if tab.type==1 then
					for i,v in ipairs{
						{4,"up"},
						{5,"right"},
						{6,"down"},
						{7,"left"},
						{8,"down"},
						{9,"up"},
						{12,"fire"},
						{13,"fire"},
						{14,"fire"},
						{15,"fire"},
						} do
						if tab.number==v[1] then
							if tab.value==0 then
								game.input.volatile[ pfix..v[2] ]=false
							else
								game.input.volatile[ pfix..v[2] ]=true
							end
						end
					end
				end


-- this is my unbranded ps2 converter thingy

else

				if tab.number==0 then -- left right
					if tab.value<-256 then
						game.input.volatile[pfix.."left"] =true
						game.input.volatile[pfix.."right"]=false
					elseif tab.value>256 then
						game.input.volatile[pfix.."left"] =false
						game.input.volatile[pfix.."right"]=true
					else
						game.input.volatile[pfix.."left"] =false
						game.input.volatile[pfix.."right"]=false
					end
				elseif tab.number==4 then -- down
					if tab.value==0 then
						game.input.volatile[pfix.."down"]=false
					else
						game.input.volatile[pfix.."down"]=true
					end
				elseif tab.number==5 then -- up
					if tab.value==0 then
						game.input.volatile[pfix.."up"]=false
					else
						game.input.volatile[pfix.."up"]=true
					end
				elseif tab.number==2 then -- value
					if tab.value==0 then
						game.input.volatile[pfix.."fire"]=false
					else
						game.input.volatile[pfix.."fire"]=true
					end
				end
end
			end
		end	
		end
		
	end


	return js
end

