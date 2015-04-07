%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                            %
%      NOVAPAINT 2.1 -the latest advancement in the turing grafix dept.      %
%                                                                            %
%            Novapaint is a drawing program made specifically for            %
%            Turing.  This new program works with Turing 7.1.1A. with        %
%            all new graphics and new push-button technology!                %
%            For those of you who only have Turing 7.06C, there may          %
%            still be some copies of Novapaint 2.0 left in stock.            %
%            Please contact our headquarters at:  1-(905)-389-9954           %
%                                                                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%% THE FOLLOWING ARE ALL OF MY GLOBAL VARIABLES... %%%%%%%%%%%%%%%

% Variables for events which happen on the drawing board...
var x, y, clr, tempclr, brushsize, stream, brush : int
clr := 16 % The initial colour will be colour #16 (black)
brushsize := 1

% Varialbles for events which have to do with the mouse...
var btn, lastx, lasty, origx, origy, updown, left, middle, right : int

% Variables for the different windows when they are all floating around...
var toolx, tooly, clrx, clry, where, zoomx, zoomy : int := - 100
var what_tool : string (12)
what_tool := "drawtool.gfx"

% Other variables that were added as needed...
var flag, selection, groove : int := 1
var quit, answer, filler, tool, colours, saved, zoomed,
    savebox : boolean := false
var save_name : string (15)
var load_name, file : string (30)
flag := 2

% Arrays for holding the "takepic" info. that will be needed so that the
% windows don't erase the lovely drawings underneath them...
var behind_tool : array 1 .. sizepic (0, 0, 145, 150) of int
var behind_clrbar : array 1 .. sizepic (0, 0, 170, 150) of int
var side1 : array 1 .. sizepic (0, 0, 4, 160) of int
var side2 : array 1 .. sizepic (0, 0, 4, 135) of int
var side3 : array 1 .. sizepic (0, 0, 4, 135) of int
var side4 : array 1 .. sizepic (0, 0, 4, 160) of int

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           THE FOLLOWING WAS PROGRAMED BY THE PEOPLE AT TURING!!!           %
%           I AM ONLY USING IT, NOT TAKING CREDIT FOR IT!!!                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

include "a:\t2\scrnfl2.t"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%           THE REST OF THE PROGRAM WAS DONE BY ME, ROB McLARTY.             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

proc intro
    f2s (0, 80, "a:\\npaint\\grafix\\nptitle.gfx")
    for t : 16 .. 18
  locate (20, 30)
  colour (t)
  put "VER. 2.1"
  delay (300)
    end for
    delay (3000)

    var intx, inty : int
    var count : int := 0

    loop
  randint (intx, 80, maxx - 80)
  randint (inty, 75, maxy - 75)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 100
    end loop
    count := 0
    loop
  randint (intx, 70, maxx - 70)
  randint (inty, 65, maxy - 65)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 100
    end loop
    count := 0
    loop
  randint (intx, 60, maxx - 60)
  randint (inty, 55, maxy - 55)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 100
    end loop
    count := 0
    loop
  randint (intx, 50, maxx - 50)
  randint (inty, 45, maxy - 45)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 300
    end loop
    count := 0
    loop
  randint (intx, 40, maxx - 40)
  randint (inty, 35, maxy - 35)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 400
    end loop
    count := 0
    loop
  randint (intx, 30, maxx - 30)
  randint (inty, 25, maxy - 25)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 600
    end loop
    count := 0
    loop
  randint (intx, 20, maxx - 20)
  randint (inty, 15, maxy - 15)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 800
    end loop
    count := 0
    loop
  randint (intx, 10, maxx - 10)
  randint (inty, 5, maxy - 5)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 1400
    end loop
    count := 0
    loop
  randint (intx, 0, maxx)
  randint (inty, 0, maxy)
  drawfilloval (intx, inty, 2, 2, 31)
  count += 1
  exit when count = 2000
    end loop
    count := 0
    loop
  randint (intx, 0, maxx)
  randint (inty, 0, maxy)
  drawfilloval (intx, inty, 3, 3, 31)
  count += 1
  exit when count = 2000
    end loop
    count := 0
    loop
  randint (intx, 0, maxx)
  randint (inty, 0, maxy)
  drawfilloval (intx, inty, 4, 4, 31)
  count += 1
  exit when count = 3300
    end loop
    count := 0
    drawfillbox (0, 0, maxx, maxy, 31)
    delay (1000)
end intro

proc help
    % Make me a seperate program too...
    % I will be part of the readme file!
    delay (200)
    f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
    flag := 2
end help

proc rus
    s2f (70, 80, 201, 135, "a:\\npaint\\grafix\\rustemp.gfx")
    f2s (70, 80, "a:\\npaint\\grafix\\r_u_sure.gfx")
    loop
  mousewhere (x, y, btn)
  if btn = 1 then
      if y > 92 and y < 107 then
    if x > 85 and x < 125 then
        f2s (85, 92, "a:\\npaint\\grafix\\yes_dn.gfx")
        delay (300)
        f2s (85, 92, "a:\\npaint\\grafix\\yes_up.gfx")
        delay (200)
        answer := true
        exit
    elsif x > 145 and x < 184 then
        f2s (145, 92, "a:\\npaint\\grafix\\no_dn.gfx")
        delay (300)
        f2s (145, 92, "a:\\npaint\\grafix\\no_up.gfx")
        delay (200)
        answer := false
        exit
    end if
      end if
  end if
    end loop
    f2s (70, 80, "a:\\npaint\\grafix\\rustemp.gfx")
end rus

proc circles
    if (x not= lastx) or (y not= lasty) then
  drawoval (origx, origy, origx - lastx, origy - lasty, 31)
  drawoval (origx, origy, origx - x, origy - y, clr)
  lastx := x
  lasty := y
    else
    end if
    if filler = true then
  drawfilloval (origx, origy, origx - x, origy - y, clr)
    else
    end if
end circles

proc lines
    if (x not= lastx) or (y not= lasty) then
  drawline (origx, origy, lastx, lasty, 31)
  drawline (origx, origy, x, y, clr)
  lastx := x
  lasty := y
    end if
end lines

proc load_save (load_or_save : int)
    s2f (10, 50, maxx, 180, "a:\\npaint\\grafix\\submtemp.gfx")
    if load_or_save = 1 then
  f2s (10, 56, "a:\\npaint\\grafix\\loadbar.gfx")
    elsif load_or_save = 2 then
  f2s (10, 56, "a:\\npaint\\grafix\\savebar.gfx")
    end if
    loop
  if hasch then
      setscreen ("cursor,echo")
      colour (30)
      locate (15, 3)
      if load_or_save = 1 then
    get load_name
      else
    get save_name
      end if
      exit
  end if
    end loop
    setscreen ("nocursor,noecho")
    loop
  mousewhere (x, y, btn)
  if btn = 1 then
      if y > 60 and y < 75 then
    if x > 18 and x < 57 then
        if load_or_save = 1 then
      f2s (18, 60, "a:\\npaint\\grafix\\loaddn.gfx")
      delay (300)
      f2s (18, 60, "a:\\npaint\\grafix\\loadup.gfx")
      delay (200)
        else
      f2s (18, 60, "a:\\npaint\\grafix\\savedn.gfx")
      delay (300)
      f2s (18, 60, "a:\\npaint\\grafix\\saveup.gfx")
      delay (200)
        end if
        rus
        if answer = true then
      f2s (0, 0, "a:\\npaint\\grafix\\scrntemp.gfx")
      if load_or_save = 1 then
          file := load_name
          f2s (lastx, lasty, file)
      elsif load_or_save = 2 then
          file := "a:\\npaint\\pics\\" + save_name + ".til"
          s2f (min (origx, lastx), min (origy, lasty), max
        (origx, lastx), max (origy, lasty), file)
          saved := true
          savebox := false
      end if
        else
      f2s (0, 0, "a:\\npaint\\grafix\\scrntemp.gfx") 
        end if
        exit
    elsif x > 249 and x < 288 then
        f2s (249, 60, "a:\\npaint\\grafix\\backdn.gfx")
        delay (300)
        f2s (249, 60, "a:\\npaint\\grafix\\backup.gfx")
        delay (200)
        f2s (10, 50, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 0, "a:\\npaint\\grafix\\scrntemp.gfx")
        exit
    end if
      end if
  end if
    end loop
    flag := 1
end load_save

proc boxes
    if x >= origx then
  takepic (origx, origy, x, origy, side1)
  takepic (origx, y, x, y, side4)
    elsif x < origx then
  takepic (x, origy, origx, origy, side1)
  takepic (x, y, origx, y, side4)
    end if
    if y >= origy then
  takepic (origx, origy, origx, y, side2)
  takepic (x, origy, x, y, side3)
    elsif y < origy then
  takepic (origx, y, origx, origy, side2)
  takepic (x, y, x, origy, side3)
    end if
    loop
  exit when btn = 0
  mousewhere (x, y, btn)
  if (x not= lastx) or (y not= lasty) then
      if x >= origx then
    drawpic (origx, origy, side1, 0)
    drawpic (origx, lasty, side4, 0)
    takepic (origx, origy, x, origy, side1)
    takepic (origx, y, x, y, side4)
      elsif x < origx then
    drawpic (lastx, origy, side1, 0)
    drawpic (lastx, lasty, side4, 0)
    takepic (x, origy, origx, origy, side1)
    takepic (x, y, origx, y, side4)
      end if
      if y >= origy then
    drawpic (origx, origy, side2, 0)
    drawpic (lastx, origy, side3, 0)
    takepic (origx, origy, origx, y, side2)
    takepic (x, origy, x, y, side3)
      elsif y < origy then
    drawpic (origx, lasty, side2, 0)
    drawpic (lastx, lasty, side3, 0)
    takepic (origx, y, origx, origy, side2)
    takepic (x, y, x, origy, side3)
      end if

      drawbox (origx, origy, x, y, clr)

      lastx := x
      lasty := y
  end if
    end loop

    if filler = true then
  if savebox = false then
  drawfillbox (min (origx, lastx), min (origy, lasty), max (origx,
      lastx), max (origy, lasty), clr)
  else
  end if
    else
    end if
end boxes

proc fill
%     var fillclr : int
%     fillclr := whatdotcolour (x, y)
%     loop
%         if whatdotcolour (x - 1, y) = fillclr then
%             x -= 1
%         end if
%         exit when whatdotcolour (x - 1, y) not= fillclr
%     end loop
%     origx := x
%     origy := y + 1
%     lastx := x
%     loop
%         if whatdotcolour (x, y) = fillclr then
%             drawdot (x, y, clr)
%             x += 1
%         elsif whatdotcolour (x, y) not= fillclr then
%             x := lastx
%             y -= 1
%             exit when whatdotcolour (x, y) not= fillclr
%             loop
%                 if whatdotcolour (x, y) not= fillclr then
%                     x += 1
%                 end if
%                 exit when whatdotcolour (x, y) = fillclr
%             end loop
%             lastx := x
%         end if
%     end loop
%     x := origx
%     y := origy
%     loop
%         if whatdotcolour (x, y) = fillclr then
%             drawdot (x, y, clr)
%             x += 1
%         elsif whatdotcolour (x, y) not= fillclr then
%             x := lastx
%             y += 1
%             exit when whatdotcolour (x, y) not= fillclr
%             loop
%                 if whatdotcolour (x, y) not= fillclr then
%                     x += 1
%                 end if
%                 exit when whatdotcolour (x, y) = fillclr
%             end loop
%             lastx := x
%         end if
%     end loop
    drawfill (x, y, clr, clr)
end fill

proc dots
    if zoomed = false then
  if brushsize = 1 then
      drawdot (x, y, clr)
      drawline (lastx, lasty, x, y, clr)
  elsif brushsize = 2 then
      drawfilloval (x, y, 1, 1, clr)
  elsif brushsize = 3 then
      drawfilloval (x, y, 2, 2, clr)
  elsif brushsize = 4 then
      randint (brush, 1, 4)
      % tries to give the illusion of a paintbrush...
      drawfilloval (x, y, brush, brush, clr)
  end if
    else
  if whatdotcolour (x, y) not= 0 then
      drawfill (x, y, clr, 0)
  end if
    end if
    lastx := x
    lasty := y
end dots

proc selections
    case selection of
  label 1 :
      dots
  label 2 :
      lines
  label 3 :
      circles
  label 4 :
      boxes
  label 5 :
      fill
  label 6 :
      clr := 31
      dots
  label 7 :
      circles
  label 8 :
      boxes
    end case
end selections

proc move
    if where = 1 then
  s2f (toolx, tooly, toolx + 90, tooly + 59,
      "a:\\npaint\\grafix\\tooltemp.gfx")
    elsif where = 2 then
  s2f (clrx, clry, clrx + 105, clry + 59,
      "a:\\npaint\\grafix\\clrtemp.gfx")
    elsif where = 3 then
  takepic (x, y, x + 82, y, side1) %bottom
  takepic (x, y, x, y + 52, side2) %left
  takepic (x, y + 52, x + 82, y + 52, side3) %top
  takepic (x + 82, y, x + 82, y + 52, side4) %right
    end if
    loop
  exit when btn = 0
  mousewhere (x, y, btn)
  if where = 1 then
      drawpic (toolx, tooly, behind_tool, 0)
      toolx += (x - lastx)
      tooly += (y - lasty)
      if toolx < 1 or toolx + 90 > 319 then
    toolx += (lastx - x)
      end if
      if tooly < 1 or tooly + 59 > 184 then
    tooly += (lasty - y)
      end if
      takepic (toolx, tooly, toolx + 90, tooly + 59, behind_tool)
      f2s (toolx, tooly, "a:\\npaint\\grafix\\tooltemp.gfx")
  elsif where = 2 then
      drawpic (clrx, clry, behind_clrbar, 0)
      clrx += (x - lastx)
      clry += (y - lasty)
      if clrx < 1 or clrx + 106 > 319 then
    clrx += (lastx - x)
      end if
      if clry < 1 or clry + 59 > 184 then
    clry += (lasty - y)
      end if
      takepic (clrx, clry, clrx + 105, clry + 59, behind_clrbar)
      f2s (clrx, clry, "a:\\npaint\\grafix\\clrtemp.gfx")
  elsif where = 3 then
      if x not= lastx or y not= lasty then
    if x > 237 then
        x := 237
    end if
    if y > 147 then
        y := 147
    end if
    takepic (x, y, x + 82, y, side1)
    takepic (x, y, x, y + 52, side2)
    takepic (x, y + 52, x + 82, y + 52, side3)
    takepic (x + 82, y, x + 82, y + 52, side4)
      end if
      drawbox (x, y, x + 82, y + 52, 32)
      drawpic (x, y, side1, 0)
      drawpic (x, y, side2, 0)
      drawpic (x, y + 52, side3, 0)
      drawpic (x + 82, y, side4, 0)
  end if
  lastx := x
  lasty := y
    end loop
end move

proc tools
    if tool = true then
  if y > tooly + 2 and y < tooly + 22 then
      if x > toolx + 2 and x < toolx + 22 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 2, tooly + 2,
        "a:\\npaint\\grafix\\erasdn.gfx")
    delay (400)
    f2s (toolx + 2, tooly + 2,
        "a:\\npaint\\grafix\\erasactv.gfx")
    what_tool := "drawtool.gfx"
    selection := 6
      elsif x > toolx + 24 and x < toolx + 44 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 24, tooly + 2,
        "a:\\npaint\\grafix\\filldn.gfx")
    delay (400)
    f2s (toolx + 24, tooly + 2,
        "a:\\npaint\\grafix\\fillactv.gfx")
    what_tool := "filltool.gfx"
    selection := 5
      elsif x > toolx + 46 and x < toolx + 66 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 46, tooly + 2,
        "a:\\npaint\\grafix\\circdnf.gfx")
    delay (400)
    f2s (toolx + 46, tooly + 2,
        "a:\\npaint\\grafix\\circacvf.gfx")
    what_tool := "circtool.gfx"
    filler := true
    selection := 7
      elsif x > toolx + 68 and x < toolx + 88 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 68, tooly + 2,
        "a:\\npaint\\grafix\\boxdnf.gfx")
    delay (400)
    f2s (toolx + 68, tooly + 2,
        "a:\\npaint\\grafix\\boxacvf.gfx")
    what_tool := "boxtool.gfx"
    filler := true
    selection := 8
      end if
  elsif y > tooly + 24 and y < tooly + 44 then
      if x > toolx + 2 and x < toolx + 22 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 2, tooly + 24,
        "a:\\npaint\\grafix\\dotdn.gfx")
    delay (400)
    f2s (toolx + 2, tooly + 24,
        "a:\\npaint\\grafix\\dotactv.gfx")
    what_tool := "drawtool.gfx"
    selection := 1
      elsif x > toolx + 24 and x < toolx + 44 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 24, tooly + 24,
        "a:\\npaint\\grafix\\linedn.gfx")
    delay (400)
    f2s (toolx + 24, tooly + 24,
        "a:\\npaint\\grafix\\lineactv.gfx")
    what_tool := "linetool.gfx"
    selection := 2
      elsif x > toolx + 46 and x < toolx + 66 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 46, tooly + 24,
        "a:\\npaint\\grafix\\circdn.gfx")
    delay (400)
    f2s (toolx + 46, tooly + 24,
        "a:\\npaint\\grafix\\circactv.gfx")
    what_tool := "circtool.gfx"
    filler := false
    selection := 3
      elsif x > toolx + 68 and x < toolx + 88 then
    f2s (toolx, tooly, "a:\\npaint\\grafix\\toolbar.gfx")
    f2s (toolx + 68, tooly + 24,
        "a:\\npaint\\grafix\\boxdn.gfx")
    delay (400)
    f2s (toolx + 68, tooly + 24,
        "a:\\npaint\\grafix\\boxactv.gfx")
    what_tool := "boxtool.gfx"
    filler := false
    selection := 4
      end if
  elsif x > toolx + 1 and x < toolx + 89 and y > tooly + 46 and y <
    tooly + 58 then
      if x > toolx + 79 and x < toolx + 88 and y > tooly + 48 and
        y <
        tooly + 57 then
    f2s (toolx + 79, tooly + 48,
        "a:\\npaint\\grafix\\closedn.gfx")
    delay (300)
    f2s (toolx + 79, tooly + 48,
        "a:\\npaint\\grafix\\closeup.gfx")
    delay (200)
    drawpic (toolx, tooly, behind_tool, 0)
    toolx := - 100
    tool := false
      else
    where := 1 % A value of 1 means that the cursor is
    move % moving the toolbar.
      end if
  end if
    end if
end tools

proc clrs
    if colours = true then
  drawfillbox (clrx + 61, clry + 3, clrx + 102, clry + 42, clr)
  f2s (clrx + 2, clry + 4, "a:\\npaint\\grafix\\" + what_tool + "")
  if x > clrx + 2 and x < clrx + 58 and y > clry + 28 and y < clry
    + 43 then
      f2s (clrx + 2, clry + 28, "a:\\npaint\\grafix\\changedn.gfx")
      delay (300)
      f2s (clrx + 2, clry + 28, "a:\\npaint\\grafix\\changeup.gfx")
      delay (200)
      s2f (0, 0, maxx, maxy, "a:\\npaint\\grafix\\clrtemp.gfx")
      f2s (33, 4, "a:\\npaint\\grafix\\clrchnge.gfx")
      loop
    mousewhere (x, y, btn)
    if btn = 1 then
        if x > 41 and x < 271 and y > 7 and y < 167 then
      if whatdotcolour (x, y) not= 0 then
          clr := whatdotcolour (x, y)
          delay (300)
          f2s (0, 0,
        "a:\\npaint\\grafix\\clrtemp.gfx")
          drawfillbox (clrx + 61, clry + 3, clrx + 102,
        clry + 42, clr)
          exit
      end if
        elsif x > 267 and x < 276 and y > 177 and y < 186
          then
      f2s (268, 178, "a:\\npaint\\grafix\\closedn.gfx")
      delay (300)
      f2s (268, 178, "a:\\npaint\\grafix\\closeup.gfx")
      delay (200)
      f2s (0, 0,
          "a:\\npaint\\grafix\\clrtemp.gfx")
      exit
        else
        end if
    end if
      end loop
  elsif x > clrx + 1 and x < clrx + 104 and y > clry + 46 and y <
    clry
    + 58 then
      if x > clrx + 94 and x < clrx + 103 and y > clry + 48 and y <
        clry + 57 then
    f2s (clrx + 94, clry + 48,
        "a:\\npaint\\grafix\\closedn.gfx")
    delay (300)
    f2s (clrx + 94, clry + 48,
        "a:\\npaint\\grafix\\closeup.gfx")
    delay (200)
    drawpic (clrx, clry, behind_clrbar, 0)
    clrx := - 200
    colours := false
      else
    where := 2 % A value of 2 means the cursor is moving
    move % the colourbar.
      end if
  end if
    end if
end clrs

proc groovie
    f2s (0, 0, "a:\\npaint\\grafix\\scrntemp.gfx")
    tempclr := clr
    x := min (origx, lastx)
    y := min (origy, lasty)
    if groove = 1 then % MAKES ALL COLOURS OPPOSITE
  loop
      clr := whatdotcolour (x, y) - 124
      clr := 124 - clr
      if clr < 0 then
    clr := maxcolour + clr
      end if
      drawdot (x, y, clr)
      x += 1
      if x >= max (origx, lastx) then
    x := min (origx, lastx)
    y += 1
      end if
      exit when y >= max (origy, lasty)
  end loop
    elsif groove = 2 then % FUNKY DIAGONALS...
  for i : 1 .. 162
      for d : 1 .. 150
    if whatdotcolour (x, d) not= 0 then
        tempclr := whatdotcolour (x, d) - 124
        tempclr := 124 - clr
        if tempclr < 0 then
      tempclr := maxcolour + tempclr
        end if
        tempclr := tempclr + i
        if tempclr > 255 then
      tempclr := tempclr - maxcolour
        end if
        drawdot (x, d, tempclr)
    end if
    x += 1
    if x > max (origx, lastx) then
        x := min (origx, lastx)
    end if
      end for
  end for
    else % MAKES EVERYTHING GO ON AN ANGLE...

  open : stream, "a:\\npaint\\zoom.dat", put

  for i : y .. max (origy, lasty)
      for d : x .. max (origx, lastx)
    tempclr := whatdotcolour (i, d)
    put : stream, tempclr
      end for
  end for

  close (stream)

  drawfillbox (0, 0, maxx, maxy, 0)

  open : stream, "a:\\npaint\\zoom.dat", get

  for i : y .. max (origy, lasty)
      for d : x .. max (origx, lastx)
    get : stream, tempclr
    drawdot (i, d, tempclr)
      end for
  end for

  close (stream)

    end if
    clr := tempclr
end groovie

proc zoom
    open : stream, "a:\\npaint\\zoom.dat", put
    for i : zoomy + 1 .. zoomy + 50
  for d : zoomx + 1 .. zoomx + 80
      tempclr := whatdotcolour (d, i)
      put : stream, tempclr
  end for
    end for

    close (stream)

    drawfillbox (0, 0, maxx, maxy, 0)

    open : stream, "a:\\npaint\\zoom.dat", get

    for i : 1 .. maxy by 4
  for d : 1 .. maxx by 4
      get : stream, tempclr
      drawfillbox (d, i, d + 2, i + 2, tempclr)
  end for
    end for

    close (stream)

end zoom

proc zoomout
    open : stream, "a:\\npaint\\zoom.dat", put

    for i : 1 .. maxy by 4
  for d : 1 .. maxx by 4
      tempclr := whatdotcolour (d, i)
      put : stream, tempclr
  end for
    end for

    close (stream)

    drawfillbox (0, 0, maxx, maxy, 0)

    f2s (0, 0, "a:\\npaint\\grafix\\scrntemp.gfx")

    open : stream, "a:\\npaint\\zoom.dat", get

    for i : zoomy + 1 .. zoomy + 50
  for d : zoomx + 1 .. zoomx + 80
      get : stream, tempclr
      drawdot (d, i, tempclr)
  end for
    end for

    close (stream)

end zoomout

setscreen ("graphics:mcga,nocursor,noecho")
randomize

intro

drawfillbox (0, 0, maxx, maxy, 31)

s2f (0, 185, 319, 199, "a:\\npaint\\grafix\\bfiletmp.gfx")
f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")

buttonchoose ("multibutton")

loop
    if buttonmoved ("down") then
  buttonwait ("down", origx, origy, btn, updown)
  x := origx
  y := origy
  lastx := origx
  lasty := origy
  loop
      exit when btn = 0
      mousewhere (x, y, btn)
      left := btn mod 10 % left = 0 or 1
      middle := (btn - left) mod 100 % middle = 0 or 10
      right := btn - middle - left % right = 0 or 100
      if left = 1 then
    if flag = 1 then
        if x > toolx + 90 or x < toolx or y > tooly + 59 or y <
          tooly then
      if x > clrx + 105 or x < clrx or y > clry + 59 or y
        < clry then
          selections
      end if
        else
        end if
    elsif flag = 2 then
        if y > 185 and y < 198 then
      if x > 1 and x < 62 then
          if zoomed = false then
        f2s (7, 187,
            "a:\\npaint\\grafix\\filehl.gfx")
        delay (200)
        s2f (3, 119, 96, 187,
            "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (3, 119,
            "a:\\npaint\\grafix\\filemenu.gfx")
        if saved = false then
            drawline (9, 152, 91, 152, 40)
        end if
        flag := 3
          else
          end if
      elsif x > 61 and x < 118 then
          if zoomed = false then
        f2s (63, 187,
            "a:\\npaint\\grafix\\edithl.gfx")
        delay (200)
        s2f (60, 119, 160, 187,
            "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (60, 119,
            "a:\\npaint\\grafix\\editmenu.gfx")
        flag := 4
        drawline (64, 144, 148, 144, 40) %paste
        drawline (64, 152, 148, 152, 40) %copy
        drawline (64, 160, 148, 160, 40) %cut
        drawline (64, 176, 148, 176, 40) %undo
          else
          end if
      elsif x > 117 and x < 182 then
          f2s (119, 187,
        "a:\\npaint\\grafix\\toolshl.gfx")
          delay (200)
          s2f (115, 125, 208, 187,
        "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (115, 125,
        "a:\\npaint\\grafix\\toolmenu.gfx")
          drawline (120, 136, 203, 136, 40)
          if tool = true then
        drawline (120, 152, 203, 152, 40)
          end if
          if colours = true then
        drawline (120, 144, 203, 144, 40)
          end if
          if zoomed = true then
        % Zoom in...
        drawline (120, 176, 203, 176, 40)
        % Brush...
        drawline (120, 136, 203, 136, 40)
          elsif zoomed = false then
        % Zoom out...
        drawline (120, 168, 203, 168, 40)
          end if
          flag := 5
      elsif x > 181 and x < 242 then
          f2s (183, 187, "a:\\npaint\\grafix\\helphl.gfx")
          delay (300)
          help
      end if
        elsif y < 185 then
      if x > toolx + 90 or x < toolx or y > tooly + 59 or
        y <
        tooly then
          if x > clrx + 105 or x < clrx or y > clry + 59
            or y
            < clry then
        selections
          end if
      else
      end if
        end if
    elsif flag = 3 then
        if x > 4 and x < 95 then
      f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
      f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      if y > 123 and y < 134 then %QUIT...
          rus
          if answer = true then
        quit := true
          else
          end if
      elsif y > 139 and y < 148 then %SAVE AS...
          f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          if tool = true then
        drawpic (toolx, tooly, behind_tool, 0)
        toolx := - 100
        tool := false
          end if
          if colours = true then
        drawpic (clrx, clry, behind_clrbar, 0)
        clrx := - 200
        colours := false
          end if
          f2s (0, 185, "a:\\npaint\\grafix\\bfiletmp.gfx")
          s2f (0, 0, maxx, maxy,
        "a:\\npaint\\grafix\\scrntemp.gfx")
          savebox := true
          buttonwait ("down", origx, origy, btn, updown)
          tempclr := clr
          clr := 32
          boxes
          clr := tempclr
          load_save (2)
      elsif y > 149 and y < 157 then %SAVE...
          if saved = true then
        f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
        if tool = true then
            drawpic (toolx, tooly, behind_tool, 0)
            toolx := - 100
            tool := false
        end if
        if colours = true then
            drawpic (clrx, clry, behind_clrbar, 0)
            clrx := - 200
            colours := false
        end if
        f2s (0, 185, 
            "a:\\npaint\\grafix\\bfiletmp.gfx")
        s2f (0, 0, maxx, maxy,
            "a:\\npaint\\grafix\\scrntemp.gfx")
        buttonwait ("down", origx, origy, btn, updown)
        tempclr := clr
        clr := 32
        boxes
        clr := tempclr
        rus
        if answer = true then
            f2s (0, 0,
          "a:\\npaint\\grafix\\scrntemp.gfx")
            s2f (min (origx, lastx), min (origy, 
          lasty), max (origx, lastx), max (origy,
          lasty), file)
        else
            f2s (0, 0, 
          "a:\\npaint\\grafix\\scrntemp.gfx")
        end if
          else
        f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
        delay (200)
        flag := 2            
          end if
      elsif y > 158 and y < 166 then %LOAD...
          if tool = true then
        drawpic (toolx, tooly, behind_tool, 0)
        toolx := - 100
        tool := false
          end if
          if colours = true then
        drawpic (clrx, clry, behind_clrbar, 0)
        clrx := - 200
        colours := false
          end if
          f2s (0, 185, "a:\\npaint\\grafix\\bfiletmp.gfx")
          s2f (0, 0, maxx, maxy,
        "a:\\npaint\\grafix\\scrntemp.gfx")
          buttonwait ("down", origx, origy, btn, updown)
          lastx := origx
          lasty := origy
          load_save (1)
      elsif y > 172 and y < 183 then %NEW...
          drawfillbox (0, 0, maxx, maxy, 31)
          toolx := - 100
          clrx := - 200
          tool := false
          colours := false
          saved := false
          delay (200)
          flag := 1
      else
          f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          delay (200)
          flag := 2
      end if
        end if
    elsif flag = 4 then
        if x > 60 and x < 153 then
      f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
      f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      if y > 123 and y < 134 then %GROOVIE...
          if tool = true then
        drawpic (toolx, tooly, behind_tool, 0)
        toolx := - 100
        tool := false
          end if
          if colours = true then
        drawpic (clrx, clry, behind_clrbar, 0)
        clrx := - 200
        colours := false
          end if
          f2s (0, 185, "a:\\npaint\\grafix\\bfiletmp.gfx")
          s2f (0, 0, maxx, maxy,
        "a:\\npaint\\grafix\\scrntemp.gfx")
          buttonwait ("down", origx, origy, btn, updown)
          tempclr := clr
          clr := 37
          boxes
          clr := tempclr
          groovie
          delay (200)
          flag := 1
      elsif y > 139 and y < 148 then %PASTE
          % Make some sort of variable for paste (true or false)
          % If you have already cut or copied something, if not
          % then draw an "x" over the paste option
          f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          flag := 2
      elsif y > 149 and y < 157 then %COPY
          % Draw a box around a certain area and then copy it
          % to another place on the screen...
          % Should be able to move it around (at least an
          % outline of how big the picture is) and then draw
          % it where the button is lifted
          f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          flag := 2
      elsif y > 158 and y < 166 then %CUT
          % Draw a box and fill what ever is left with white
          f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          flag := 2
      elsif y > 172 and y < 183 then %UNDO
          % Redraw the scrntemp.gfx file to undo a previously
          % done command...
          f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          flag := 2
      else
          f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
          flag := 2
      end if
        end if
    elsif flag = 5 then
        if x > 116 and x < 207 then
      if y > 132 and y < 141 then
          %if zoomed = false then
          %    f2s (0, 0,
          %         "a:\\npaint\\grafix\\brushbar.gfx")
          %    delay (200)
          %    flag := 2
          %    f2s (115, 125,
          %         "a:\\npaint\\grafix\\submtemp.gfx")
          %    f2s (0, 185,
          %         "a:\\npaint\\grafix\\menubar.gfx")
          %else
          %end if
          flag := 2
          f2s (115, 125,
        "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      elsif y > 140 and y < 149 then
          if colours = false then
        if toolx > 100 then
            clrx := 1
            clry := 1
        elsif toolx + 90 < 100 then
            clrx := 100
            clry := 1
        else
            clrx := 210
            clry := 1
        end if
        colours := true
        takepic (clrx, clry, clrx + 105, clry +
            59, behind_clrbar)
        f2s (clrx, clry,
            "a:\\npaint\\grafix\\colorbar.gfx")
          else
          end if
          delay (200)
          flag := 2
          f2s (115, 125,
        "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      elsif y > 148 and y < 157 then
          if tool = false then
        if clrx > 110 then
            toolx := 1
            tooly := 1
        elsif clrx + 106 < 110 then
            toolx := 115
            tooly := 1
        else
            toolx := 225
            tooly := 1
        end if
        tool := true
        takepic (toolx, tooly, toolx + 90, tooly +
            59, behind_tool)
        f2s (toolx, tooly,
            "a:\\npaint\\grafix\\toolbar.gfx")
        case selection of
            label 1 :
          f2s (toolx + 2, tooly + 24,
              "a:\\npaint\\grafix\\dotactv.gfx")
            label 2 :
          f2s (toolx + 24, tooly + 24,
              "a:\\npaint\\grafix\\lineactv.gfx")
            label 3 :
          f2s (toolx + 46, tooly + 24,
              "a:\\npaint\\grafix\\circactv.gfx")
            label 4 :
          f2s (toolx + 68, tooly + 24,
              "a:\\npaint\\grafix\\boxactv.gfx")
            label 5 :
          f2s (toolx + 24, tooly + 2,
              "a:\\npaint\\grafix\\fillactv.gfx")
            label 6 :
          f2s (toolx + 2, tooly + 2,
              "a:\\npaint\\grafix\\erasactv.gfx")
            label 7 :
          f2s (toolx + 46, tooly + 2,
              "a:\\npaint\\grafix\\circacvf.gfx")
            label 8 :
          f2s (toolx + 68, tooly + 2,
              "a:\\npaint\\grafix\\boxacvf.gfx")
        end case
          else
          end if
          delay (200)
          flag := 2
          f2s (115, 125,
        "a:\\npaint\\grafix\\submtemp.gfx")
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      elsif y > 165 and y < 174 then
          if zoomed = true then
        if colours = true then
            drawpic (clrx, clry, behind_clrbar, 0)
            clrx := - 200
            colours := false
        end if
        f2s (115, 125,
            "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185,
            "a:\\npaint\\grafix\\menubar.gfx")
        f2s (0, 185,
            "a:\\npaint\\grafix\\bfiletmp.gfx")
        zoomout
        s2f (0, 185, maxx, maxy,
            "a:\\npaint\\grafix\\bfiletmp.gfx")
        delay (200)
        zoomed := false
        tool := false
          else
        f2s (115, 125,
            "a:\\npaint\\grafix\\submtemp.gfx")
          end if
          flag := 2
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      elsif y > 173 and y < 182 then
          if zoomed = false then
        if tool = true then
            drawpic (toolx, tooly, behind_tool, 0)
            toolx := - 100
            tool := false
        end if
        if colours = true then
            drawpic (clrx, clry, behind_clrbar, 0)
            clrx := - 200
            colours := false
        end if
        f2s (115, 125,
            "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185,
            "a:\\npaint\\grafix\\menubar.gfx")
        f2s (0, 185,
            "a:\\npaint\\grafix\\bfiletmp.gfx")
        s2f (0, 0, maxx, maxy,
            "a:\\npaint\\grafix\\scrntemp.gfx")
        buttonwait ("down", origx, origy, btn,
            updown)
        where := 3
        move
        zoomx := x
        zoomy := y
        zoom
        s2f (0, 185, maxx, maxy,
            "a:\\npaint\\grafix\\bfiletmp.gfx")
        delay (200)
        tool := true
        zoomed := true
        selection := 1
          else
        f2s (115, 125,
            "a:\\npaint\\grafix\\submtemp.gfx")
          end if
          flag := 2
          f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
      end if
        end if
    end if
    tools
    clrs
      end if
      if right = 100 then
    if flag = 1 then
        delay (200)
        s2f (0, 185, 319, 199,
      "a:\\npaint\\grafix\\bfiletmp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
        flag := 2
    elsif flag = 2 then
        delay (200)
        f2s (0, 185, "a:\\npaint\\grafix\\bfiletmp.gfx")
        flag := 1
    elsif flag = 3 then
        delay (200)
        flag := 2
        f2s (3, 119, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
    elsif flag = 4 then
        delay (200)
        f2s (60, 119, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
        flag := 2
    elsif flag = 5 then
        delay (200)
        flag := 2
        f2s (115, 125, "a:\\npaint\\grafix\\submtemp.gfx")
        f2s (0, 185, "a:\\npaint\\grafix\\menubar.gfx")
    end if
      end if
      exit when quit = true
  end loop
    end if
    exit when quit = true
end loop
