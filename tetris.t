setscreen ("graphics:mcga,noecho,nocursor")
include "a:\t2\scrnfl2.t"

% f2s (10, 10, "a:\\t2\\block.tet")
% f2s (21, 10, "a:\\t2\\block.tet")
% f2s (32, 10, "a:\\t2\\block.tet")
% f2s (21, 21, "a:\\t2\\block.tet")
% s2f (10, 10, 43, 32, "a:\\t2\\t.tet")
%
% f2s (100, 100, "a:\\t2\\t.tet")

randomize

var move : array 1 .. sizepic (0, 0, 50, 50) of int

var x, y, block, speed, corner2, lastcorner : int
var file : string (7)
var c : string (1)
speed := 70000

proc randblock
    randint (block, 1, 5)
    case block of
  label 1 :
      file := "l.tet"
      corner2 := 32
  label 2 :
      file := "j.tet"
      corner2 := 32
  label 3 :
      file := "t.tet"
      corner2 := 43
  label 4 :
      file := "4x1.tet"
      corner2 := 21
  label 5 :
      file := "4x4.tet"
      corner2 := 32
    end case
end randblock

drawbox (9, 10, 178, 201, 32)
drawbox (200, 100, 280, 170, 32)
locatexy (200, 180)
put "NEXT BLOCK"

x := 100
y := maxy
randblock
lastcorner := corner2
f2s (220, 115, "a:\\t2\\" + file)
takepic (220, 115, 270, 160, move)
drawfillbox (210, 110, 279, 169, 0)


loop
    x := 100
    y := maxy

    lastcorner := corner2
    randblock

    f2s (220, 115, "a:\\t2\\" + file)

    loop
  if hasch then
      getch (c)
      if ord (c) = 203 then
    if x >= 21 then
        x -= 11
    else
    end if
      elsif ord (c) = 205 then
    if x + corner2 <= 170 then
        x += 11
    else
    end if
      else
      end if
  else
  end if

  drawpic (x, y, move, 1) % Draw block on the screen

  for i : 1 .. speed % Delay
  end for

  if y < 20 or whatdotcolour (x, y -1) = 37 or whatdotcolour (corner2, y -1) = 37 then
      exit
  end if

  drawpic (x, y, move, 1)
  % Drawing the same thing twice erases the block

  y -= 11

    end loop
   
    takepic (220, 115, 270, 165, move)
    drawfillbox (210, 110, 279, 169, 0)

end loop
