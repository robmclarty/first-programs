var matrix : array 1 .. 6, 1 .. 6 of int
var generation : int := 0
var c : string (1)

proc birth
    var id, id2 : int
    var num : int
    randint (num, 10, 20)

    for x : 1 .. 6
  for y : 1 .. 6
      matrix (x, y) := 0
  end for
    end for

    for x : 1 .. num
  randint (id, 1, 6)
  randint (id2, 1, 6)
  matrix (id, id2) := 1
    end for
end birth

proc checkSides
    var neighbours, xCheck, yCheck : int
    for x : 1 .. 6
  for y : 1 .. 6
      neighbours := 0
      for i : x - 1 .. x + 1
    for d : y - 1 .. y + 1
        if i < 1 then
      xCheck := 6
        elsif i > 6 then
      xCheck := 1
        else
      xCheck := i
        end if
        if d < 1 then
      yCheck := 6
        elsif d > 6 then
      yCheck := 1
        else
      yCheck := d
        end if
        if matrix (xCheck, yCheck) = 1 then
      neighbours += 1
        end if
    end for
      end for
      neighbours -= 1 %cell itself was included in addition...
      if (matrix (x, y) = 1 and neighbours <= 1) or (matrix (x, y) =1 and neighbours >= 4) then
    matrix (x, y) := 0
      elsif matrix (x, y) = 0 and neighbours = 3 then
    matrix (x, y) := 1
      end if
  end for
    end for
end checkSides

randomize

birth

setscreen ("graphics:mcga")

loop
    locate (1, 1)
    generation += 1
    put "Generation = ", generation

    for x : 1 .. 6
  for y : 1 .. 6
      if matrix (x, y) = 1 then
    drawfillbox (x * 10, y * 10, x * 10 + 9, y * 10 + 9, 4)
      elsif matrix (x, y) = 0 then
    drawfillbox (x * 10, y * 10, x * 10 + 9, y * 10 + 9, 0)
      end if
      locate (x + 2, y)
      put matrix (x, y)
  end for
    end for
    checkSides
end loop
