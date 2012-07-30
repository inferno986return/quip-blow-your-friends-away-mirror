-- copy all globals into locals, some locals are prefixed with a G to reduce name clashes
local coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,Gload,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require=coroutine,package,string,table,math,io,os,debug,assert,dofile,error,_G,getfenv,getmetatable,ipairs,load,loadfile,loadstring,next,pairs,pcall,print,rawequal,rawget,rawset,select,setfenv,setmetatable,tonumber,tostring,type,unpack,_VERSION,xpcall,module,require

local pack=require("wetgenes.pack")
local wwin=require("wetgenes.win")
local wstr=require("wetgenes.string")
local tardis=require("wetgenes.tardis")	-- matrix/vector math

module(...)


bake=function(game)
	local js={}
	game.js=js
		
	js.read=function()
		for i=1,4 do
			local pfix="p"..i.."_"
			local tab=game.state.win:jread(i-1)
			if tab then
--				print(i,wstr.dump(tab))
				
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


	return js
end

