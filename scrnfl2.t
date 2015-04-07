/****************************************************************************/
/*                                                                          */
/*  There are two procedures in this file:                                  */
/*                                                                          */
/*                  FileToScreen and ScreenToFile                           */
/*                                                                          */
/*  FileToScreen is used to display "TM2" files that have been created by   */
/*  either PCX2TM2 or the ScreenToFile procedure.                           */
/*                                                                          */
/*  ScreenToFile is used to save the screen or a portion of the screen in   */
/*  a "TM2" file.                                                           */
/*                                                                          */
/*  FileToScreen (x, y : int, fileName : string)                            */
/*          (x, y) - This are the coordinates of the lower left             */
/*                   corner of the picture.                                 */
/*          fileName - The name of the file that you want to display        */
/*                                                                          */
/*  ScreenToFile (x1, y1, x2, y2 : int, fileName : string)                  */
/*          (x1, y1), (x2, y2) - These are the coordinates of the           */
/*                               corners of the box that surrounds the      */
/*                               part of the screen to be saved to the      */
/*                               file.  To save the whole screen, use       */
/*                               (0, 0) and (maxx, maxy).                   */
/*          fileName - The name of the file that the image should be stored */
/*                     into.                                                */
/****************************************************************************/

/****************************************************************************/
/* FileToScreen: Read a "TM2" file and display it on the screen             */
/****************************************************************************/
procedure f2s (x, y : int, fileName : string)
    var version : int       % The version number of the TM2 file
    var bufferSize : int    % The size of the picture buffer used
          % to hold pieces of the picture
    var xSize, ySize : int  % The size of the picture
    var screenWidth, screenHeight, screenColors : int
          % The screen's width, height and number of colors
    var screenMode : string (11)
          % The mode the picture was taken in.
    var paletteUsed : int   % Whether a palette is used or not.  This
          % is "0" if there's no palette used and
          % "1" if a palette is used and follows
    var fs : int            % The file stream of the file

    % Open the file and return an error message if it failed.
    open : fs, fileName, read
    if fs <= 0 then
  put "Unable to open file \"", fileName, "\" for reading."
  return
    end if

    % Read the version number and return an error message if it was the
    % wrong version.
    read : fs, version
    if version not= 4661 then
  put "\"", fileName, "\" is not a legal TM2 file!"
  close : fs
  return
    end if

    % Read the size of the picture buffer
    read : fs, bufferSize

    % Read the size of the picture
    read : fs, xSize, ySize

    % Read information about the screen (size, number of colors, mode)
    read : fs, screenWidth, screenHeight, screenColors, screenMode

    % Read whether a palette is saved in this picture
    read : fs, paletteUsed
    if paletteUsed = 1 then
  % There is a palette in this image.  Read the number of colours
  % in the palette, then read the palette itself.  Finally change
  % the colour map in the image.
  var numColours : int                            % The number of colours
              % in the palette
  var red, green, blue : array 1 .. 256 of int    % The red, green and
              % blue values for the
              % palette
  % Read the number of colours in the palette and make certain
  % that this is a palette for this graphics mode.
  read : fs, numColours
  if maxcolour not= numColours - 1 then
      put "The image contains a palette with ", numColours
      put "colours, while the current graphics mode supports "
      put maxcolour + 1, " colours.  You are probably in a"
      put "different graphics mode from the one that this"
      put "picture was created in."
      close : fs
      return
  end if

  % Read in the palette
  for cnt : 1 .. numColours
      read : fs, red (cnt), green (cnt), blue (cnt)
  end for

  % Change the colour map
  setcolourmap (red, green, blue, numColours)
    end if

    /************************************************************************/
    /*                          Display the Picture!                        */
    /************************************************************************/
    % The picture has been saved in chunks of "buffersize" integers.
    % We declare the picture buffer here.
    var pic : array 1 .. bufferSize of int
    var bytesToRead, bytesRead : int    % This is used to determine how many
          % bytes to read and whether the read
          % succeeded
    var currentY : int                  % Each chunk must be displayed at its
          % particular Y location starting from
          % the top of the image.
    currentY := ySize + y
    loop
  exit when eof (fs)
  read : fs, bytesToRead
  read : fs, pic : bytesToRead : bytesRead
  if bytesToRead not= bytesRead then
      put "\"", fileName, "\" ended in the middle of an image.  This"
      put "probably means the image was damaged."
      return
  end if
  currentY -= pic (1) + 1         % Adjust the current Y location
  drawpic (x, currentY, pic, 0)   % Draw this chunk to the screen
    end loop
    close : fs
end f2s


/****************************************************************************/
/* ScreenToFile: Procedure to save a portion of the screen to a "TM2" file  */
/****************************************************************************/
procedure s2f (x1, y1, x2, y2 : int, fileName : string)
    var version : int               % The version number of the TM2 file
    var bufferSize : int := 1000    % The size of the chunk in integer.
            % Increase this value (up to 8000) to
            % display faster and use more memory.
    var xSize, ySize : int          % The size of the picture
    var screenWidth, screenHeight, screenColors : int
          % The screen's width, height and number of colors
    var screenMode : string (11)
          % The mode the picture was taken in.
    var paletteUsed : int           % Currently, because Turing has no way of
            % reading the colour palette, this is
            % always "0".
    var fs : int                    % The file stream of the file


    % Create the file and return an error message if it failed.
    open : fs, fileName, write
    if fs <= 0 then
  put "Unable to creat file \"", fileName, "\"."
  return
    end if

    % Write the version number.
    version := 4661
    write : fs, version

    % Write the size of the picture buffer
    write : fs, bufferSize

    % Write the size of the picture
    xSize := abs (x2 - x1) + 1
    ySize := abs (y2 - y1) + 1
    write : fs, xSize, ySize

    % Write the characteristics of the current screen
    screenWidth := maxx + 1
    screenHeight := maxy + 1
    screenColors := maxcolor + 1
    % We have to lookup the mode based on the screenWidth/Height
    if screenWidth = 320 then
  if screenColors = 4 then
      screenMode := "cga"
  elsif screenColors = 16 then
      screenMode := "16"
  else
      screenMode := "mcga"
  end if
    elsif screenWidth = 640 then
  if screenHeight = 200 then
      if screenColors = 2 then
    screenMode := "hmono"
      else
    screenMode := "h16"
      end if
  elsif screenHeight = 350 then
      screenMode := "ega"
  elsif screenHeight = 400 then
      screenMode := "svga1"
  else
      if screenColors = 2 then
    screenMode := "v2"
      elsif screenColors = 16 then
    screenMode := "vga"
      else
    screenMode := "svga"
      end if
  end if
    elsif screenWidth = 800 then
  if screenColors = 16 then
      screenMode := "svga3"
  else
      screenMode := "svga4"
  end if
    else
  if screenColors = 16 then
      screenMode := "svga5"
  else
      screenMode := "svga6"
  end if
    end if
    write : fs, screenWidth, screenHeight, screenColors, screenMode

    % Write that there is no palette
    paletteUsed := 0
    write : fs, paletteUsed

    /************************************************************************/
    /*                          Save the Picture!                           */
    /************************************************************************/
    % The picture has to be saved in chunks of "actualBufferSize" integers.
    % We declare the picture buffer here.
    var pic : array 1 .. bufferSize of int
    var bytesToWrite, bytesWritten : int    % This is used to determine how
              % many bytes to write and whether
              % the write succeeded
    var currentY : int                      % Each chunk must be displayed at
              % its particular Y location
              % starting from the top.
    var numRowsInChunk : int                % This is the number of rows that
              % fit into a single chunk.
    const topRow := max (y1, y2)            % The top row in the picture
    const bottomRow := min (y1, y2)         % The bottom row in the picture

    numRowsInChunk := (bufferSize - 3) div sizepic (x1, 1, x2, 1)
    currentY := topRow + 1
    loop
  % Exit if the rest of the picture fits into a chunk.
  exit when currentY - numRowsInChunk <= bottomRow

  currentY -= numRowsInChunk      % Adjust the current Y location

  % Load the chunk with the image
  takepic (x1, currentY, x2, currentY + numRowsInChunk - 1, pic)

  % picSize = number of bytes in the current chunk
  bytesToWrite := sizepic (x1, 0, x2, numRowsInChunk - 1) * 4

  % A chunk is the number of bytes followed by the image portion
  write : fs, bytesToWrite
  write : fs, pic : bytesToWrite
    end loop

    % Load the chunk with the image
    takepic (x1, bottomRow, x2, currentY - 1, pic)

    % bytesToWrite = number of bytes in the current chunk
    bytesToWrite := sizepic (x1, bottomRow, x2, currentY - 1) * 4

    % A chunk is the number of bytes followed by the image portion
    write : fs, bytesToWrite
    write : fs, pic : bytesToWrite

    close : fs
end s2f

