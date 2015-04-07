% The (draw a picture and move it across the screen and save the backgound) program

setscreen ("graphics:mcga")

drawdot (1, 1, 3)
drawdot (1, 2, 3)
drawdot (1, 3, 47)
drawdot (2, 1, 47)
drawdot (2, 2, 3)
drawdot (2, 3, 3)
drawdot (3, 1, 3)
drawdot (3, 2, 47)
drawdot (3, 3, 47)

var mem : array 1 .. 3, 1 .. 3 of int% will have to make a file with the
for x : 1 .. 3                       %colours for each different ground texture
    for y : 1 .. 3
  mem (x, y) := whatdotcolour (x, y)
    end for
end for

var grass : array 1 .. sizepic (0, 0, 3, 3) of int
var top_erase : array 1 .. sizepic (1, 1, 15, 3) of int

takepic (1, 1, 3, 3, grass)

for x : 1 .. maxx - 200 by 3
    for y : 1 .. maxy by 3
  drawpic (x, y, grass, 0)
    end for
end for

%there must be a picture of grass for the top/bottom and right/left of the
%picture in order to erase wich ever side is behind and save the background
takepic (1, 1, 15, 3, top_erase)

include "a:\t2\scrnfl2.t"

% there will need to be a different array for each different view of the man
% in order to use the takepic and drawpic functions for fast illustrations
var front1 : array 1 .. sizepic (0, 0, 16, 26) of int
var front2 : array 1 .. sizepic (0, 0, 16, 26) of int
var front3 : array 1 .. sizepic (0, 0, 16, 26) of int

% this procedure fills in all the black in the picture with the current texture
proc backfill
    var t, s : int := 0
    loop
  for x : 1 .. 3
      for y : 1 .. 3
    if whatdotcolour (x + t, y + s) = 0 then
        drawdot (x + t, y + s, mem (x, y))
    end if
      end for
  end for
  t += 3
  if t > 17 then
      t := 0
      s += 3
  end if
  exit when s > 27
    end loop
end backfill

% here the picture with the black background is filled in with the current texture (grass)
f2s (1, 1, "a:\\front1.gfx")
backfill
takepic (1, 1, 17, 27, front1)

f2s (1, 1, "a:\\front2.gfx")
backfill
takepic (1, 1, 17, 27, front2)

f2s (1, 1, "a:\\front3.gfx")
backfill
takepic (1, 1, 17, 27, front3)

var y, x : int
y := maxy - 24
x := 10

% at the beginning of each new ground texture, there will either have to be
% tons of different picture files for all the different settings or there will
% have to be some way of putting these new textures into the array each time...

loop
    drawpic (x, y, front1, 0)
    for q : 1 .. 50000
    end for
    %drawpic (7, y, front1, 0)
    drawpic (x, y + 24, top_erase, 0)

%     y -= 3
%     drawpic (x, y, front2, 0)
%     for q : 1 .. 50000
%     end for
%     %drawpic (7, y, front2, 0)
%     drawpic (x, y + 24, top_erase, 0)

    y -= 3
    drawpic (x, y, front2, 0)
    for q : 1 .. 70000
    end for
    %drawpic (7, y, front2, 0)
    drawpic (x, y + 24, top_erase, 0)    

    y -= 3
    drawpic (x, y, front1, 0)
    for q : 1 .. 50000
    end for
    %drawpic (7, y, front1, 0)
    drawpic (x, y + 24, top_erase, 0)

%     y -= 3
%     drawpic (x, y, front3, 0)
%     for q : 1 .. 50000
%     end for
%     %drawpic (7, y, front3, 0)
%     drawpic (x, y + 24, top_erase, 0)

    y -= 3
    drawpic (x, y, front3, 0)
    for q : 1 .. 70000
    end for
    %drawpic (7, y, front3, 0)
    drawpic (x, y + 24, top_erase, 0)     

    y -= 3
end loop

