pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--mellow meadow deluxe
--by niall chandler

--music from picotunes vol.2
--by gruber

--dev start date: 3/9/2020
--release date: 31/10/2020

--deluxe start date: 18/11/2020
--deluxe release date: 27/11/2020

--version 1.0.1

--variables

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

--disables button repeat
poke(0x5f5c,255)

--play music on startup
music(16)

--saved trophy
trophy=0

--player movement stats
player={
    sp=1,
--sp=sprite
    x=24,
--x=position left to right
    y=104,
--y=position top to bottom
    w=8,
--w=width
    h=8,
--h=height
    flp=false,
--flp=flip
    dx=0,
--dx=change in x
    dy=0,
--dy=change in y
    max_dx=1.8,
    max_dy=3,
    acc=0.5,
--acc=acceleration
    boost=4,
    anim=0,
--anim=animation
    running=false,
    jumping=false,
    falling=false,
    sliding=false,
    landed=false,
    death=false,
    coins=0,
  }
  
--coins
 --level 1
  coin={
  x=288,
  y=0,
  w=8,
  h=8,
  sp=16,
  anim=0,
  }  
  coin1={
  x=416,
  y=88,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin2={
  x=864,
  y=8,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
 --level 2
  coin3={
  x=144,
  y=136,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin4={
  x=424,
  y=136,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin5={
  x=1016,
  y=160,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
 --level 3
  coin6={
  x=80,
  y=360,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin7={
  x=424,
  y=360,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin8={
  x=880,
  y=304,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
 --level 4
  coin9={
  x=200,
  y=400,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin10={
  x=408,
  y=448,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
  coin11={
  x=984,
  y=408,
  w=8,
  h=8,
  sp=16,
  anim=0,
  } 
 
 --lava
  lava={
  x=88,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava1={
  x=96,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava2={
  x=104,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava3={
  x=112,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava4={
  x=120,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava5={
  x=128,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava6={
  x=136,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava7={
  x=144,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava8={
  x=152,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava9={
  x=160,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava10={
  x=168,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava11={
  x=176,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava12={
  x=184,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  lava13={
  x=192,
  y=504,
  w=8,
  h=8,
  sp=22,
  anim=0,
  }
  
  gravity=0.3
  friction=0.7
  
--jump counter
  jumps=0
  
--death counter
  deaths=0
  
--simple camera
  cam_x=0
  cam_y=0
--cam=camera
  
--map limits
  map_start=0
  map_end=1024
    
--jump button toggle
  button=false    
    
--time
  milliseconds=0
  seconds=0
  minutes=0
  hours=0
  sprun=0
  
--other
  debug=0
  finishes=0
  
 --toggle jump btn in pause menu
  menuitem(1,"swap ❎/🅾️",function() ❎,🅾️=🅾️,❎ end)
   function btnr(b)
    return not btn(b) and f_btn[b]
   end
  
 --add timer
  menuitem(2,"toggle timer hud",
  function()
  speedrun=not speedrun
    if speedrun then
      sprun=1
      dset(1,sprun)
    else
      sprun=0
      dset(1,sprun)
    end
  end)
  
 --add scanlines  
  menuitem(3,"add scanlines",
  function()
  lines=not lines
    if lines then
     scanlines()
    else
     
    end
  end)
  
 --add debug
  menuitem(4,"debug mode",
  function()
  bug=not bug
    if bug then
      debug=1
      dset(2,debug)
    else
      debug=0
      dset(2,debug)
    end
  end)
    
 function scanlines()
  poke(0x5f2c,0x40)
  poke(0x5f5f,0x10)
   for i=0,15 do
    --scanline palette here
    poke(0x5f60+i,i+128)
   end
   for i=0,15 do
    poke(0x5f70+i,0xaa)
   end
 end

--dialog box

dialog = {
  x = 4,
  y = 94,
  color = 7,
  max_chars_per_line = 30,
  max_lines = 5,
  dialog_queue = {},
  blinking_counter = 0,
  init = function(self)
  end,
  queue = function(self, message, autoplay)
    -- default autoplay to false
    autoplay = type(autoplay) == "nil" and false or autoplay
    add(self.dialog_queue, {
      message = message,
      autoplay = autoplay
    })

    if (#self.dialog_queue == 1) then
      self:trigger(self.dialog_queue[1].message, self.dialog_queue[1].autoplay)
    end
  end,
  trigger = function(self, message, autoplay)
    self.autoplay = autoplay
    self.current_message = ''
    self.messages_by_line = nil
    self.animation_loop = nil
    self.current_line_in_table = 1
    self.current_line_count = 1
    self.pause_dialog = false
    self:format_message(message)
    self.animation_loop = cocreate(self.animate_text)
  end,
  format_message = function(self, message)
    local total_msg = {}
    local word = ''
    local letter = ''
    local current_line_msg = ''

    for i = 1, #message do
      -- get the current letter add
      letter = sub(message, i, i)

      -- keep track of the current word
      word ..= letter

      -- if it's a space or the end of the message,
      -- determine whether we need to continue the current message
      -- or start it on a new line
      if letter == ' ' or i == #message then
        -- get the potential line length if this word were to be added
        local line_length = #current_line_msg + #word
        -- if this would overflow the dialog width
        if line_length > self.max_chars_per_line then
          -- add our current line to the total message table
          add(total_msg, current_line_msg)
          -- and start a new line with this word
          current_line_msg = word
        else
          -- otherwise, continue adding to the current line
          current_line_msg ..= word
        end

        -- if this is the last letter and it didn't overflow
        -- the dialog width, then go ahead and add it
        if i == #message then
          add(total_msg, current_line_msg)
        end

        -- reset the word since we've written
        -- a full word to the current message
        word = ''
      end
    end

    self.messages_by_line = total_msg
  end,
  animate_text = function(self)
    -- for each line, write it out letter by letter
    -- if we each the max lines, pause the coroutine
    -- wait for input in update before proceeding
    for k, line in pairs(self.messages_by_line) do
      self.current_line_in_table = k
      for i = 1, #line do
        self.current_message ..= sub(line, i, i)

        -- press btn 5 to skip to the end of the current passage
        -- otherwise, print 1 character per frame
        -- with sfx about every 5 frames
        if (not btnp(5)) then
          if (i % 5 == 0) sfx()
          yield()
        end
      end
      self.current_message ..= '\n'
      self.current_line_count += 1
      if ((self.current_line_count > self.max_lines) or (self.current_line_in_table == #self.messages_by_line and not self.autoplay)) then
        self.pause_dialog = true
        yield()
      end
    end

    if (self.autoplay) then
      self.delay(30)
    end
  end,
  shift = function (t)
    local n=#t
    for i = 1, n do
      if i < n then
        t[i] = t[i + 1]
      else
        t[i] = nil
      end
    end
  end,
  -- helper function to add delay in coroutines
  delay = function(frames)
    for i = 1, frames do
      yield()
    end
  end,
  update = function(self)
    if (self.animation_loop and costatus(self.animation_loop) != 'dead') then
      if (not self.pause_dialog) then
        coresume(self.animation_loop, self)
      else
        if btnp(4) then
          self.pause_dialog = false
          self.current_line_count = 1
          self.current_message = ''
        end
      end
    elseif (self.animation_loop and self.current_message) then
      if (self.autoplay) self.current_message = ''
      self.animation_loop = nil
    end

    if (not self.animation_loop and #self.dialog_queue > 0) then
      self.shift(self.dialog_queue, 1)
      if (#self.dialog_queue > 0) then
        self:trigger(self.dialog_queue[1].message, self.dialog_queue[1].autoplay)
        coresume(self.animation_loop, self)
      end
    end

    if (not self.autoplay) then
      self.blinking_counter += 1
      if self.blinking_counter > 30 then self.blinking_counter = 0 end
    end
  end,
  draw = function(self)
    local screen_width = 128

    -- display message
    if (self.current_message) then
      print(self.current_message, self.x, self.y, self.color)
    end

    -- draw blinking cursor at the bottom right
    if (not self.autoplay and self.pause_dialog) then
      if self.blinking_counter > 15 then
        if (self.current_line_in_table == #self.messages_by_line) then
          -- draw square
          rectfill(
            screen_width - 11,
            screen_width - 10,
            screen_width - 11 + 3,
            screen_width - 10 + 3,
            7
          )
        else
          -- draw arrow
          line(screen_width - 12, screen_width - 9, screen_width - 8,screen_width - 9)
          line(screen_width - 11, screen_width - 8, screen_width - 9,screen_width - 8)
          line(screen_width - 10, screen_width - 7, screen_width - 10,screen_width - 7)
        end
      end
    end
  end
}

--initalize cartridge

function _init()
  init_menu()

--save system
 cartdata("ngc_mmd_11")
 trophy = dget(0)
 sprun = dget(1)
 debug = dget(2)
 finishes = dget(3)

  --text in the dialog box

  dialog:queue("thank you so much for playing my game! you are a super player!!")
 --dialog:queue("credits:")
 --dialog:queue("created by niall chandler, with music by chris donnelly (gruber), and translated by (your name).")
  dialog:queue("special thanks to the following awesome people:")
  dialog:queue("jerry_boy, miziziziz of https://bit.ly/2hl29q6, gruber_music, nerdy teachers of https://rb.gy/a5wyvv, freds72, pizza_boys, johanp, bonevolt, fast121, vahe2003, ultrachris64, rustybailey, pegboardnerds, thijsengel, sophie houlden, zep, davbo, and my friends & family ♥")
  dialog:queue("if it weren't for all of them, this game would never have been made.")
  dialog:queue("you can press 🅾️ to go back to the title screen.")

end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

--timer
function updateplaytime()
 milliseconds+=1
 
 if milliseconds==60 then
  seconds+=1
  milliseconds=0
  if seconds==60 then
   minutes+=1
   seconds=0
   if minutes==60 then
    hours+=1
    minutes=0
   end
  end
 end
end
-->8
--update and draw

function init_game()
  _update60=update_menu
  _draw=draw_menu
  music(8)
 function _update60()
  player_update60()
  player_animate()
  updateplaytime()
  
 
  --stops integer overflow bugs
  if deaths>9999 then
    deaths=9999
  end
  
  if finishes>9999 then
    finishes=9999
  end
  
  if jumps>9999 then
    jumps=9999
  end
  
 --simple camera
  cam_x=player.x-64+(player.w/2)
  if cam_x<map_start then
    cam_x=map_start
  end
  if cam_x>map_end-128 then
    cam_x=map_end-128
  end
  camera(cam_x,cam_y)
  
 end

 function _draw()
  if level==1 then
    cls(12)
  elseif level==2 then
    cls(15)
  elseif level==3 then
    cls(0)
  elseif level==4 then
    cls(2)
  end
  map(0,0,0,0,128,64)
  spr(player.sp,player.x,player.y,1,1,player.flp)
  spr(coin.sp,coin.x,coin.y,1,1)
		spr(coin1.sp,coin1.x,coin1.y,1,1)
		spr(coin2.sp,coin2.x,coin2.y,1,1)
		spr(coin3.sp,coin3.x,coin3.y,1,1)
		spr(coin4.sp,coin4.x,coin4.y,1,1)
		spr(coin5.sp,coin5.x,coin5.y,1,1)
		spr(coin6.sp,coin6.x,coin6.y,1,1)
		spr(coin7.sp,coin7.x,coin7.y,1,1)
		spr(coin8.sp,coin8.x,coin8.y,1,1)
		spr(coin9.sp,coin9.x,coin9.y,1,1)
		spr(coin10.sp,coin10.x,coin10.y,1,1)
		spr(coin11.sp,coin11.x,coin11.y,1,1)
		spr(lava.sp,lava.x,lava.y,1,1)
		spr(lava1.sp,lava1.x,lava1.y,1,1)
		spr(lava2.sp,lava2.x,lava2.y,1,1)
		spr(lava3.sp,lava3.x,lava3.y,1,1)
		spr(lava4.sp,lava4.x,lava4.y,1,1)
		spr(lava5.sp,lava5.x,lava5.y,1,1)
		spr(lava6.sp,lava6.x,lava6.y,1,1)
		spr(lava7.sp,lava7.x,lava7.y,1,1)
		spr(lava8.sp,lava8.x,lava8.y,1,1)
		spr(lava9.sp,lava9.x,lava9.y,1,1)
		spr(lava10.sp,lava10.x,lava10.y,1,1)
		spr(lava11.sp,lava11.x,lava11.y,1,1)
		spr(lava12.sp,lava12.x,lava12.y,1,1)
		spr(lava13.sp,lava13.x,lava13.y,1,1)

 --coin count 
  print("◆"..player.coins.."/12",camera(cam_x+0),2,1)
  print("◆"..player.coins.."/12",camera(cam_x+0),1,10)
  
 --speedrun timer
  if sprun==1 then
   print("⧗"..hours.."h "..minutes.."m "..seconds.."s "..milliseconds.."f",camera(cam_x+0),9,1)
   print("⧗"..hours.."h "..minutes.."m "..seconds.."s "..milliseconds.."f",camera(cam_x+0),8,8)
  end
  
  if trophy==1 then
   spr(13,camera(cam_x+0),113)
  end
  
 --level
  if level==1 then
    print("mELLOW mEADOW",camera(cam_x+0),123,1)
    print("mELLOW mEADOW",camera(cam_x+0),122,14)
  elseif level==2 then
    print("pEACHY pASTURE",camera(cam_x+0),123,1)
    print("pEACHY pASTURE",camera(cam_x+0),122,14)
  elseif level==3 then
    print("gLACIAL gROTTO",camera(cam_x+0),123,1)
    print("gLACIAL gROTTO",camera(cam_x+0),122,14)
  elseif level==4 then
    print("cULMINAL cASTLE",camera(cam_x+0),123,1)
    print("cULMINAL cASTLE",camera(cam_x+0),122,14)
  end
  
--ABCDEFGHIJKLMNOPQRSTUVWXYZ  
  
 --debug-------------------------------------------------------------------
if debug==1 then
 rect(x1r,y1r,x2r,y2r,7)
 print("jumps="..jumps,camera(cam_x+0),14)
 print("cpu:"..flr(stat(1)*100).."%",camera(cam_x+0),20)
 print("target fps:"..flr(stat(8)),camera(cam_x+0),26)
 print("pico-8 fps:"..flr(stat(9)),camera(cam_x+0),32)
 print("mem:"..flr(stat(0)),camera(cam_x+0),38)
 print("x pos:".. player.x,camera(cam_x+0),44)
 print("y pos:".. player.y,camera(cam_x+0),50)
 print("x tile:".. ((player.x - (player.x % 8)) / 8),camera(cam_x+0),56)
 print("y tile:".. ((player.y - (player.y % 8)) / 8),camera(cam_x+0),62)
 print("music ticks:"..flr(stat(26)),camera(cam_x+0),68)
 print("deaths="..deaths,camera(cam_x+0),74)
 print("level="..level,camera(cam_x+0),80)
 print("f="..milliseconds,camera(cam_x+0),86)
 print("s="..seconds,camera(cam_x+0),92)
 print("m="..minutes,camera(cam_x+0),98)
 print("h="..hours,camera(cam_x+0),104)
 print("finishes="..finishes,camera(cam_x+0),110)
 print("debug="..debug,camera(cam_x+0),116)
end
---------------------------------------------------------------------------
--ABCDEFGHIJKLMNOPQRSTUVWXYZ   
 end
end


-->8
--collisions

--obj=game object
--aim=direction

function collide_map(obj,aim,flag)
 --obj = table needs x,y,w,h
 --aim = left,right,up,down

 local x=obj.x  local y=obj.y
 local w=obj.w  local h=obj.h
 
 local x1=0  local y1=0
 local x2=0  local y2=0
 
 if aim=="left" then
   x1=x-1  y1=y
   x2=x    y2=y+h-1
   
 elseif aim=="right" then
   x1=x+w-1    y1=y
   x2=x+w  y2=y+h-1
   
 elseif aim=="up" then
   x1=x+2    y1=y-1
   x2=x+w-3  y2=y
   
 elseif aim=="down" then
   x1=x+2      y1=y+h
   x2=x+w-3    y2=y+h
 end
 
 --debug-------
 x1r=x1  y1r=y1
 x2r=x2  y2r=y2
 --------------
 
 --pixels to tiles
 x1/=8    y1/=8
 x2/=8    y2/=8
 
 if fget(mget(x1,y1), flag)
 or fget(mget(x1,y2), flag)
 or fget(mget(x2,y1), flag)
 or fget(mget(x2,y2), flag) then
   return true
 else
   return false
 end

end
-->8
--player & foilage

level=1

if level>5 then
  level=5
end

function player_update60()
  if collide_map(player,"down",2) then
    --ice=flag 2
    friction=0.97
    player.max_dx=1.8
  elseif collide_map(player,"down",3) then
    --honey=flag 3
    friction=0.05
    player.boost=2.3
  		--spring
		elseif collide_map(player,"up",4) then
			player.dy=-player.max_dy
			player.dy+=player.boost+5 
			player.falling=true
			player.jumping=false
			player.landed=false
			sfx(16)
		elseif collide_map(player,"down",4) then
			player.dy=player.max_dy
			player.dy-=player.boost+5 
			player.jumping=true
			player.landed=false
			sfx(16)
  elseif collide_map(player,"down",6) then
    --death=flag 6
    init_death()
    deaths+=1
  elseif collide_map(player,"up",6) then
    --death=flag 6
    init_death()
    deaths+=1
  elseif collide_map(player,"down",7) then
    --goal=flag 7
    --init_win()
    level+=1
      if level==1 then
        cam_y+=0
        player.x=24
        player.y=104
      elseif level==2 then
        cam_y+=128
        player.x=24
        player.y=232
      elseif level==3 then
        cam_y+=128
        player.x=24
        player.y=360
      elseif level==4 then
        cam_y+=128
        player.x=24
        player.y=488
      elseif level==5 then
        finishes+=1
        dset(3,finishes)
        init_win()
      end
    sfx(10)
  else
    --default
    friction=0.7
    player.max_dx=1.8
    player.boost=4
  end
  --physics
  player.dy+=gravity
  player.dx*=friction
  --controls
  if btn(⬅️) or btn(⬅️,2) then
    player.dx-=player.acc
    player.running=true
    player.flp=true
  end
  if btn(➡️) then
    player.dx+=player.acc
    player.running=true
    player.flp=false
  end
  
  --slide
  if player.running
  and not btn(⬅️)
  and not btn(➡️)
  and not player.falling
  and not player.jumping then
    player.running=false
    player.sliding=true
    sfx(23)
  end
  
  --look up
  if btn(⬆️)
  and not player.running
  and not player.sliding then
    player.sp=11
     if time()-player.anim>.05 then
      player.anim=time()
      player.sp+=1
       if player.sp>11 then
          player.sp=11
       end
     end
  end
  
  --crouch
  if btn(⬇️)
  and not player.running
  and not player.sliding then
    player.sp=12
   if time()-player.anim>.05 then
      player.anim=time()
      player.sp+=1
     if player.sp>12 then
        player.sp=12
     end
    end
  end
  
  --jump
 if button==false then
  if btnp(❎)
  and player.landed then
    player.dy-=player.boost
    player.landed=false
    jumps+=1
    sfx(22)
  end
 else
    if btnp(🅾️)
  and player.landed then
    player.dy-=player.boost
    player.landed=false
    jumps+=1
    sfx(22)
  end
 end
 
  --coin collision
 	function coin_hitbox(co_x,co_y,co_w,co_h)
 	
 			if player.y-player.h/2 > co_y+co_h/4 then
 					return false
 			end
 			if player.y+player.h/2 < co_y-co_h then
 					return false
 			end
 				if player.x-player.w/2 > co_x+co_w/2 then
 					return false
 			end
 			if player.x+player.w/2 < co_x-co_w/2 then
 					return false
 			end
 			
 			return true
		end
		
		--coin hitboxes
		if coin_hitbox(coin.x,coin.y,coin.w,coin.h) then
					player.coins+=1
					coin.x=-128
					coin.y=-128
					sfx(24)
		end
			if coin_hitbox(coin1.x,coin1.y,coin1.w,coin1.h) then
					player.coins+=1
					coin1.x=-128
					coin1.y=-128
					sfx(24)
		end
		if coin_hitbox(coin2.x,coin2.y,coin2.w,coin2.h) then
					player.coins+=1
					coin2.x=-128
					coin2.y=-128
					sfx(24)
		end
		if coin_hitbox(coin3.x,coin3.y,coin3.w,coin3.h) then
					player.coins+=1
					coin3.x=-128
					coin3.y=-128
					sfx(24)
		end
		if coin_hitbox(coin4.x,coin4.y,coin4.w,coin4.h) then
					player.coins+=1
					coin4.x=-128
					coin4.y=-128
					sfx(24)
		end
		if coin_hitbox(coin5.x,coin5.y,coin5.w,coin5.h) then
					player.coins+=1
					coin5.x=-128
					coin5.y=-128
					sfx(24)
		end
		if coin_hitbox(coin6.x,coin6.y,coin6.w,coin6.h) then
					player.coins+=1
					coin6.x=-128
					coin6.y=-128
					sfx(24)
		end
		if coin_hitbox(coin7.x,coin7.y,coin7.w,coin7.h) then
					player.coins+=1
					coin7.x=-128
					coin7.y=-128
					sfx(24)
		end
		if coin_hitbox(coin8.x,coin8.y,coin8.w,coin8.h) then
					player.coins+=1
					coin8.x=-128
					coin8.y=-128
					sfx(24)
		end
		if coin_hitbox(coin9.x,coin9.y,coin9.w,coin9.h) then
					player.coins+=1
					coin9.x=-128
					coin9.y=-128
					sfx(24)
		end
				if coin_hitbox(coin10.x,coin10.y,coin10.w,coin10.h) then
					player.coins+=1
					coin10.x=-128
					coin10.y=-128
					sfx(24)
		end
				if coin_hitbox(coin11.x,coin11.y,coin11.w,coin11.h) then
					player.coins+=1
					coin11.x=-128
					coin11.y=-128
					sfx(24)
		end
  
  
  --lava collision
 	function lava_hitbox(la_x,la_y,la_w,la_h)
 	
 			if player.y-player.h/2 > la_y+la_h/4 then
 					return false
 			end
 			if player.y+player.h/2 < la_y-la_h then
 					return false
 			end
 				if player.x-player.w/2 > la_x+la_w/2 then
 					return false
 			end
 			if player.x+player.w/2 < la_x-la_w/2 then
 					return false
 			end
 			
 			return true
		end  
		
	--lava hitboxes
	 if lava_hitbox(lava.x,lava.y,lava.w,lava.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava1.x,lava1.y,lava1.w,lava1.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava2.x,lava2.y,lava2.w,lava2.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava3.x,lava3.y,lava3.w,lava3.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava4.x,lava4.y,lava4.w,lava4.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava4.x,lava4.y,lava4.w,lava4.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava5.x,lava5.y,lava5.w,lava5.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava6.x,lava6.y,lava6.w,lava6.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava7.x,lava7.y,lava7.w,lava7.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava8.x,lava8.y,lava8.w,lava8.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava9.x,lava9.y,lava9.w,lava9.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava10.x,lava10.y,lava10.w,lava10.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava11.x,lava11.y,lava11.w,lava11.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava12.x,lava12.y,lava12.w,lava12.h) then
					init_death()
					deaths+=1
					sfx()
		end
			 if lava_hitbox(lava13.x,lava13.y,lava13.w,lava13.h) then
					init_death()
					deaths+=1
					sfx()
		end
  
  --check collision up and down
  if player.dy>0 then
    player.falling=true
    player.landed=false
    player.jumping=false
    
    player.dy=limit_speed(player.dy,player.max_dy)
    
    if collide_map(player,"down",0) then
      player.landed=true
      player.falling=false
      player.dy=0
      player.y-=((player.y+player.h+1)%8)-1
      
    end
  elseif player.dy<0 then
    player.jumping=true
    if collide_map(player,"up",1) then
      player.dy=0
      
    end
  end
  
  --check collision left and right
  if player.dx<0 then
  
    player.dx=limit_speed(player.dx,player.max_dx)
  
    if collide_map(player,"left",1) then
      player.dx=0
      
    end
  elseif player.dx>0 then
  
    player.dx=limit_speed(player.dx,player.max_dx)
  
    if collide_map(player,"right",1) then
      player.dx=0
      
    end
  end

  --stop sliding
  if player.sliding then
    if abs(player.dx)<.2
    or player.running then
      player.dx=0
      player.sliding=false
    end
  end

  player.x+=player.dx
  player.y+=player.dy
  
  --limit player to map
  if player.x<map_start then
    player.x=map_start
  end
  if player.x>map_end-player.w then
    player.x=map_end-player.w
  end
end

function player_animate()
  if player.jumping then
    player.sp=7
  elseif player.falling then
    player.sp=8
  elseif player.sliding then
    player.sp=9

  elseif player.running then
    if time()-player.anim>.05 then
      player.anim=time()
      player.sp+=1
      if player.sp>4 then
        player.sp=3
      end
    end
  else --player idle
    if time()-player.anim>.6 then
      player.anim=time()
      player.sp+=1
      if player.sp>2 then
        player.sp=1
      end
    end
  end
  --coin rotation
    if time()-coin.anim>.1 then
      coin.anim=time()
      coin.sp+=1
      if coin.sp>19 then
        coin.sp=16
      end
    end
  --coin 2 rotation
    if time()-coin1.anim>.1 then
      coin1.anim=time()
      coin1.sp+=1
      if coin1.sp>19 then
        coin1.sp=16
      end
    end
  --coin 3 rotation
    if time()-coin2.anim>.1 then
      coin2.anim=time()
      coin2.sp+=1
      if coin2.sp>19 then
        coin2.sp=16
      end
    end
  --coin 4 rotaion
    if time()-coin3.anim>.1 then
      coin3.anim=time()
      coin3.sp+=1
      if coin3.sp>19 then
        coin3.sp=16
      end
    end
  --c0in 5 rotation
    if time()-coin4.anim>.1 then
      coin4.anim=time()
      coin4.sp+=1
      if coin4.sp>19 then
        coin4.sp=16
      end
    end
  --coin 6 roation
    if time()-coin5.anim>.1 then
      coin5.anim=time()
      coin5.sp+=1
      if coin5.sp>19 then
        coin5.sp=16
      end
    end
  --coin 7 rotation
    if time()-coin6.anim>.1 then
      coin6.anim=time()
      coin6.sp+=1
      if coin6.sp>19 then
        coin6.sp=16
      end
    end
  --coin 8 rotation
    if time()-coin7.anim>.1 then
      coin7.anim=time()
      coin7.sp+=1
      if coin7.sp>19 then
        coin7.sp=16
      end
    end
  --coin 9 rotation
    if time()-coin8.anim>.1 then
      coin8.anim=time()
      coin8.sp+=1
      if coin8.sp>19 then
        coin8.sp=16
      end
    end
  --coin 10 rotation
    if time()-coin9.anim>.1 then
      coin9.anim=time()
      coin9.sp+=1
      if coin9.sp>19 then
        coin9.sp=16
      end
    end
  --coin 11 rotation
    if time()-coin10.anim>.1 then
      coin10.anim=time()
      coin10.sp+=1
      if coin10.sp>19 then
        coin10.sp=16
      end
    end
  --coin 12 rotation
    if time()-coin11.anim>.1 then
      coin11.anim=time()
      coin11.sp+=1
      if coin11.sp>19 then
        coin11.sp=16
      end
    end
    
    
  --all lava animation
    if time()-lava.anim>.1 then
      lava.anim=time()
      lava.sp+=1
      if lava.sp>29 then
        lava.sp=22
      end
    end
        if time()-lava1.anim>.1 then
      lava1.anim=time()
      lava1.sp+=1
      if lava1.sp>29 then
        lava1.sp=22
      end
    end
        if time()-lava2.anim>.1 then
      lava2.anim=time()
      lava2.sp+=1
      if lava2.sp>29 then
        lava2.sp=22
      end
    end
        if time()-lava2.anim>.1 then
      lava2.anim=time()
      lava2.sp+=1
      if lava2.sp>29 then
        lava2.sp=22
      end
    end
        if time()-lava3.anim>.1 then
      lava3.anim=time()
      lava3.sp+=1
      if lava3.sp>29 then
        lava3.sp=22
      end
    end
        if time()-lava4.anim>.1 then
      lava4.anim=time()
      lava4.sp+=1
      if lava4.sp>29 then
        lava4.sp=22
      end
    end
        if time()-lava5.anim>.1 then
      lava5.anim=time()
      lava5.sp+=1
      if lava5.sp>29 then
        lava5.sp=22
      end
    end
        if time()-lava6.anim>.1 then
      lava6.anim=time()
      lava6.sp+=1
      if lava6.sp>29 then
        lava6.sp=22
      end
    end
        if time()-lava7.anim>.1 then
      lava7.anim=time()
      lava7.sp+=1
      if lava7.sp>29 then
        lava7.sp=22
      end
    end
        if time()-lava8.anim>.1 then
      lava8.anim=time()
      lava8.sp+=1
      if lava8.sp>29 then
        lava8.sp=22
      end
    end
        if time()-lava9.anim>.1 then
      lava9.anim=time()
      lava9.sp+=1
      if lava9.sp>29 then
        lava9.sp=22
      end
    end
        if time()-lava10.anim>.1 then
      lava10.anim=time()
      lava10.sp+=1
      if lava10.sp>29 then
        lava10.sp=22
      end
    end
        if time()-lava11.anim>.1 then
      lava11.anim=time()
      lava11.sp+=1
      if lava11.sp>29 then
        lava11.sp=22
      end
    end
        if time()-lava12.anim>.1 then
      lava12.anim=time()
      lava12.sp+=1
      if lava12.sp>29 then
        lava12.sp=22
      end
    end
        if time()-lava13.anim>.1 then
      lava13.anim=time()
      lava13.sp+=1
      if lava13.sp>29 then
        lava13.sp=22
      end
    end
end

--limit the player speed

function limit_speed(num,maximum)
  return mid(-maximum,num,maximum)
end

-->8
--main menu

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

function init_menu()
  _update60=update_menu
  _draw=draw_menu
  poke(0x5f38,1)
  poke(0x5f39,2)
end

  local dz,dy=0,0
  local cx,cy,cz=0,0,0
  local angle=0

function update_menu()
 if btnp(🅾️) or btnp(❎) then
   init_story()
   sfx()
 end
  
  --move right
  angle+=1/512
 
 cx+=dz*sin(angle)
 cz+=-dz*cos(angle)
 cy=max(cy+dy,1)
 dy-=0.01
 --cy=abs(5*cos(time()/16))
	dz*=0.8
  
end

function draw_menu()
  cls(12)
 local a=angle--time()/4
 local ca,sa=cos(a),-sin(a)
 local cx,cy,cz=cx>>2,cy<<4,cz>>2
	for ye=65,127,4 do
		local rz0,rz1=cy/(ye-64),cy/(ye-60)
		local sz0_0,sz0_1=sa*rz0+cx,ca*rz0+cz
		local sz1_0,sz1_1=sa*rz1+cx,ca*rz1+cz
  rz0=rz0>>6
  rz1=rz1>>6
		local rx0,rx1=-rz0*64,-rz1*64
  for xe=0,127 do
			-- coords in world space (far)
			local x0,z0,x1,z1=ca*rx0+sz0_0,-sa*rx0+sz0_1,ca*rx1+sz1_0,-sa*rx1+sz1_1
	 	--rectfill(0,ye,127,ye,zcam*16)	
	  tline(xe,ye,xe,ye+3,x0,z0,(x1-x0)>>2,(z1-z0)>>2)
   rx0+=rz0
   rx1+=rz1
  end
 end
 
 --title screen text
  --border
  rectfill(31,21,96,50,1)
  --mellow
  spr(32,40,23)
  spr(33,48,23)
  spr(34,56,23)
  spr(34,64,23)
  spr(35,72,23)
  spr(36,80,23)
  --meadow
  spr(32,40,32)
  spr(33,48,32)
  spr(37,56,32)
  spr(38,64,32)
  spr(35,72,32)
  spr(36,80,32)
  --deluxe
  spr(38,40,41)
  spr(33,48,41)
  spr(34,56,41)
  spr(39,64,41)
  spr(40,72,41)
  spr(33,80,41)
  --stars
  spr(20,32,24)
  spr(20,32,33)
  spr(20,32,42)
  spr(21,88,24)
  spr(21,88,33)
  spr(21,88,42)
  --edges
   --top left
   circfill(29,22,2,12)
   circfill(32,19,2,12)
   --top right
   circfill(95,19,2,12)
   circfill(98,22,2,12)
   --bottom left
   circfill(29,49,2,12)
   circfill(32,52,2,12)
   --bottom right
   circfill(98,49,2,12)
   circfill(95,52,2,12)
  
  --standard text
  print("pRESS ❎/🅾️ TO PLAY",26,56,1)
  print("pRESS ❎/🅾️ TO PLAY",26,55,10)
  print("bY nIALL cHANDLER",1,2,1)
  print("bY nIALL cHANDLER",1,1,7)
  print("mUSIC BY gRUBER",1,9,1)
  print("mUSIC BY gRUBER",1,8,7)

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

--clock------
 --local time
   --time
 print(""..stat(93)..":"..stat(94)..":"..stat(95),96,9,1)
 print(""..stat(93)..":"..stat(94)..":"..stat(95),96,8,7)
   --date
 print(""..stat(92).."/"..stat(91).."/"..stat(90),88,2,1)
 print(""..stat(92).."/"..stat(91).."/"..stat(90),88,1,7)
  
 if trophy==1 then
  spr(13,22,23)
  spr(13,22,32)
  spr(13,22,41)
  spr(13,98,23)
  spr(13,98,32)
  spr(13,98,41)
 end
end


-->8
--win

--activates when game is won

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

function init_win()
  _update60=update_win
  _draw=draw_win
end

function update_win()
  music(-1)

  --draw dialog
  
  dialog:update()

  if (#dialog.dialog_queue == 0) then
    run()
  end

end

function draw_win()
  cls(0)
  camera(0,0)
  
  print("★★★★★★you win★★★★★★",2,1,10)
  --print("★★★★congradulations★★★★",2,1,10)
  print("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒",0,8,7)
  
  print("final time:"..hours.."h "..minutes.."m "..seconds.."s "..milliseconds.."f",10,15,7)
--ABCDEFGHIJKLMNOPQRSTUVWXYZ
  
  print("results",50,25,7)
  --final coin count
  print("got all 12 golden gems: ",10,36,7)
  if player.coins==12 then
  print("yes",106,36,11)
  else
  print("no",106,36,8)
  end
  --final death count
  print("beaten with zero deaths:",10,42,7)
  if deaths==0 then
  print("yes",106,42,11)
  else
  print("no",106,42,8)
  end
  --speed check
  print("beaten in under 3 mins: ",10,48,7)
  if minutes<3 then
  print("yes",106,48,11)
  else
  print("no",106,48,8)
  end
  
  if player.coins==12 and deaths==0 and minutes<3 then
 --all 3 done
 --a rank
  print("a rank",52,69,10)
  spr(13,42,68)
  spr(13,77,68)
  trophy=1
  dset(0,trophy)
 --none done
 --d rank
  elseif player.coins<12 and deaths>0 and minutes>3 then
  print("d rank",52,69,8)
 --one done
 --c rank
  elseif player.coins<12 and deaths>0 and minutes<3 then
  print("c rank",52,69,9)
  spr(15,42,68)
  spr(15,77,68)
  elseif player.coins<12 and deaths==0 and minutes>3 then
  print("c rank",52,69,9)
  spr(15,42,68)
  spr(15,77,68)
  elseif player.coins==12 and deaths>0 and minutes>3 then
  print("c rank",52,69,9)
  spr(15,42,68)
  spr(15,77,68)
 --two done
 --b rank
  elseif player.coins==12 and deaths>0 and minutes<3 then
  print("b rank",52,69,6)
  spr(14,42,68)
  spr(14,77,68)
  elseif player.coins==12 and deaths==0 and minutes>3 then
  print("b rank",52,69,6)
  spr(14,42,68)
  spr(14,77,68)
  elseif player.coins<12 and deaths==0 and minutes<3 then
  print("b rank",52,69,6)
  spr(14,42,68)
  spr(14,77,68)
  end

    --draw dialog
  dialog:draw()

  --draw border
  rect(0,90,127,127,7)
end
-->8
--death

--activates when the player dies

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

function init_death()
  _update60=update_death
  _draw=draw_death
end

function update_death()
  if collide_map(player,"down",6) then
  player.death=true
  sfx()
  end
  player.sp=10
    if btnp(❎) or btnp(🅾️) then
    init_game()
      if level==1 then
        cam_x=0
        cam_y=0
        player.x=24
        player.y=104
      elseif level==2 then
        cam_x=0
        cam_y=128
        player.x=24
        player.y=232
      elseif level==3 then
        cam_x=0
        cam_y=256
        player.x=24
        player.y=360
      elseif level==4 then
        cam_x=0
        cam_y=384
        player.x=24
        player.y=488
      end
    sfx()
    end

end

function draw_death()
  cls(0)
  camera(cam_x,cam_y)
  music(-1)
  spr(player.sp,player.x,player.y,1,1,player.flp) 
  print("yOU DIED. pRESS ❎/🅾️ TO RETRY.",camera(cam_x+0),1,1)
  print("yOU DIED. pRESS ❎/🅾️ TO RETRY.",camera(cam_x+0),0,7)
end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ
-->8
--story

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

function init_story()
  _update60=update_story
  _draw=draw_story
end

function update_story()
 if btnp(🅾️) or btnp(❎) then
   init_game()
   sfx()
 end
end

function draw_story()
cls()
--title
print("story",52,1,7)
print("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒",1,8,7)
--plot
print("welcome to mellow meadow, a",1,15,7)
print("place of peace and platforming.",1,21,7)
print("you are adam apple:",1,28,7)
spr(1,76,26)
print("travel through mellow meadow,",1,35,7)
print("peachy pasture, glacial grotto",1,41,7)
print("and culminal castle; and be the",1,47,7)
print("first to get the 12 golden gems!",1,53,7)
print("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒",1,60,7)
--controls
print("controls",48,67,6)
print("⬅️     move left",20,75,6)
print("➡️     move right",20,81,6)
print("⬆️     look up",20,87,6)
print("⬇️     crouch",20,93,6)
print("❎     jump",20,100,6)
print("f6     save screenshot",20,107,6)
print("f9     save gif to desktop",20,113,6)
--continue
print("pRESS ❎/🅾️ TO CONTINUE",18,123,1)
print("pRESS ❎/🅾️ TO CONTINUE",18,122,10)
end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ
__gfx__
0000000000000000001111000011110000000000000aaa0a0aaaaaa000111100001111000000000000111100001111000000000094a77a49d567765d429ff924
000000000011110001888810018888100011110000aa00aa00aa00aa018888100188881000111100018888100187871000000000409aa90450d66d0520499402
00700700018888100187871001878710018888100aa0000a00aa00aa01878710018787100188881001788710018b8b1000111100409aa90450d66d0520499402
0007700001878710018b8b10018b8b10018787100aa0000000aa0aa0018b8b10018b8b100178781001b88b100188e81001888810249aa94215d66d5112499421
00077000018b8b100188e8100188881e018b8b100aa00aaa00aaaa00018888100188881001b8b810018ee810018888100178871002499420015dd51001244210
00700700018888100011110088111188018888100aa0000a00aa0aa00011110000111100018e8810ee1111ee0011110001b88b10002442000015510000122100
000000000011110000808000e00000000011110000aa00aa00aa0aa008808800008808800011118808800880008080000188881000499400005dd50000244200
00000000008e8e00008e8e0000000000008e8e00000aaaa00aaa00aaee0ee000000ee0ee0000e8e800000000008e8e00e811118e049aa94005d66d5002499420
000a9000000a90000009a0000009a00000a0000000000a000090009000909090090009000000900000900090909000900900090090000000aaaa0aaa000aaa0a
00a7a90000a7a900009aaa000097aa00007000000000070009090909990990999090909009090090090909099099990990909090009009090aa000a000aa00aa
0a77aa9000a7a900009aaa000097aa00a777a000000a777a90999999099909099999990909990909999990990909099999099999090909990aa000a00aa0000a
a7777aa90a777a900097aa0009777aa0007000000000070099a999999999f99a99999a9999909999999999a9f99a99999a999999999999900aaaaaa00aa00000
9aa7999209a79920002aa9000297aa9000a00a0000a00a009afa9f9a9a9ff9a9a9f9afa99a9999f99f9a9afaf9a99a9fafa9a9f999f99a990aa000a00aa00000
09aa9920009a92000029a9000029a9000000a7a00a7a0000fa999fa9f9a999999af999af9afaf99a9fa9fa999999f9a999af9af9f99a9afa0aa000a00aa0000a
009a9200009a92000029a9000029a90000000a0000a00000faaaafaaf9aafa99aafaaaaf9faa99aaafaafaaafa99f9aaaaafaafa99aa9faa0aa000a000aa00aa
000920000009200000029000000290000000000000000000af9af99999afaa9f999fa9faaa99aaf9f999af9aaa9f99afa9fa999faaf9aa990aaa0aaa000aaaa0
aa00aaaa0aaaaaaa0aaaa000000aaa00aaaa0aaa000aa0000aaaaa00aaaa0aaa0aaa00aa0aaaaaa000aaaa000000aaaaaaaaaaaaaa000aaa00000aa00000aa00
0a000aa000aa000a00aa000000aa0aa00aa000a000aaa00000aa0aa00aa000a000aa00a000aa00aa000aa00000000aa0a00aa00a0aa000a00000aaa0000aa000
0aa0aaa000aa0a0000aa00000aa000aa0aa0a0a000a0aa0000aa00aa0aa000a0000aaa0000aa00aa000aa00000000aa0a00aa00a0aaa00a00000aaa000000000
0aaaaaa000aaaa0000aa00000aa000aa0aa0a0a000a0aa0000aa00aa0aa000a0000aa00000aaaaa0000aa00000000aa0000aa0000aaaa0a0000aaa000aaaaaaa
0a0a0aa000aa0a0000aa00000aa000aa0aa0a0a00a00aa0000aa00aa0aa000a00000aa0000aa00aa000aa00000000aa0000aa0000a0aaaa0000aa00000aa0000
0a0a0aa000aa000000aa000a0aa000aa00aa0a000aaaaaa000aa00aa0aa000a0000aaa0000aa00aa000aa0000aa00aa0000aa0000a00aaa00000000000aaaa00
0a000aa000aa000a00aa000a00aa0aa000aa0a000a000aa000aa0aa00aaa0aa000a00aa000aa00aa000aa0000aa00aa0000aa0000a000aa00aa0000000aa000a
aa00aaaa0aaaaaaa0aaaaaaa000aaa0000a00a00aaa0aaaa0aaaaa0000aaaa000aa00aaa0aaaaaa000aaaa0000aaaa0000aaaa00aaa000a00aa000000aaaaaaa
3b33bb3300333300007d000000d70d700d7d700011001111001011000000000000000000000000110442240004222224000000076000000066666666dddddddd
333bb333033bb3300007d7d00d70d700d7d7d7001100111000101000000001100001100001000111000440000042244000000076d600000066666666dddddddd
33bb33b333bb33330007d07d0d7d7d7d7d70d7000111111000111000011000100011110000000110000000000004400000000766dd60000066666666dddddddd
3bb33bb33bb33bb37d007d7dd70d7d7d7d7d70000100111000111000001000000001111000100000000000000000000000007666ddd6000066666666dddddddd
3b33bb333b33bb3307d07d7dd7d7d7d77d7d700d0100001000011000000000000000111001110000000000000000000000076666dddd600066666666dddddddd
333bb333333bb333007d7d07d7d7d7d7d70d7dd70011111000010000000011001100000000110000000000000000000000766666ddddd60066666666dddddddd
33bb33b333bb33b3007d07d7d7d7d7d7d7d70d700110011000000000110001001110000000010010000000000000000007666666dddddd6066666666dddddddd
3bb33bb33bb33bb30007d7d7d7d7d7d7d7d7d7000111110000000000010000000110000000000000000000000000000076666666ddddddd666666666dddddddd
000bbbbbbbbbbbbbbbbbb00044444424444444240777777777777777777777707777777700000000000444444444444444444000000000002222222201111111
0bbbbbbbbbbbbbbbbbbbbbb04444444444444444777777777777777777777777777777770000000004442244242442442424444000000000222222221dd77dd7
bbbb3bb3bb3b3bb3bbb3bbbb4424442224244444777cc7cc777cc7cc777cc777777cc7cc000000004444a24492244224942442440000e0002211111115566556
bbb33b33b3333b33b3b33bbb444442333224442477cc7cc777cc7cc777cc7c7777cc7cc7000000004442aa422a942a9224a42a44008e820022111111177dd77d
bbb3b3333323b333333b3bbb4444233b3332444477c7cc777cc7cc777cc7cc777cc7cc77000000004249aa422aa2aaa224a2aa44e7e888e02222222216655665
bb3b3322224333222233b3bb444233bb3b332444777cc777cc7cc777cc7cc777cc7cc777000000004a4aaa299aaaaaa994aaaa2408e78e80222222221dd77dd7
bbb332244442224444233bbb44423bbbbbb3324477cc777cc7cc777cc7cc77777777777700077000492aa992299aa992229aa9940888e8201111221115566556
bbbb3244444244444423bbbb242333bbbbbb324477c777cc7cc777cc7cc7777777777777007777704229922aa229922aa2299224028888001111221101111111
bb33322411111111442333bb4423bbbbbb33324477777cc7cc777cc7cc777c77cc777c7777777cc744a99aaaaaa99aaaaaa99a44002882000004400011111111
bbb332441fffffff44233bbb44233bbbbbb324447777cc7cc777cc7cc777cc77c777cc777777cc7c4242299aa992299aa992294400030000004444007dd77dd7
bbbb33241f4444444233bbbb442233b3bb332444777cc7cc777cc7cc777cc777777cc7cc777cc7cc424aa229922aa229922aa22403b300004424424465566556
bb33b3241f444444423b33bb44442333b332442477cc7cc777cc7cc777cc7c7777cc7cc777cc7cc74a24aaa22aaaaaa22aaaaaa43b3533b024942944d77dd77d
bbb333241111111142333bbb444442233324444477c7cc777cc7cc777cc7cc777cc7cc777cc7cc774aa4aaa22aaaaaa22aaaaa443303bb3b0212912456655665
bb332244ffff1fff442233bb4442444222424444777cc777cc7cc777cc7cc777cc7cc777cc7cc77744a2aaa99aaaaaa99aaaaa4430050bb3000110027dd77dd7
bbb3324444441f4444233bbb444442444444424477cc777cc7cc777cc7cc77777777777777777777424aa992299aa992299aa4240005000b0000000065566556
bbbb324444441f442423bbbb244444442444444477c777cc7cc777cc7cc7777777777777777777774249922aa229922aa2299424000300000000000011111111
bb33322444444424442333bb000440000007600077777cc7cc777cc7cc777c7742222224222444244a249aaaaaa99aaaaaa942a4001111002444444211111110
bbb332444422244444233bbb00499400000760007777cc7cc777cc7cc777cc7724442442444424444494299aa992299aa992499411111111411aa1147dd77dd1
bbbb3322223334222233bbbb4497494400766500777cc7cc777cc7cc777cc77722244442422444224242a229922aa229922422440077770041aaaa1465566551
bbbbb333333b3233333b33bb119419110076650077cc7cc777cc7cc777cc7c7724444224244422244a4aaaa22aaaaaa22aa4aa44071717d04aaaaaa4d77dd771
bbbb333b33b3333b3333bbbb0019910007666d5077c7cc777cc7cc777cc7cc7742424444242244444a4aaaa22aaaaaa22aa2aa24079977d0499aa99456655661
bbbbb3bb3bb3b3bb3bbbbbbb0001100007666d50777cc777cc7cc777cc7cc77742222422424244244a2aaaa99aaaaaa99aaaaaa4999971d0411aa1147dd77dd1
0bbbbbbbbbbbbbbbbbbbbbb0000000007666ddd57777777777777777777777774444424444244242044aa992299aa992299aa440071116d04119911465566551
000bbbbbbbbbbbbbbbbbb00000000000766dddd5077777777777777777777770242424442422244200044444444444444444400000dddd002444444211111110
000000000000077700777700000a0000007eee0000b30000003b03b003b3b000442424244424422400000000444444440000000000777700777cc77700007000
00777700000777777777777000a9a0000eeee7e0000b3b3003b03b003b3b3b0044422444424424240000000044244242000000000771776077cc77c700077700
0777776007777777777777760a949a00eee7eeee000b30b303b3b3b3b3b03b0042242444242444220000000042244229000000007777776d07c77c700077c700
6777776d777777777777776d00a9a0007eeeeee7b300b3b33b03b3b3b3b3b0002444422244444224000000002aa24aa2000000007771776d0777cc70007cc700
d677776d67777777777766d0000a0000888888880b30b3b33b3b3b3bb3b3b0032444442424424444000000002aaa2aa2000000007777776d007cc70007cc7770
0d6666d0d66677667766dd00b30303b00022220000b3b30b3b3b3b3b3b03b33b4242442442224424000440009aaaaaa9000000007771776d007c770007c77c70
00dddd000ddd66dd66dd00000b333b0000eeee0000b30b3b3b3b3b3b3b3b03b0424442244442224400422440299aa99200044000066666d0007770007c77cc77
000000000000dd00dd00000000bbb00000eeee00000b3b3b3b3b3b3b3b3b3b00242422422424244204222224444444440442240000dddd0000070000777cc777
66666666666666666666666666666666666666666666666666666665656565656565656565656565656565656565656565656565656565656565656565666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666565666666666666666666666666666666666666
e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e755656565656565666666666666666666666666666666666666666666666666666676e7e7e7
e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e75575006363535353636300000053535353008300
000000000000830000009300000000000000000000930000000083566666656566766363e7e7e7e7635363e7e7e763535363e7e7e70063630000009300000000
00000000830000000000000000000000000000000000000000007300000000000093000000830000000000005575930000636363000000930063636363000093
00930000730000000000000000000083000073000000009300000000930055750000000000830093006300000000006363000000009300000073000000000000
93000000000093000000000000830073000000009300000000000000009300000000000000000000009300735575002343000000234373000000000000730000
0000830000000000930000007300000093000000d600830000000054743656769300000000007300000000009300000000007300000000002343002343830000
00000000000000007300009300000000009300000000000000830000000000730000000000000000000000005676365474000093547400008300000000000073
0000000000000073000000000000000000940000d7009494730000557573000000007300e5e5e5e5e500e5e5e5e5e50000e5e5e5e5e583005474365474000000
00000073000000000000000000000000000000830073009300000093000000000000009300007300000000008300005575730000557500d6000000000000d600
73234300930000949400008300234300546464646464646474000055750000000000009300000000009300000000730000000000000000005575005575000073
0000000000009300008300000000f7f70000000000f7f700000000000094009483f79400f7f70000f7f7f7000094935575008300557500d700f4f5f5f600d700
935474000000546464740000005474735565666666666666769300557500009300830094f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f75575935575000000
00000000000000000000000000006464000073000064640000000000546464646464646464646464646464646464646575000000556564646464646464646464
735575f7f7f755656575f7f7f75575005575e7e7e7e7e7e70000005575e600000000546484848484848484848484848484848484848484849576005575000000
00830000930073000000000093006565000000000065650000009300556565656566666666666666666666666565656575007300556565656565656565656565
005685848484656565658484849576735575000000930000830073557500007300005575e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7730000005575007300
00000000000000f7f7000000000065659300000093656500730000005565656575e7e7e7e7e7e7e7e7e7e7e75565656575000000556565656565656565656565
7300635353635565657563536353000055750000739400000094235575008300009355759300000093000000730000930000000000000000d683005575000000
00000000000000646400830000006565000000000065650000000000556565657500000000000000000000005565656575e60093556565656565656565656565
0000006363005565657500630063000055759383546484848484849576000000830056760000830000009300000000000000730000000000d700e65575e60000
f7f70000e6000065650000e6007365650000e6000065650000e60083566666667600000093000083000073005666666676000083556565656565656565656565
00008300009355656575930083000000557500005676e7e7e7e7e7e7000093000000000073000000000000000000930000000000830093546464646575000000
64649300008300656500000000006565000000930065650000e7000000e7e7e700007300000000000000000000e7e7e700000000556565656565656565656565
e60094009323556565750000000093e6557500000000000073000000007300000000930000009300730000000000000000930000000000556565656575009300
6565000000000065650093000000656583000000006565439300000073000000008300000000d600009300000000009373000000556565656565656565656565
64646464646465656565740000005464657500009483949400234393009400e60094008323334300009400930000839400000000009423556565656575f7f7f7
6565f7f7f7f7f76565f7f7f7f7f76565f7f7f7f7f76565644300000000009394000000e6e694d700e6e6009483233343940000e6556565656565656565656565
6565656565656565656575f7f7f755656575e65464646464646464646464646464646464646474e654646474e6e6546474e6e6e6546464656565656565646464
65656464646464656564646464646565646464646465656564646464646464646464646464646464646464646464646464646464656565656565656565656565
00000000000000000017270000000000000000000000000000151515151515151515151515151515151515151515151515151515151515151500000000004600
46004600460046004600460046004600460046004600460046004600460046004600000000000000070000000000000000000000000000000000070000000000
00000000000000000000000000000000000007000000000000e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41500001727001500
15001500150015001500150015001500150015001500150015001500150015001500000000000000000000000000000000000000000007000000000000000000
00172700000000000000000000000000000000000000070000e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41500000000001546
15461546154615461546154615461546154615461546154615461546154615461500000000000000000000001727000000000000000000000000000000172700
00000000000000000000000000172700000000000000000000e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41500460046001515
15151515151515151515151515151515151515151515151515151515151515151500000000070000000000000000000000001727000000000000000000000000
0000000000000000070000000000000000000000000000000015e415e415e415e415e415e4e4e415151515e4e41515e4e46464e4e415e4e415001500150015e7
e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e715e4e4e4e4e4e4e4e415150000000000000000000007000000d4d4d4d4d4d4d4d4d4d4d4d4d400000000
000700000000000000000000000000000007000000000000001546154615461546154615e4e4e4151515154646151546466565464615e4e415461546154615e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e4e4e4e4e4e4e4151500000000000017270000000000d4d5d5d5d5d5d5d5d5d5d5d5d5d5f4f5f5f6
000000000017270000000000000000000000000000000000001515151515151515151515e4e4e4151515151515151515151515151515e4e415151515151515e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e4e415e5e5e5e41515000700000000000000000000d4d50414141414141414141414141414141414
00000000000000000000000700000000000000172700000000e7e7e7e7e7e7e7e7e7e7e7e4e4e41515e715e4e4e4e4e4e4e4e4e4e415e4e415e4e4e4e4e4e4e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e4e4e415150000000000000000000000d4d5044534161616161616161616161616161644
00000007000000000000000000000000000000000000000000e4e4e4e4e4e4e4e4e4e4e4e4e4e41515e415e4e4e4e4e4e4e4e4e4e415e4e415e4e4e4e4e4e4e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e4e4e4151500001727000000000700d4d504458725000000000000000000000000000005
000000c3d30000000000000000000007000000000000000700e4e4e4e4e4e4e4e4e4e4e4e4e4e61515e4e4e4e4e4e4e4e4e4e4e4e415e4e415e4e4e4e4e4e4e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e4e4e41515000000000000000000d4d50445968625004142122222006232d212e2510005
c3d3c3e3f3d300172700000000000000000000000000000000e4e4e4e4e4e4e4e4e4e4e41515151515e4e5e5e5e4e5e5e4e4e4e5e415e4e415e4e4e4e4e4e4e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e615e4e4e44615150000000000000000d4d5044587978725000000000000000000000000000005
e3f3e3e3f3f3d3000000c3d300000000000000000000000000e4e4e4e4e4e4e4e4e4e4e415e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e415e4e415e4e4e4e41515e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41515151515e4e4e415151500000000000000d4d504459686968625000000000000474700000000000005
e3f3e3e3f3f3f3d300c3e3f3d3000000000000000000000000e4e4e4e4e4e4e4e4e4e4e415e4e4e4e4e4e4e4e446e4e4e4e4e4e4e415e4e415e4e4e4e41515e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41515151515e4e4e4e4e4e4000000000000d4d50445879787978725d3000000004713134700000000c305
e3f3e3e3f3f3f315151515f3f3d336363600c3d33636c3d300151515e4e4e4153615151515e4e41515e4e4e4e415e4e446e4e4e4e415e4e415e4e415151515e4
e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e41515151515e4e4e4e4e4e4000000000000d5044596869686968625f3d300004713030313470000c3e305
1515151515151515151515f3f3f3d30000c3e3f3d3c3e3f3d3151515e4e4e415e4e4e4e4e4e4e41515e6e4e4e415151515e4e4e4e4e4e4e4e4e4e415151515e4
e4e4e4e6e4e4e4e4e4e4e6e4e4e4e4e4e4e6e4e4e4e4151515151546151515151536363636363604458797879787978725f3f3d34713030303031347c3e3e305
1515151515151515151515f3f3f3f3d3c3e3e3f3f3e3e3f3f3151515464646151515151515151515151515151515151515151515151515151515151515151546
46464646464646464646464646464646464646464646151515151515151515151500000000000005968696869686968635141414141414141414141414141445
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc111111111111111111111111111111111111111111111111111111111111cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc1111111111111111111111111111111111111111111111111111111111111111cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc11111111aa11aaaa1aaaaaaa1aaaa1111aaaa111111aaa11aaaa1aaa11111111cccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a111111a111aa111aa111a11aa111111aa111111aa1aa11aa111a111111a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1117111111aa1aaa111aa1a1111aa111111aa11111aa111aa1aa1a1a1111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1a777a1111aaaaaa111aaaa1111aa111111aa11111aa111aa1aa1a1a1111a777a1ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1117111111a1a1aa111aa1a1111aa111111aa11111aa111aa1aa1a1a1111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a11a111a1a1aa111aa111111aa111a11aa111a1aa111aa11aa1a1111a11a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc11111a7a11a111aa111aa111a11aa111a11aa111a11aa1aa111aa1a111a7a11111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111111a11aa11aaaa1aaaaaaa1aaaaaaa1aaaaaaa111aaa1111a11a1111a111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111111111111111111111111111111111111111111111111111111111111111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111111111aa11aaaa1aaaaaaa111aa1111aaaaa11111aaa11aaaa1aaa111111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a111111a111aa111aa111a11aaa11111aa1aa111aa1aa11aa111a111111a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1117111111aa1aaa111aa1a1111a1aa1111aa11aa1aa111aa1aa1a1a1111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1a777a1111aaaaaa111aaaa1111a1aa1111aa11aa1aa111aa1aa1a1a1111a777a1ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1117111111a1a1aa111aa1a111a11aa1111aa11aa1aa111aa1aa1a1a1111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a11a111a1a1aa111aa11111aaaaaa111aa11aa1aa111aa11aa1a1111a11a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc11111a7a11a111aa111aa111a1a111aa111aa1aa111aa1aa111aa1a111a7a11111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111111a11aa11aaaa1aaaaaaaaaa1aaaa1aaaaa11111aaa1111a11a1111a111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111111111111111111111111111111111111111111111111111111111111111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1111111111aaaaa111aaaaaaa1aaaa111aaaa1aaa1aaa11aa1aaaaaaa111111111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a1111111aa1aa111aa111a11aa11111aa111a111aa11a111aa111a11111a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc11171111111aa11aa11aa1a1111aa11111aa111a1111aaa1111aa1a11111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc1a777a11111aa11aa11aaaa1111aa11111aa111a1111aa11111aaaa11111a777a1ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc11171111111aa11aa11aa1a1111aa11111aa111a11111aa1111aa1a11111117111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc111a11a1111aa11aa11aa111111aa111a1aa111a1111aaa1111aa111111a11a111ccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccc11111a7a111aa1aa111aa111a11aa111a1aaa1aa111a11aa111aa111a1a7a11111ccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc11111a111aaaaa111aaaaaaa1aaaaaaa11aaaa111aa11aaa1aaaaaaa11a11111cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccc1111111111111111111111111111111111111111111111111111111111111111cccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccc111111111111111111111111111111111111111111111111111111111111cccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
33b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b333b3
3b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3b33b3
3bb33b33b333b3bb33333bb33b33b333b3bb33333bb33b33b333b3bb33333bb33b33bb33b33b333b3bb33b33bb33b33b333b3bb33b33bb33b33b333b3bb33b33
3bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb333bb
333333333333bbbbb333333333333333bbbbb333333333333333bbbbb333333333333333bbbbb333333333333333bbbbb333333333333333bbbbb33333333333
333bbbbb333333bbb33333333bbbbbb33333bbb333333333bbbbb333333bbb33333333bbbbbb33333bbb333333333bbbbb333333bbb33333333bbbbbb33333bb
333bbbbbbb333333bbbbbbb333333bbbbbbb333333bbbbbb3333333bbbbbb3333333bbbbbb3333333bbbbbb333333bbbbbbb333333bbbbbbb333333bbbbbbb33
3333333333333333bbbbbbb33333333333333333333333bbbbbbb33333333333333333333333bbbbbbb33333333333333333333333bbbbbbb333333333333333
3bbbbbbbbb333333333bbbbb3333333333333bbbbbbbbb333333333bbbbb33333333333333bbbbbbbbb333333333bbbb33333333333333bbbbbbbbb333333333
3bbbbbbbbbb33333333333333333333333333333bbbbbbbbbb33333333333333333333333333333bbbbbbbbbb33333333333333333333333333333bbbbbbbbbb
3bbbbbbbbbb3333333333333333bbbbbb3333333333bbbbbbbbbbb3333333333333333bbbbb33333333333bbbbbbbbbb3333333333333333bbbbbb3333333333
333333bbbbbb33333333333333333bbbbbbbbbbbb333333333333bbbbbb33333333333333333bbbbbbbbbbbb333333333333bbbbb333333333333333333bbbbb
33333333333333333333333333333333bbbbbbbbbbbbb333333333333333333333333333333333333333bbbbbbbbbbbbb3333333333333333333333333333333
333333333333333333333333333333bbbbbbbbbbbbbb33333333333333333333333333333333333333333bbbbbbbbbbbbbb33333333333333333333333333333
3333333333333bbbbbbb333333333333333bbbbbbbbbbbbbbb3333333333333333333333bbbbbbb333333333333333bbbbbbbbbbbbbbb3333333333333333333
333333333bbbbbbbb3333333333333333bbbbbbbbbbbbbbbb33333333333333333333333bbbbbbbb3333333333333333bbbbbbbbbbbbbbbb3333333333333333
33333bbbbbbbbbbbbbbbbb33333333333333333bbbbbbbbbbbbbbbbb33333333333333333bbbbbbbbbbbbbbbbb33333333333333333bbbbbbbbbbbbbbbbb3333
33bbbbbbbbbbbbbbbbbb333333333333333333bbbbbbbbbbbbbbbbbb33333333333333333bbbbbbbbbbbbbbbbbb333333333333333333bbbbbbbbbbbbbbbbbb3
33333333bbbbbbbbbbbbbbbbbbb3333333333333333333bbbbbbbbb3333333333333333333333333333bbbbbbbbbbbbbbbbbbb3333333333333333333bbbbbbb
33333bbbbbbbbbbbbbbbbbbbb33333333333333333333bbbbbbbbbb33333333333333333333333333333bbbbbbbbbbbbbbbbbbbb33333333333333333333bbbb
3bbbbbbbbbbbbbbbbbbbbb333333333333333333333bbbbbbbbbbb33333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbb333333333333333333333
3333333333bbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbb333333333
3333333bbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbb333333
33333bbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbb3333
33bbbbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbb3
3333333333333bbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333bbbbbbbbbbbbb33333333333333333333333333bbbbbbbbbbbb
33333333333bbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333bbbbbbbbbbbbb333333333333333333333333333bbbbbbbbbb
333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333bbbbbbbbbbbbbb3333333333333333333333333333bbbbbbbb
333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333bbbbbbbbbbbbbbb33333333333333333333333333333bbbbb
33333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333bbbbbbbbbbbbbbb333333333333333333333333333333bbbb
333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333bbbbbbbbbbbbbbb3333333333333333333333333333333bb
3bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbb33333333333333333333333333333333
333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333
33333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333
333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333
33333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333
333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333
33333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333
333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333
33333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333
333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33
33bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3
3333333333333333333333bbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbbb
333333333333333333333bbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbbbb
3333333333333333333bbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbb
3333333333333333333bbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbbb
333333333333333333bbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbbb
33333333333333333bbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbbbb
333333333333333bbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbb
333333333333333bbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbbb
33333333333333bbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbbb
3333333333333bbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbbbb
33333333333bbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbb
33333333333bbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbbb
3333333333bbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbbbb
33333333bbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbbb
3333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbbb
333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333bbbbb
33333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333bbbb
3333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333bbb
333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333bb
33bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333b
3bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333

__gff__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030303030307070707000b0b0b000083030303030307070707070b0b0b000983030303014307070703030b0b0b00138300000000000000000303000b00004243
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3000000000000000000000000000000000007172000000000000000000000000007576773175767700505200007000000000000000005052000000000000000000700000000000000000000000000000717200000000000000000000000000000071720000000070000000000000000000000000000000000000000000000000
30770000000071720000000000000000000000000000000000000000000000004041414141414141415452000000000000700000000050520000717200000000000000000000000000000000000000000000000000007000000000000000700000000000007a0000000000000000000000000000000000000000000071720000
4142000000000000000000000071720000000000000070000000000000000000506869686968696869685200004042000000404200005052000000000000006d0000000000000000000071720000000000000000000000000000000000000000007c00004a4b4c00004a4c000000000000007172000000000000000000000000
7952000000000000000070000000000000000000000000000000004d00717200507879787978797879785200005052000000505200005052000000000000007d00323334000000004900000000323400000000004932340000004a4c5e4a4c004a4b4c005a5b5c00005a5c000000717200000000000000007000000000007000
6952000070000000000000000000757677000000007374000000005d00000000504361616161616161616200635052000000505263006062000000000000454646464646470000454647000000454700000000454646470000005a5c645a5c645a5b5c645a5b5c64645a5c000000000000000000000000000000000000000000
7952000000000000000000000040414141420000404141420000404142000000505200000000000000000000005052000000505200000000000000000000555656565656576464555657646464555764646464555656570000006a6b7b6b6b7b6b6b6b7b6b6b6b7b7b6b6c000000000000000000007172000031000000003100
69520000000000000000000000506968695264645043445264645069520000005052007172000000007576777350526464645052737576770000000000636566666666665848485966584848485958484848485966666700000000003a000000003a0000003b0000003a00000000000070000000000000000030007172003000
7952636363636363636363636350797879534141545354534141547952000000505200000000000000404141415453414141545341414142000000000000000000000000000000000000000000000000000000000000000000000000007172000000000000000000000070004d4d000000000000000000000030000000003000
6952004d00000000000000000050696869686968694361616161616162000063505200006363636363506968696869686968696869686952000000000000000000717200000000000000007000000000000000000000000070000000000000000000000070000000000000005d5d0000000000000000000075304f5f5f6f3077
7952005d00000000717200000050797879787978795200000000000000000000505200000000000000606161616161616161616161614452630071720000000000000000000000000000000000000000000071720000000000000000000000000070000000000000000000004042636363636363636363634041414141414141
695341414200000000000000005069686968696869520070000000000000000050520000000070000000000000000000000000000000505200000000000000000000000000007000000000000000000000000000006d000000000070000000000000000000007172000000005052000000000000000000006061616161616161
794361616200000000000000005079787978797879520000006363636363636350526363003100000000000000000000000000003100505200000032333400490000000000490000000049000000003234000000007d00000000000000000000000000000000000000000000505200007172003c3d0000000000000000000000
6952000000000000007576770050696869686968695200000000000000000000606200000030317576767700007475777400000030755052000045464646464647000045464647000045464700000045470000004546470000004a4c5e4a4c00007c0000007a00000000004054523c3d00003c3e3f3d7000000000003c3d0000
7952000000000000404141414154797879787978795200404200000000000000000000000030304041414200004041414200004041415452636355565656565657636355565657000055565700000055570000005556576363635a5c005a5c004a4b4c004a4b4c00004a4c5068523e3f3d3c3e3e3f3f3d3c3d71723c3e3f3d00
6952636363636363506869686968696869686968695264505277007473737400757677004041415479785264645043445264645069686952646455565656565657646455565657646455565764646455576464645556570031005a5c005a5c005a5b5c005a5b5c00005a5c5078523e3f3f3e3e3e3f3f3f3e3f3d3c3e3e3f3f3d
7952000000000000507879787978797879787978795341545341414141414141414141415468696869685341415453545341415479787953414155565656565656464656565656464656565646464656564646465656573130315a5c645a5c645a5b5c645a5b5c64645a5c5068523e3f3f3e3e3e3f3f3f3e3f3f3e3e3e3f3f3f
000000000000000000000000000050520000000000000000000000000000000000000000000000000000000000000000000000555700000000000000000000000000000000000000000000000000000000000000000000000000006a6b6b6b5b5b5b5b6b6b6b6b6b6b6b6b6b6b6c000000000000000000000000000000000000
00000000000000000000000000005052003233340000000000000000000000000000000000000032333400000000000000000055570000000000000000000000000000000000000000000000000000000000000000000000000000003b3a005a4b4b5c3b003a00003b00003a3b00000000000000000000323400007000323400
0000000000700000000000000000505245464646475e5e00005e5e00005e5e00005e5e00005e5e4546470000000000000000005557000000700000000000000000000070004a4c0000000000007172000000000000000000000000700000005a5b6b6c6363636363636363636363636e00000000000000454700000000454700
00000000000000000000007172005052555656565764646464646464646464646464646464646455565700000075767677000055575e5e0000005e5e5e00005e5e000000005a5c0000000000000000000000700000000000000000000000005a5c3a000000000000000000000000000000000071720000555700000000555700
4d0000004d0000004d0000000000505265666666584848484848484848484848484848484848485966670000004041414200005557000000000000000000000000006363005a5c0000717200000000000000000000000000000000000000005a5c00000000007000000000000000000000000000000000555700000000555700
5d7576775d0000005d0000000000505200000000000000000000000000000000000000000000000000000000005079785200005557000000000070000000000000000000005a5c00000000000000000000000000000000717200004a4c00005a5c00000000000000000000000000000000000000000000555700717200555700
414141414200000040425e5e5e00505200700000000000000000000000000071720000000000000000000000005069685263005557000000000000000000717200000000005a5c00000000700000000000000000000000000000005a5c00005a5c0000006e00005e5e5e00005e5e000000000000000000555700000000555700
6968696852636363505200000000505200000000000000717200000000000000000000000000000000700000005079785200005557000070000000000000000000000000005a5c00000000000000007172000000000000000000005a5c00005a5c00000000000000000000000000005e5e000000000000555700000000555700
79787978520000005052000000005052000000000000000000003100000000000000000070000000000000000050696852000055570000006d0000000000000000007000005a5c00000000000000000000000000000000000000005a5c00005a5c00007000000000000000000000000000005e5e5e000055570000000055576e
69686968520000005052000000005052000071720000000000313000000000000000000000000000000000000050797852000065670000007d0000007a00000000000000005a5c00000000000000000000000000700000000000005a5c00006a6c00000000000000007172000000000000000000000000555700000000555700
79436161620000005052000000645052000000000000000075303077000000000000000000000000000000736e506968520000000000004546475e4a4b4c00004a4c00006e5a5c6e000000006e00000000006e000000000000006e5a5c6e00000000007c7a007a007c000000000000000000000000000055570000000055573d
695200000000000050520000404154520000000000000000404141420000005e5e5e005e5e5e005e5e0040414154797852000000000000555657005a5b5c00005a5c0000005a5c00000000000000700000000000000000000000005a5c636363634a4b4b4b4b4b4b4b4c00005e5e00005e5e0000630000555700003c3d55573f
7952004d0031003150520000606161620000000000007000506869520000000000000000000000000000506869686968526e0000490032555657006a6b6c00006a6c3100006a6c00700000000000000000000000000000000000005a5c000000005a5b5b4b4b4b5b5b5c000000000000000000000000005557003c3e3f55573f
6952775d75306e3050520000000000000000000000000000507879520000000000000000000000000000507879787978526363454646465656570000000031000000304d31000000007c7a000000000000000000000000000000005a5c000000005a4b5b5b4b5b4b4b5c0000000000000000700000000055573c3e3e3f55573f
79534141414141415452770074737374006e00007a007c00506869526464646464646464646464646464506869686968520000555656565656570075767730737473305d307576774a4b4b4c005e5e5e5e5e005e5e5e5e5e5e5e005a5c000000005a5b4b4b5b5b5b4b5c00007a007c00007a7c0000000055573e3e3e3f55573f
686968696869686968534141414141414141424a4b4b4b4c507879534141414141414141414141414141547879787978520000555656565656576e404141414141414141414141425a5b5b5c6464646464646464646464646464645a5c000000005a4b5b5b4b4b4b5b5c6e4a4b4b4b4b4b4b4b4b4c646455575f5f5f5f55573f
__sfx__
013d00200a6100f611156111c6112c6113161131611236111b6110d6110d6110c6110b6110a621096110861107611096110b6110161106611076110f611186111c61125611256111c61116611126110d61109611
0108080a1307014070180701806018050180401803018020180141801500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010b0809245701d5701c5701c5601c5501c5401c5301c5201c5100050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500005000050000500
0120000410073110731f6351170010003110031f6051870010003110031f6051170010003110031f6051570010003110031f6051170010003110031f6052670010003110031f6051170010003110031f60500000
00100010100631e645110631a500206451f60514500125001006310605110631a5001f64500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000201b7731d7731f77321773237732577326773267732577323773217731f7731d7731b77319773197731b7731d7731f773217732377325773277732977329773277732577323773217731f7731d7731b773
00100010226450f60507645076451c645106050764507645176451764507645176451060507645076450764511605106050c60512605116051260512605126050e60511605106051160511605116051160509605
001000102b6551760017655176551f6551f65517655176551f655176551f655316551b6051765517655176551e605166051a60524605116051260512605126050c605196050f6051160511605116051160509605
001000001c6551c6551c6551c65520655226550000525655276552865528655286550000526655216551a6551765513655126551265512655126552060516655166552260517655176552360517655126550c655
001000000f05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000f0501175014050177501c050207502505027750287552800028755270002875526000250002500023000200001e0001a000180001800019000340003500037000390003900000000000000000000000
000e000005455054553f52511435111250f4350c43511125034550345511125182551b255182551d2551112501455014552025511125111252025511125202550345520255224552325522455202461d4551b255
000e00000c0530c4451112518455306251425511255054450c0530a4353f52513435306251343518435054450c053111251b4353f525306251b4353f5251b4350c0331b4451d2451e445306251d2451844516245
000e00000145520255224552325522445202551d45503455034050345503455182551b455182551d455111250045520255224552325522455202461d4551b255014550145511125182551b455182551d45511125
000e00000c0531b4451d2451e445306251d245184450c05317200131253f52513435306251343518435014450c0431b4451d2451e445306251d245184451624511125111253f5251343530625134351843500455
000e0000004550045520455111251d125204551d1252912501455014552c455111251d1252c4551d12529125034552c2552e4552f2552e4552c2552945503455044552c2552e4552f2552e4552c246294551b221
000400000e55327553275532755327553275532754327543275432753327533275332752327523275232751327513275132750327503275032750327503275032750327503275032750327503005030050300503
000e00000c0530c0531b4551b225306251b4551b2250f4250c0530c05327455272253062527455272251b4250c0531b4451d2451e445306251d245184450c0530c0531b4451d2451e445306251d2451844500455
013800200a6100f611156111c6112c6113161131611236111b6110d6110d6110c6110b6110a621096110861107611096110b6110161106611076110f611186111e61120611256111c61116611126110d61109611
003800201b6110d6110d6110c6110b6110a62109611086111b6000d6000d6000c6000b6000a600096000860007600096000b6000160006600076000f600186001c60025600256001c60016600126000d60009600
0038002007611096110b6110161106611076110f611186111b6000d6000d6000c6000b6000a600096000860007600096000b6000160006600076000f600186001c60025600256001c60016600126000d60009600
013800201e61120611256111c61116611126110d611096111b6000d6000d6000c6000b6000a600096000860007600096000b6000160006600076000f600186001c60025600256001c60016600126000d60009600
000100001e0601e0601e0601e0601e0602206022060230602306024060240602506025060260602706028060290652a0652b0602c0402d0402e0302f035310253202533015000000000000000000000000000000
010c00000265301643016030860307603066030660305600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000200002607026070260702607030070300703006030060300603005030050300503004030040300403003030030300303003030030300203002030020300103001030010270002700027000160001600016000
01780000269542694026930185351870007525075240752507534000002495424940249301d5241d7000c5250c5242952500000000002b525000001d5241d5250a5440a5450a5440a5201a7341a7350a0350a024
017800000072400735007440075500744007350072400715007340072500000057440575505744057350572405735057440575503744037350372403735037440375503744037350372403735037440373503704
017800000a0041f734219442194224a5424a5224a45265351a5341a5350000026934269421ba541ba501ba550c5340c5450c5540c555000001f9541f9501f955225251f5341f52522a2022a3222a452b7342b725
__music__
01 03434344
00 03044344
01 03040644
00 03040506
00 08030445
00 03040845
00 03040507
02 03040607
01 0b0c5244
00 0b0c5344
00 0b0c5444
00 0b0c5544
00 0d0e5244
00 0d0e5344
02 0f115444
00 4f515544
03 12191a1b

