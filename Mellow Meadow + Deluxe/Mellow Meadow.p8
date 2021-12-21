pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
--mELLOW mEADOW
--bY nIALL cHANDLER

--dev start date: sept 2nd 2020
--release date: halloween 2020

--variables

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

--speedrun timer
  a=0
  b=18000-a
  q=0

--disables button repeat
poke(0x5f5c,255)

--plays music on startup
  music(0)

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
  x=960,
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
    
--debug--------------------
  --x1r=0 y1r=0 x2r=0 y2r=0
  --collide_l="no"
  --collide_r="no"
  --collide_u="no"
  --collide_d="no"
---------------------------
  
--toggle music in pause menu
  menuitem(1,"toggle music",
  function()
  mute_music=not mute_music
    if mute_music then
      music(-1)
    else
      music(0)
    end
  end)
  
--toggle jump btn in pause menu

  menuitem(2,"swap buttons 🅾️❎",function() ❎,🅾️=🅾️,❎ end)
function btnr(b)
return not btn(b) and f_btn[b]
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
  
  --text in the dialog box
  dialog:queue("thank you so much for playing my game! you are a super player!!")
  dialog:queue("special thanks to the following awesome people:")
  dialog:queue("miziziziz of https://bit.ly/2hl29q6, nerdy teachers of https://rb.gy/a5wyvv, freds72, pizza_boys, bonevolt, fast121, vahe2003, ultrachris64, rustybailey, pegboardnerds, thijsengel, sophie houlden, zep, and my friends & family ♥")
  dialog:queue("if it weren't for all of them, this game would never have been made.")
  dialog:queue("you can press 🅾️ to go back to the title screen.")
end

--print message in screen centre
function print_centered(str)
  print(str, 64 - (#str * 2), 60,9) 
end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ
-->8
--update and draw

function init_game()
  _update60=update_menu
  _draw=draw_menu
 function _update60()
  player_update60()
  player_animate()
  
  --timer--
  q+=1
  a+=1
  f=a%60
  m=flr(a/(60*60)%60)
  s=flr((a/60)%60)
  ms=flr(flr(a/.06)%1000)
  b-=1
  c=b%60
  d=flr((b/60)%60)

 --the time won't wrap round
  if q>32000 then
   q=32000
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

 --speedrun timer
  if level==1 then
	 print("⧗:"..b/60,camera(cam_x+0),2,0)
	 print("⧗:"..b/60,camera(cam_x+0),1,8)
	 elseif level==2 then
  print("⧗:"..b/60,camera(cam_x+0),2,0)
	 print("⧗:"..b/60,camera(cam_x+0),1,8)
	 elseif level==3 then
	 print("⧗:"..b/60,camera(cam_x+0),2,0)
	 print("⧗:"..b/60,camera(cam_x+0),1,8)
	 elseif level==4 then
	 print("⧗:"..b/60,camera(cam_x+0),2,0)
	 print("⧗:"..b/60,camera(cam_x+0),1,8)
	 end
 --frame counter
  --print("fps:"..f,camera(cam_x+0),16,1)
  --print("fps:"..f,camera(cam_x+0),15,7)
 
 --coin count 
  if level==1 then		
  print("◆:"..player.coins.."/12",camera(cam_x+0),9,0)
  print("◆:"..player.coins.."/12",camera(cam_x+0),8,10)
  elseif level==2 then
  print("◆:"..player.coins.."/12",camera(cam_x+0),9,0)
  print("◆:"..player.coins.."/12",camera(cam_x+0),8,10)
  elseif level==3 then
  print("◆:"..player.coins.."/12",camera(cam_x+0),9,0)
  print("◆:"..player.coins.."/12",camera(cam_x+0),8,10)
  elseif level==4 then
  print("◆:"..player.coins.."/12",camera(cam_x+0),9,0)
  print("◆:"..player.coins.."/12",camera(cam_x+0),8,10)
  end
 --kill player if out of time
  if a==18000 then
  init_death2()
  deaths+=1
  end
  
 --level
  if level==1 then
    print("mELLOW mEADOW",camera(cam_x+0),123,0)
    print("mELLOW mEADOW",camera(cam_x+0),122,14)
  elseif level==2 then
    print("pEACHY pASTURE",camera(cam_x+0),123,0)
    print("pEACHY pASTURE",camera(cam_x+0),122,14)
  elseif level==3 then
    print("gLACIAL gROTTO",camera(cam_x+0),123,0)
    print("gLACIAL gROTTO",camera(cam_x+0),122,14)
  elseif level==4 then
    print("cULMINA cASTLE",camera(cam_x+0),123,0)
    print("cULMINA cASTLE",camera(cam_x+0),122,14)
  end
  
--ABCDEFGHIJKLMNOPQRSTUVWXYZ  
  
 --debug-------------------------------------------------------------------
 --rect(x1r,y1r,x2r,y2r,7)
 --print("jumps= "..jumps,camera(cam_x+0),14)
 --print("cpu: "..flr(stat(1)*100).."%",camera(cam_x+0),20)
 --print("target fps: "..flr(stat(8)),camera(cam_x+0),26)
 --print("pico-8 fps: "..flr(stat(9)),camera(cam_x+0),32)
 --print("mem: "..flr(stat(0)),camera(cam_x+0),38)
 --print("x pos: ".. player.x,camera(cam_x+0),44)
 --print("y pos: ".. player.y,camera(cam_x+0),50)
 --print("x tile: ".. ((player.x - (player.x % 8)) / 8),camera(cam_x+0),56)
 --print("y tile: ".. ((player.y - (player.y % 8)) / 8),camera(cam_x+0),62)
 --print("music ticks: "..flr(stat(26)),camera(cam_x+0),68)
 --print("deaths= "..deaths,camera(cam_x+0),74)
 --print("level= "..level,camera(cam_x+0),80)
 --print("q= "..q,camera(cam_x+0),86)
 --------------------------------------------------------------------------
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
    a=0
    b=18000-a
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
  if btn(⬅️) then
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
    sfx(1)
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
    sfx(0)
  end
 else
    if btnp(🅾️)
  and player.landed then
    player.dy-=player.boost
    player.landed=false
    jumps+=1
    sfx(0)
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
					sfx(2)
		end
			if coin_hitbox(coin1.x,coin1.y,coin1.w,coin1.h) then
					player.coins+=1
					coin1.x=-128
					coin1.y=-128
					sfx(2)
		end
		if coin_hitbox(coin2.x,coin2.y,coin2.w,coin2.h) then
					player.coins+=1
					coin2.x=-128
					coin2.y=-128
					sfx(2)
		end
		if coin_hitbox(coin3.x,coin3.y,coin3.w,coin3.h) then
					player.coins+=1
					coin3.x=-128
					coin3.y=-128
					sfx(2)
		end
		if coin_hitbox(coin4.x,coin4.y,coin4.w,coin4.h) then
					player.coins+=1
					coin4.x=-128
					coin4.y=-128
					sfx(2)
		end
		if coin_hitbox(coin5.x,coin5.y,coin5.w,coin5.h) then
					player.coins+=1
					coin5.x=-128
					coin5.y=-128
					sfx(2)
		end
		if coin_hitbox(coin6.x,coin6.y,coin6.w,coin6.h) then
					player.coins+=1
					coin6.x=-128
					coin6.y=-128
					sfx(2)
		end
		if coin_hitbox(coin7.x,coin7.y,coin7.w,coin7.h) then
					player.coins+=1
					coin7.x=-128
					coin7.y=-128
					sfx(2)
		end
		if coin_hitbox(coin8.x,coin8.y,coin8.w,coin8.h) then
					player.coins+=1
					coin8.x=-128
					coin8.y=-128
					sfx(2)
		end
		if coin_hitbox(coin9.x,coin9.y,coin9.w,coin9.h) then
					player.coins+=1
					coin9.x=-128
					coin9.y=-128
					sfx(2)
		end
				if coin_hitbox(coin10.x,coin10.y,coin10.w,coin10.h) then
					player.coins+=1
					coin10.x=-128
					coin10.y=-128
					sfx(2)
		end
				if coin_hitbox(coin11.x,coin11.y,coin11.w,coin11.h) then
					player.coins+=1
					coin11.x=-128
					coin11.y=-128
					sfx(2)
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
      
    ----debug----------
    --collide_d="yes"
    --else collide_d="no"
    -------------------
    end
  elseif player.dy<0 then
    player.jumping=true
    if collide_map(player,"up",1) then
      player.dy=0
      
      ----debug----------
      --collide_u="yes"
      --else collide_u="no"
      -------------------
    end
  end
  
  --check collision left and right
  if player.dx<0 then
  
    player.dx=limit_speed(player.dx,player.max_dx)
  
    if collide_map(player,"left",1) then
      player.dx=0
      
      ----debug----------
      --collide_l="yes"
      --else collide_l="no"
      -------------------
    end
  elseif player.dx>0 then
  
    player.dx=limit_speed(player.dx,player.max_dx)
  
    if collide_map(player,"right",1) then
      player.dx=0
      
      ----debug----------
      --collide_r="yes"
      --else collide_r="no"
      -------------------
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
      if player.sp>6 then
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
  poke(0x5f38,2)
  poke(0x5f39,2)
end

  local dz,dy=0,0
  local cx,cy,cz=0,0,0
  local angle=0

function update_menu()
 if btnp(🅾️) or btnp(❎) then
   init_game()
   sfx()
 end
  
  --timer--
  a+=0
  f=a%60
  m=flr(a/(60*60)%60)
  s=flr((a/60)%60)
  ms=flr(flr(a/.06)%1000)
  
 if(btn(⬆️)) dz-=1/64
 if(btn(⬇️)) dz+=1/64
 
 if(btn(⬅️)) angle-=1/256
 if(btn(➡️)) angle+=1/256
 
 --if(btn(❎)) dy=0.1
 
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

 --debug-------------------
 --print("cx/cz:"..cx.."/"..cz,1,14,7)
 --print("cz:"..cz,1,20,7)
 --print("cy:"..cy,1,26,7)
 --------------------------
 
 --text
  --mellow
    --top layer
  spr(32,28,21)
  spr(33,36,21)
  spr(34,44,21)
  spr(35,52,21)
  spr(36,60,21)
  spr(38,76,21)
  spr(39,84,21)
  spr(40,92,21)
    --bottom layer
  spr(48,28,29)
  spr(49,36,29)
  spr(50,44,29)
  spr(51,52,29)
  spr(52,60,29)
  spr(53,68,29)
  spr(54,76,29)
  spr(55,84,29)
  spr(56,92,29)
  --meadow
    --top layer
  spr(32,28,34)
  spr(33,36,34)
  spr(34,44,34)
  spr(41,52,34)
  spr(42,60,34)
  spr(43,68,34)
  spr(38,76,34)
  spr(39,84,34)
  spr(40,92,34)
    --bottom layer
  spr(48,28,42)
  spr(49,36,42)
  spr(50,44,42)
  spr(57,52,42)
  spr(58,60,42)
  spr(59,68,42)
  spr(54,76,42)
  spr(55,84,42)
  spr(56,92,42)
  
  --standard text
  print("pRESS 🅾️/❎ TO PLAY",26,56,1)
  print("pRESS 🅾️/❎ TO PLAY",26,55,7)
  print("bY nIALL cHANDLER",1,2,1)
  print("bY nIALL cHANDLER",1,1,7)
  print("mADE WITH pico-8",1,9,1)
  print("mADE WITH pico-8",1,8,7)
    --pico 8 sprite
  spr(63,65,8)

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

--clock------
 --local time
   --time
 print(""..stat(93)..":"..stat(94)..":"..stat(95),96,9,1)
 print(""..stat(93)..":"..stat(94)..":"..stat(95),96,8,7)
   --date
 print(""..stat(92).."/"..stat(91).."/"..stat(90),88,2,1)
 print(""..stat(92).."/"..stat(91).."/"..stat(90),88,1,7)
  
  --debug---------------------------------------------
  --print("cpu:"..flr(stat(1)*100).."%",camera(cam_x+0),32)
  ----------------------------------------------------
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
  --timer--
  a+=1
  f=a%60
  m=flr(a/(60*60)%60)
  s=flr((a/60)%60)
  ms=flr(flr(a/.06)%1000)
  b-=1
  c=b%60
  d=flr((b/60)%60)

  --draw dialog
  
  dialog:update()

  if (#dialog.dialog_queue == 0) then
    run()
  end

end

function draw_win()
  cls(0)
  camera(0,0)
  
  print("★★★★★★you win★★★★★★",2,0,10)
  
  print("▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒",0,8,7)
  
--ABCDEFGHIJKLMNOPQRSTUVWXYZ
  
  print("score",54,22,7)
  --final coin count
  print("collected all 12 coins: ",10,36,7)
  if player.coins==12 then
  print("yes",106,36,11)
  else
  print("no",106,36,8)
  end
  --final death count
  print("beaten with zero death: ",10,42,7)
  if deaths==0 then
  print("yes",106,42,11)
  else
  print("no",106,42,8)
  end
  --speed check
  print("beaten in under 3 mins: ",10,48,7)
  if q<10800 then
  print("yes",106,48,11)
  else
  print("no",106,48,8)
  end
  --completion
  print("final endgame ranking:",20,62,7)
  
  if player.coins==12 and deaths==0 and q<10800 then
  --all 3 done
  print("a rank",52,76,10)
  spr(20,44,75)
  spr(21,75,75)
  --none done
  elseif player.coins<12 and deaths>0 and q>10800 then
  print("d rank",52,76,8)
  --one done
  elseif player.coins<12 and deaths>0 and q<10800 then
  print("c rank",52,76,9)
  elseif player.coins<12 and deaths==0 and q>10800 then
  print("c rank",52,76,9)
  elseif player.coins==12 and deaths>0 and q>10800 then
  print("c rank",52,76,9)
  --two done
  elseif player.coins==12 and deaths>0 and q<10800 then
  print("b rank",52,76,6)
  elseif player.coins==12 and deaths==0 and q>10800 then
  print("b rank",52,76,6)
  elseif player.coins<12 and deaths==0 and q<10800 then
  print("b rank",52,76,6)
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
a=0
b=18000-a
  if collide_map(player,"down",6) then
  player.death=true
  sfx()
  end
  player.sp=10
    if btnp(🅾️) or btnp(❎) then
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
      if mute_music then
        music(-1)
      else
        music(0)
      end
    end

end

function draw_death()
  cls(0)
  camera(cam_x,cam_y)
  music(-1)
  spr(player.sp,player.x,player.y,1,1,player.flp) 
  print("yOU DIED. pRESS 🅾️/❎ TO RETRY",camera(cam_x+0),1,1)
  print("yOU DIED. pRESS 🅾️/❎ TO RETRY",camera(cam_x+0),0,7)
end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ
-->8
--out of time

--activates when out of time

--ABCDEFGHIJKLMNOPQRSTUVWXYZ

function init_death2()
  _update60=update_death2
  _draw=draw_death2
end

function update_death2()
a=0
b=18000-a
  if collide_map(player,"down",6) then
  player.death=true
  sfx()
  end
  player.sp=10
    if btnp(🅾️) or btnp(❎) then
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
      if mute_music then
        music(-1)
      else
        music(0)
      end
    end

end

function draw_death2()
  cls(0)
  camera(cam_x,cam_y)
  music(-1)
  spr(player.sp,player.x,player.y,1,1,player.flp) 
  print("tIME UP. pRESS 🅾️/❎ TO RETRY",camera(cam_x+0),1,1)
  print("tIME UP. pRESS 🅾️/❎ TO RETRY",camera(cam_x+0),0,7)
end

--ABCDEFGHIJKLMNOPQRSTUVWXYZ
-->8
--save system

--i can't code a save system 😐

__gfx__
00000000000000000011110000111100000000000011110000000000001111000011110000000000001111000011110000000000000006d00000000007878783
00000000001111000188881001888810001111000188881000111100018888100188881000111100018888100187871000000000000006d00000000007877783
0070070001888810018787100187871001888810018787100188881001878710018787100188881001788710018b8b1000111100000006d00000000007877783
0007700001878710018b8b10018b8b1001878710018b8b1001878710018b8b10018b8b100178781001b88b100188781001888810000006d00000000007777777
00077000018b8b10018878100188881e018b8b100188881e018b8b10018888100188881001b8b810018778100188881001878710000006d00777777700000000
00700700018888100011110088111188018888108811118801888810001111000011110001878810ee1111ee00111100018b8b10000006d00787778300000000
000000000011110000808000e000000000111100e000000000111100088088000088088000111188088008800080800001888810000006d00788788300000000
00000000008e8e00008e8e0000000000008e8e0000000000008e8e00ee0ee000000ee0ee0000e8e800000000008e8e0000111100000006d00788888300000000
000a9000000a90000009a0000009a00000a0000000000a0000000880000088000008800000880000088000008800000080000008000000880000000611111111
00a7a90000a7a900009aaa000097aa0000700000000007008008899800889988088998808899880089988008998800889880088988008899000007601fffffff
0a77aa9000a7a900009aaa000097aa00a777a000000a777a98899ff98899ff99899ff99899ff99889ff99889ff998899f998899f998899ff000070501f222222
a7777aa90a777a900097aa0009777aa00070000000000700f99ffaaf99ffaaff9ffaaff9ffaaff99faaff99faaff99ffaff99ffaff99ffaa000065001f222222
9aa7999209a79920002aa9000297aa9000a00a0000a00a00affaaaaaffaaaaaafaaaaaafaaaaaaffaaaaaffaaaaaffaaaaaffaaaaaffaaaa0006000011111111
09aa9920009a92000029a9000029a9000000a7a00a7a0000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa07600000ffff1fff
009a9200009a92000029a9000029a90000000a0000a00000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa7050000022221f22
000920000009200000029000000290000000000000000000aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa6500000022221f22
00000000000000000000000000000000000000007700777000000000000000000000000000000000000000000000000000000aa0111111111111111111111111
0111000111001111111100000111000000000111707007000001111110000111000111000001111100000111111100000000a79a1f171fff1794794447947474
1676101676101767777611000171000000000171707077700016777761000171000176100016777610000176777610000000a99a1f1771221494949449449494
17771017771017776677710001710000000001710000000001677616761016710001771000177677100001777677610000000aa01f1771220149449994494949
176761676710171111111100017100000000017107707070167611017710177100016710016761676100017611167610777776d0117776110144944449944944
171771771710171111111000167100000000167170707070177100016710176101001710017710177100017100017710777376d0f177761f0014499994449494
171676761710177777771000177100000000177177707077176100001710171017101710017610167100017100016710373376d0177766610001144444994949
171167611710171111111000176100000000176170707700171000016710176167616710167111017610017100016710333376d0177666610000011111111111
171011116710171000000000171000000000171000000000176100017710177176717710177776117710017100017710737376d011444411777cc77700800000
171000017710171001111110171011111110171011111110177100167610167171717610171677716710017100167610777376d01444444f77cc77c7097f0000
171000017610171116777710176167777710176167777710167611676100017671767100171111111710017111776100777376d04444944417c77c72a777e000
111000017100177777761110177777611110177777611110016777761000016761676100171000001710017177761000777776d0494994941777cc720b750000
000000011100111111110000011111100000011111100000001111110000001110111000111000001110011111110000000006d049492194117cc71100100000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006d049911924ff7c77ff00000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006d02499921222777f2200000000
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006d02211112222271f2200000000
000bbbbbbbbbbbbbbbbbb00044444424444444240007777777777777777770007777777700000000000444444444444444444000000000000009900011111111
0bbbbbbbbbbbbbbbbbbbbbb044444444444444440777777777777777777777707777777700000000044422442424424424244440000000000992299017888877
bbbb3bb3bb3b3bb3bbb3bbbb442444222424444477777117711771177117777771177117000000004444a24492244224942442440000e0009220022918877887
bbb33b33b3333b33b3b33bbb44444233322444247777cc77cc77cc77cc771177cc77cc77000000004442aa422a942a9224a42a44008e82002000000218877777
bbb3b3333323b333333b3bbb4444233b33324444777cc77cc77cc77cc77cc777c77cc77c000000004249aa422aa2aaa224a2aa44e7e888e02000000218878887
bb3b3322224333222233b3bb444233bb3b332444771c77cc77cc77cc77cc777777117711000000004a4aaa299aaaaaa994aaaa2408e78e809000000918877887
bbb332244442224444233bbb44423bbbbbb3324477177cc77cc77cc77cc771777777777700077000492aa992299aa992229aa9940888e8202990099217888877
bbbb3244444244444423bbbb242333bbbbbb32447777cc77cc77cc77cc77c17777777777007777704229922aa229922aa2299224028888000229922011111111
bb33322411111111442333bb4423bbbbbb333244777cc77cc77cc77cc77cc777c77cc777777cc77c44a99aaaaaa99aaaaaa99a44002882000044440011111111
bbb332441fffffff44233bbb44233bbbbbb32444771c77cc77cc77cc77cc777777cc77c777cc77cc4242299aa992299aa9922944000300000444444077999977
bbbb33241f4444444233bbbb442233b3bb33244477177cc77cc77cc77cc771777cc77cc77cc77cc7424aa229922aa229922aa22403b300004444944479977997
bb33b3241f444444423b33bb44442333b33244247777cc77cc77cc77cc77c177cc77cc77cc77cc774a24aaa22aaaaaa22aaaaaa43b3533b04949949479977997
bbb333241111111142333bbb4444422333244444777cc77cc77cc77cc77cc777c77cc77cc77cc77c4aa4aaa22aaaaaa22aaaaa443303bb3b4949219479977997
bb332244ffff1fff442233bb4442444222424444771c77cc77cc77cc77cc7777771177117711771144a2aaa99aaaaaa99aaaaa4430050bbb4991192479977997
bbb3324444441f4444233bbb444442444444424477177cc77cc77cc77cc771777777777777777777424aa992299aa992299aa4240005000b0499921077999977
bbbb324444441f442423bbbb24444444244444447777cc77cc77cc77cc77c17777777777777777774249922aa229922aa2299424000300000011110011111111
bb33322444444424442333bb0044440000010000777cc77cc77cc77cc77cc77742222224222444244a249aaaaaa99aaaaaa942a4001111006555555611111111
bbb332444422244444233bbb0479994000171000771c77cc77cc77cc77cc777724442442444424444494299aa992299aa9924994111111115dd77dd577333377
bbbb3322223334222233bbbb479449910017710077177cc77cc77cc77cc7717722244442422444224242a229922aa22992242244007777005d7777d573377337
bbbbb333333b3233333b33bb49479191001771007777cc77cc77cc77cc77c17724444224244422244a4aaaa22aaaaaa22aa4aa44071717605777777573377337
bbbb333b33b3333b3333bbbb4949219101777610777cc77cc77cc77cc77cc77742424444242244444a4aaaa22aaaaaa22aa2aa24079977605667766573333337
bbbbb3bb3bb3b3bb3bbbbbbb499119210177761077717711771177117711777742222422424244244a2aaaa99aaaaaa99aaaaaa4999971605dd77dd573377337
0bbbbbbbbbbbbbbbbbbbbbb004999210177766610777777777777777777777704444424444244242044aa992299aa992299aa440071117605dd66dd573377337
000bbbbbbbbbbbbbbbbbb00000111100177666610007777777777777777770002424244424222442000444444444444444444000006666006555555611111111
000000000000077700777000000700000009000000b30000003b03b003b3b0004424242444244224aaa99aa4444444444aa99aaa00777700777cc77711111111
007777000007777777777700007a7000009a9000000b3b3003b03b003b3b3b004442244442442424a9922992442442422992299a0777777077cc77c77cc77771
07777770077777777777777007a9a70009a7a900000b30b303b3b3b3b3b03b004224244424244422922aa22942244229922aa2297777777607c77c707cc77771
777777767777777777777776007a7000009a9000b300b3b33b03b3b3b3b3b00024444222444442242aaaaaa22aa24aa22aaaaaa2777777760777cc707cc77771
77777776777777777777777600070000000900000b30b3b33b3b3b3bb3b3b00324444424244244442aaaaaa22aaa2aa22aaaaaa277777776007cc7007cc77771
067777606777777777776660bb0b0bb0bb0b0bb000b3b30b3b3b3b3b3b03b33b42424424422244249aaaaaa99aaaaaa99aaaaaa977777776007c77007cc77771
0066660006667766776600000bbbbb000bbbbb0000b30b3b3b3b3b3b3b3b03b04244422444422244299aa992299aa992299aa99207777760007770007cccccc1
00000000000066006600000000bbb00000bbb000000b3b3b3b3b3b3b3b3b3b002424224224242442444444444444444444444444006666000007000011111111
66666666666666666666666666666666666666666666666666666665656666666666656565656565656565656565656565656565656565656565656565666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666565666666666666666666666666666666666666
e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e755750000000000566666666666666666666666666666666666666666666666666676e7e7e7
e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e75575000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000557500000000000000e7e7e7e7000000e7e7e700000000e7e7e70000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005575000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000055750000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005575000000000000000000000000000000000000
0000000000000000000000000000000000000000d600000000000055750000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000005676365474000000547400000000000000000000
0000000000000000000000000000000000940000d7009494000000557500000000000000e5e5e5e5e500e5e5e5e5e50000e5e5e5e5e500005474365474000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000557500000055750000d400000000d40000
00000000000000949400000000000000546464646464646474000055750000000000000000000000000000000000000000000000000000005575005575000000
0000000000000000000000000000464600000000004646000000000000940094004694004646000046464600009400557500000055750000d5f4f5f6f7d50000
00547400000054646474000000547400556566666666666676000055750000000000009446464646464646464646464646464646464646465575005575000000
00000000000000000000000000005474000000000054740000000000546464646464646464646464646464646464646575000000557536360414141414243636
005575464646556565754646465575005575e7e7e7e7e7e700000055750000000000546484848484848484848484848484848484848484849576005575000000
00000000000000000000000000005575000000000055750000000000556565656566666666666666666666666565656575000000557500000586968696250000
005685848484656565658484849576005575000000000000000000557500000000005575e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7e7000000005575000000
000000000000004646000000000055750000000000557500000000005565656575e7e7e7e7e7e7e7e7e7e7e75565656575000000557500000587978797250000
0000000000005565657500000000000055750000009400000094005575000000000055750000000000000000000000000000000000000000d600005575000000
00000000000000547400000000005575000000000055750000000000556565657500000000000000000000005565656575e60000557500000586968696250000
0000000000005565657500000000000055750000546484848484849576000000000056760000000000000000000000000000000000000000d700e65575e60000
46460000e6000055750000e6000055750000e6000055750000e60000566666667600000000000000000000005666666676000000557500000587978797250000
00000000000055656575000000000000557500005676e7e7e7e7e7e7000000000000000000000000000000000000000000000000000000546464646575000000
54740000000000557500000000005575000000000055750000e7000000e7e7e700000000000000000000000000e7e7e700000000557500000586968696250000
e60094000094556565750000000000e6557500000000000000000000000000000000000000000000000000000000000000000000000000556565656575000000
5575000000000055750000000000557500000000005575000000000000000000000000000000d600000000000000000000000000557500000587978797250000
64646464646465656565740000005464657500009400949400000000009400e60094000000000000009400000000009400000000009494556565656575464646
5575464646464655754646464646557546464646465575009400000000000094000000e6e694d700e6e6009400000000940000e6557500000586968696250000
656565656565656565657546464655656575e65464646464646464646464646464646464646474e654646474e6e6546474e6e6e6546464656565656565646464
65656464646464656564646464646565646464646465656464646464646464646464646464646464646464646464646464646464657504144587978797351424
00000000000000000000000000000000000000000000000000000000000000000000000000000015151515151515151515151515151515151500000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f11500000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007000000000000000000
001727000000000000000000000000000000000000000700000000000000001727000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f11500001727000000
0000000000000000000000070000000000000000001727000000000700000000000000000000000000000000172700000000000000000000000000f4f5f6f700
000000000000000000000000001727000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f11500000000000000
00000017270000000000000000000700000000000000000000000000000000000000000000070000000000000000000000001727000000000000000000000000
00000000000000000700000000000000000000000000000000150015001500150015001500070015151515f1f11515f1f16464f1f115f1f11500150015001500
0000000000000000070000000000000000172700000015001500150000172700000000000000000000000007000000d4d4000000000000e0c200000000000000
00070000000000000000000000000000000700000000000000154615461546154615461500000015151515d2d21515d2d26565d2d215f1f11546154615461500
00070000000000000000000000000000000000000000154615461500000000000000000000000017270000000000d4d5d5000000000700f0c300000017270000
000000000017270000000000000000000000000000000000001515151515151515151515000000151515151515151515151515151515f1f11515151515151500
000000000000000000000000172700000000000000001515151515000000000000000700000000000000000000d4d5042400000000000000d000000000000000
000000000000000000000007000000000000001727000000e1f1f1f1f1f1f1f1f1f1f1f10000001515e315f1f1f1f1f1f1f1f1f1f115f1f115f1f1f1f1f1f100
00000000000017270000000000000000000000000000f1f1f1f1f10000000700000000000000000000000000d4d504452500001727000000d000000000000000
0000000700000000000000000000000000000000000000e100f1f1f1f1f1f1f1f1f1f1f10000001515f115f1f1f1f1f1f1f1f1f1f115f1f115f1f1f1f1f1f100
00000000000000000000000000000700000000000000f1f1f1f1f100000000000000001727000000000700d4d50445872500000000000000d000e600000000e6
00000000000000000000000000000007000000000000e10000f1f1f1f1f1f1f1f1f1f1f10000e61515f1f1f1f1f1f1f1f1f1f1f1f115f1f115f1f1f1f1f1f100
00000000070000000000000000000000001727000000f1f1f1f1f1001700000000000000000000000000d4d5044596862500000000000000d000150015150015
000000000000000000000000000000000000000000e1000000f1f1f1f1f1f1f1f1f1f1f11515151515f1d3d3d3f1d3d3f1f1f1d3f115f1f115f1f1f1f1f1f100
00000000000000000000172700000000000000000000f1f1f1f1f10000000000170000000000000000d4d504458797872500000000000000d000151515151515
00000000000000d40000d4000000000000000000e100000000f1f1f1f1f1f1f1f1f1f1151515151515f1f1f1f1f1f1f1f1f1f1f1f115f1f115f1f1f1f1151500
00000000000000000000000000000000000000000000151515151500000000000000000000000000d4d50445968696862500000000000000d00015f11515f115
00000000000000d53737d50000000000000000e10000000000f1f1f1f1f1f1f1f1f115151515151515f1f1f1f1d2f1f1f1f1f1f1f115f1f115f1f1f1f1151500
00000000000000000000000000000000000000000000151515151500000000000000000000000000d5044587978797872500000000000000d000151515151515
37473747375767041414240000363636360000e2f2f2f2f2f2151515f1f1f115151515151515151515f1f1f1f115f1f1d2f1f1f1f115f1f115f1f11515151500
00000000000000000000000000000000000000000000151515151500000000000000000000000000044596869686968625000000d4000000d0001515f1f11515
14141414141414458696250000000000000000000000000000151515f1f1f115151515151515151515e6f1f1f115151515f1f1f1f1f1f1f1f1f1f11515151500
000000e6000000000000e6000000000000e6000000001515151515151515f2f2f2f2f2f2f2f2f2f2058797879787978725003757d5773700e6001515f1f11515
87978797879787978797250000000000000000000000000000151515d2d2d2151515151515151515151515151515151515151515151515151515151515151546
46464646464646464646464646464646464646464646151515151515151500000000000000000000058696869686968635141414141414141414141414141414
__label__
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c777ccccccccc77ccccccccccccccccccccccc77cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c717c7c7ccccc717c777cc77c7ccc7ccccccc711c7c7cc77c77cc77cc7ccc777c77ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c771c777ccccc7c7c171c717c7ccc7ccccccc7ccc7c7c717c717c717c7ccc771c717cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c717c117ccccc7c7cc7cc777c7ccc7ccccccc7ccc777c777c7c7c7c7c7ccc71cc771cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c777c771ccccc7c7c777c717c177c177ccccc177c717c717c7c7c771c177c177c717cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c111c11cccccc1c1c111c1c1cc11cc11cccccc11c1c1c1c1c1c1c11ccc11cc11c1c1cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c777ccccccccccccccccccccccccccccccccccccc777c777cc77cc77ccccc777ccc8cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c777cc77c77cc777ccccc7c7c777c777c7c7ccccc717c171c711c717ccccc717cc97fccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c717c717c717c771ccccc7c7c171c171c7c7ccccc777cc7cc7ccc7c7c777c777ca777ecccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c7c7c777c7c7c71cccccc777cc7ccc7cc777ccccc711cc7cc7ccc7c7c111c717ccb75ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c7c7c717c771c177ccccc777c777cc7cc717ccccc7ccc777c177c771ccccc777ccc1cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
c1c1c1c1c11ccc11ccccc111c111cc1cc1c1ccccc1ccc111cc11c11cccccc111cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccc111ccc111cc11111111ccccc111ccccccccc111ccccccccccc111111cccc111ccc111cccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc16761c16761c1767777611ccc171ccccccccc171cccccccccc16777761ccc171ccc1761ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17771c17771c1777667771ccc171ccccccccc171ccccccccc1677616761c1671ccc1771ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17676167671c1711111111ccc171ccccccccc171cccccccc167611c1771c1771ccc1671ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17177177171c171111111ccc1671cccccccc1671cccccccc1771ccc1671c1761c1cc171ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17167676171c177777771ccc1771cccccccc1771cccccccc1761cccc171c171c171c171ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17116761171c171111111ccc1761cccccccc1761cccccccc171cccc1671c17616761671ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171c1111671c171ccccccccc171ccccccccc171ccccccccc1761ccc1771c17717671771ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171cccc1771c171cc111111c171c1111111c171c1111111c1771cc16761c16717171761ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171cccc1761c17111677771c17616777771c17616777771c1676116761ccc176717671cccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc111cccc171cc17777776111c17777761111c17777761111cc16777761cccc167616761cccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccc111cc11111111ccccc111111cccccc111111ccccccc111111cccccc111c111ccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccc111ccc111cc11111111ccccccc11111ccccc1111111ccccccc111111cccc111ccc111cccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc16761c16761c1767777611cccc1677761cccc17677761ccccc16777761ccc171ccc1761ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17771c17771c1777667771cccc1776771cccc177767761ccc1677616761c1671ccc1771ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17676167671c1711111111ccc167616761ccc1761116761c167611c1771c1771ccc1671ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17177177171c171111111cccc1771c1771ccc171ccc1771c1771ccc1671c1761c1cc171ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17167676171c177777771cccc1761c1671ccc171ccc1671c1761cccc171c171c171c171ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc17116761171c171111111ccc167111c1761cc171ccc1671c171cccc1671c17616761671ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171c1111671c171ccccccccc17777611771cc171ccc1771c1761ccc1771c17717671771ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171cccc1771c171cc111111c17167771671cc171cc16761c1771cc16761c16717171761ccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc171cccc1761c17111677771c17111111171cc171117761cc1676116761ccc176717671cccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccc111cccc171cc17777776111c171ccccc171cc17177761cccc16777761cccc167616761cccccccccccccccccccccccccccccc
ccccccccccccccccccccccccccccccccccc111cc11111111cccc111ccccc111cc1111111cccccc111111cccccc111c111ccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccc777cccccccccccccccccccccc77777cccc7cc77777cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccc717c77cc777cc77cc77ccccc7711177cc71c7717177ccccc777cc77cccccc77c7cccc77c7c7ccccccccccccccccccccccccccc
cccccccccccccccccccccccccc777c717c771c711c711ccccc77c7c77cc7cc7771777ccccc171c717ccccc717c7ccc717c777ccccccccccccccccccccccccccc
cccccccccccccccccccccccccc711c771c71cc1c7c1c7ccccc77c1c77cc7cc7717177cccccc7cc7c7ccccc777c7ccc777c117ccccccccccccccccccccccccccc
cccccccccccccccccccccccccc7ccc717c177c771c771ccccc1777771c71cc1777771cccccc7cc771ccccc711c177c717c771ccccccccccccccccccccccccccc
cccccccccccccccccccccccccc1ccc1c1cc11c11cc11ccccccc11111cc1cccc11111ccccccc1cc11cccccc1cccc11c1c1c11cccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
44424442444244424442444244424442444244424442444244424442444244424442444244424442444244424442444244424442444244424442444244424442
b3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423bbb3344423
44223324444444422332444444444233324444444422332444444442233244444444423332444444442233244444444223334444444442333244444444223324
44244444444233332244442444444442333322444424444444423333224444244444444233332244442444444442333322444424444444423333224444244444
bbbbbbbbbbbb3322244444444444422233333bbbbbbbbbbbbbbb3322244444444444442233333bbbbbbbbbbbbbbb3332244444444444442233333bbbbbbbbbbb
bbbbb33333322244444444444444222333bbbbbbbbbbbbbbbb33333322244444444444444222333bbbbbbbbbbbbbbbb33333322244444444444444222333bbbb
44444442224444444444444444444222333333333322222244444444442224444444444444444444422233333333322222224444444444222444444444444444
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444422224444444444444444444444444444444422224444444444444444444444444444444422222444444444444444444444444444444422222
42222244444444444444422222222222222444442222244444444444444444444444444444444442222244444444444444422222222222222444442222244444
44444422222222222333333333333333322222444444444444444444444444444444444444444444444444444442222222222233333333333333332222244444
333333bbbbbb333333bbbbbbbbbbb33333333333322222244444444444444444444444444444222222222222333333333333bbbbb333333bbbbbbbbbbbb33333
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333322222224444444444444444444444444444444442222223333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb333333322222224444444444444444444444444444444444222222233333333333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbb33333333333333333333332222222244444444444444444444444444444222222223333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbb3333333333333333333333332222222244444444444444444444444444444442222222233333333bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333322222222444444444444444442222222224444444442222222233333333333333333333333333bbbbbbbbbbbb
bbbbbbbbbbbbbbbbbbbbbbbbbbbbb33333333322222222244444444444444444222222222444444444222222222333333333333333333333333333bbbbbbbbbb
bbbbbbbbbbbbbbbbbb3333333333333333332222222222444444444444444444444444444444444444444444444442222222223333333333bbbbbbbbbbbbbbbb
bbbbbbbbbbbbbbb333333333333333333332222222222444444444444444444444444444444444444444444444444422222222223333333333bbbbbbbbbbbbbb
bbbbbbbbbbbb333333333333333333333222222222244444444444444444444444444444444444444444444444444444222222222223333333333bbbbbbbbbbb
33333333333333333333322222222222444444444444444444444444444444444444444444444444444444444444444442222222222233333333333333333333
33333333333333333332222222222244444444444444444444444444444444444444444444444444444444444444444444422222222222333333333333333333
33333333333333333222222222222444444444444444444444444444444444444444444444444444444444444444444444442222222222223333333333333333
33333333333333222222222222244444444444444444444444444444444444444444444444444444444444444444444444444422222222222223333333333333
22222222222224444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222222
22222222222444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222222
22222222244444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222222
22222244444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222
22222444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222
22244444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422
24444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444442222222222222222244444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444442222222222222222244444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444422222222222222222444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444222222222222222222444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444422222222222222222224444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444422222222222222222224444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444222222222222222222244444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444442222222222222222222244444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444222222222222222222222444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444222222222222222222222444444444444444444444444444444444444444444444444444444444444444444444444444444444444
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444222
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444422
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444442
44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444

__gff__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000043010100000000000000000000000000094200030303030307070707000b0b0b000083030303030307070707070b0b0b000983030303014307070703030b0b0b001383000000000000000003030b0b0b004283
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
4344520000000000000000000000000000000000000000000000000000000000007576770075767700505200000000000000000000005052000000000000000000000000000000000000000000000000000000000000000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e000000000000000000000000000000700000000000
5354520000000000000000000000000000000000000000000000000000000000404141414141414141545200000000000000000000005052000000000000000000000000000000000000000000000000000000000000000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e000000000000000000000000000000000071720000
6943620000000000000000000071720000000000000070000000000000000000506869686968696869685200004042000000404200005052000000000000006d00000000000000000000717200000000000000000000000000004e4e4e4e4e4e4e4e4e4e4a4b4c00004a4c000000000000007172000000000000000000000000
7952000000000000000070000000000000000000000000000000004d00717200507879787978797879785200005052000000505200005052000000000000007d00004900000000004900000000000000000000004900000000004a4c5e4a4c004a4b4c005a5b5c00005a5c000000717200000000000000007000000000007000
6952000070000000000000000000757677000000007374000000005d00000000504361616161616161616200635052000000505263006062000000000000454646464646470000454647000000454700000000454646470000005a5c645a5c645a5b5c645a5b5c64645a5c000000000000000000000000000000000000000000
7952000000000000000000000040414141420000404141420000404142000000505200000000000000000000005052000000505200000000000000000000555656565656576464555657646464555764646464555656570000006a7a7b7c7a7b7c6b7a7b7c6b7a7b7b7c6c000000000000000000007172000000000000000000
6952000000000000000000000050696869526464504344526464506952000000505200717200000000757677735052646464505273757677000000000063656666666666584848596658484848595848484848596666670000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e000000000070000000000000000000007172000000
7952636363636363636363636350797879534141545354534141547952000000505200000000000000404141415453414141545341414142000000000000000000000000000000000000000000000000000000000000000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e004d4d000000000000000000000000000000000000
6952004d00000000000000000050696869686968694361616161616162000063505200006363636363506968696869686968696869686952000000000000000000717200000000000000007000000000000000000000000070004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e005d5d0000000000000000000075774f5f6f7f7577
7952005d00000000717200000050797879787978795200000000000000000000505200000000000000606161616161616161616161614452630071720000000000000000000000000000000000000000000071720000000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e004042636363636363636363634041414141414141
695341414200000000000000005069686968696869520070000000000000000050520000000070000000000000000000000000000000505200000000000000000000000000007000000000000000000000000000006d000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e005052000000000000000000006061616161616161
794361616200000000000000005079787978797879520000006363636363636350526363000000000000000000000000000000000000505200000000490000490000000000490000000049000000000000000000007d000000004e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e4e005052000000000000000000000000000000000000
6952000000000000007576770050696869686968695200000000000000000000606200000000007576767700007475777400000000755052000045464646464647000045464647000045464700000045470000004546470000004a4c5e4a4c4e4e4e4e4e4e4e4e4e4e4e4e405452000000000000000000000000000000000000
7952000000000000404141414154797879787978795200404200000000000000000000000000004041414200004041414200004041415452636355565656565657636355565657000055565700000055570000005556576363635a5c005a5c004a4b4c004a4b4c00004a4c506852000000000000000000000000000000000000
6952636363636363506869686968696869686968695264505277007473737400757677004041415479785264645043445264645069686952646455565656565657646455565657646455565764646455576464645556570000005a5c005a5c005a5b5c005a5b5c00005a5c507852000000000000000000000000000000000000
7952000000000000507879787978797879787978795341545341414141414141414141415468696869685341415453545341415479787953414155565656565656464656565656464656565646464656564646465656570000005a5c645a5c645a5b5c645a5b5c64645a5c506852000000000000000000000000000000000000
0000000000000000000000000000505200000000000000000000000000000000000000000000000000000000000000000000005557000000000000000000000000000000000000000000000000000000000000000000000000000060616161446869436161616161616161616162000000000000000000000000000000000000
0000000000000000000000000000505200490049000000000000000000000000000000000000000000000000000000000000005557000000000000000000000000000000000000000000000000000000000000000000000000000000000000507879520000000000000000000000000000000000000000000000007000000000
0000000000700000000000000000505245464646475e5e00005e5e00005e5e00005e5e00005e5e4546470000000000000000005557000000700000000000000000000070004a4c000000000000717200000000000000000000000070000000504361626363636363636363636363636e00000000000000454700000000454700
00000000000000000000007172005052555656565764646464646464646464646464646464646455565700000075767677000055575e5e0000005e5e5e00005e5e000000005a5c000000000000000000000070000000000000000000000000505200000000000000000000000000000000000071720000555700000000555700
4d0000004d0000004d0000000000505265666666584848484848484848484848484848484848485966670000004041414200005557000000000000000000000000006363005a5c000071720000000000000000000000000000000000000000505200000000007000000000000000000000000000000000555700000000555700
5d7576775d0000005d0000000000505200000000000000000000000000000000000000000000000000000000005079785200005557000000000070000000000000000000005a5c00000000000000000000000000000000717200004a4c0000505200000000000000000000000000000000000000000000555700717200555700
414141414200000040425e5e5e00505200700000000000000000000000000071720000000000000000000000005069685263005557000000000000000000717200000000005a5c00000000700000000000000000000000000000005a5c000050520000006e00005e5e5e00005e5e5e0000000000000000555700000000555700
6968696852636363505200000000505200000000000000717200000000000000000000000000000000700000005079785200005557000070000000000000000000000000005a5c00000000000000007172000000000000000000005a5c00005052000000000000000000000000005e5e5e000000000000555700000000555700
79787978520000005052000000005052000000000000000000000000000000000000000070000000000000000050696852000055570000006d0000000000000000007000005a5c00000000000000000000000000000000000000005a5c0000505200007000000000000000000000000000005e5e5e000055570000000055576e
69686968520000005052000000005052000071720000000000000000000000000000000000000000000000000050797852000065670000007d0000000000000000000000005a5c00000000000000000000000000700000000000005a5c0000606200000000000000007172000000000000000000000000555700000000555700
79436161620000005052000000645052000000000000000075767677000000000000000000000000000000736e506968520000000000004546475e4a4b4c4e4e4a4c00006e5a5c6e000000006e00000000006e000000000000006e5a5c6e00000000000000000000000000000000000000000000000000555770000000555700
695200000000000050520000004054520000000000000000404141420000005e5e5e005e5e5e005e5e0040414154797852000000000000555657005a5b5c4e4e5a5c0000005a5c00000000000000700000000000000000000000005a5c636363634a4b4b4b4b4b4b4b4c00005e5e00005e5e0000630000555700000000555770
7952004d0000000050520000006061620000000000007000506869520000000000000000000000000000506869686968526e0000490000555657006a6b6c4e4e6a6c0000006a6c00700000000000000000000000000000000000005a5c4e4e4e4e5a5b5b4b4b5b5b5b5c00000000000000000000000000555700000070555700
6952005d00006e0050520000000000000000000000000000507879520000000000000000000000000000507879787978526363454646465656570000000000000000004d00000000000000000000000000000000000000000070005a5c4e4e4e4e5a5b5b5b5b5b4b4b5c00000000000000007000000000555700000000555700
79534141414141415452004042770074006e000000000000506869526464646464646464646464646464506869686968520000555656565656570075767700737473005d00757677000000000000000071720000000000000000005a5c4e4e4e4e5a5b4b4b5b5b5b5b5c00000000000000000000000000555700000000555700
686968696869686968526450534141414141424a4b4b4b4c507879534141414141414141414141414141547879787978520000555656565656576e40414141414141414141414142646464646464646464646464646464646464645a5c4e4e4e4e5a5b5b5b5b4b4b5b5c6e4a4b4b4b4b4b4b4b4b4c646455574f5f6f7f555700
__sfx__
000100001e0601e0601e0601e0601e0602206022060230602306024060240602506025060260602706028060290652a0652b0602c0402d0402e0302f035310253202533015000000000000000000000000000000
010c00000265301643016030860307603066030660305600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010200002607026070260702607030070300703006030060300603005030050300503004030040300403003030030300303003030030300203002030020300103001030010270002700027000160001600016000
0020000410073110731f6351170010003110031f6051870010003110031f6051170010003110031f6051570010003110031f6051170010003110031f6052670010003110031f6051170010003110031f60500000
00100010100631e645110631a500206451f60514500125001006310605110631a5001f64500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000201b7731d7731f77321773237732577326773267732577323773217731f7731d7731b77319773197731b7731d7731f773217732377325773277732977329773277732577323773217731f7731d7731b773
00100010226450f60507645076451c645106050764507645176451764507645176451060507645076450764511605106050c60512605116051260512605126050e60511605106051160511605116051160509605
001000102b6551760017655176551f6551f65517655176551f655176551f655316551b6051765517655176551e605166051a60524605116051260512605126050c605196050f6051160511605116051160509605
001000001c6551c6551c6551c65520655226550000525655276552865528655286550000526655216551a6551765513655126551265512655126552060516655166552260517655176552360517655126550c655
001000000f05000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000f0501105014050170501c050200502505027050280502800028050270002805026000250002500023000200001e0001a000180001800019000340003500037000390003900000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010400000e55327553275532755327553275532754327543275432753327533275332752327523275232751327513275132750327503275032750327503275032750327503275032750327503005030050300503
__music__
01 03434344
00 03044344
01 03040644
00 03040506
00 08030445
00 03040845
00 03040507
02 03040607

