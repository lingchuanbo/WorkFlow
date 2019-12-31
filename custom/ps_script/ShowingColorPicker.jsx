function colorpicker (result_color) {
 
    var hexToRGB = function(hex) {
      var r = hex >> 16;
      var g = hex >> 8 & 0xFF;
      var b = hex & 0xFF;
      return [r, g, b];
    };
 
    var color_decimal = $.colorPicker();
    $.writeln(color_decimal);
 
    var color_hexadecimal = color_decimal.toString(16);
    $.writeln(color_hexadecimal);
 
    var color_rgb = hexToRGB(parseInt(color_hexadecimal, 16));
    $.writeln(color_rgb);
 
    var result_color = [color_rgb[0] / 255, color_rgb[1] / 255, color_rgb[2] / 255];
    $.writeln(result_color);
    
    return result_color;
    
    }
 
alert (colorpicker());