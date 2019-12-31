colorBrightness(app.foregroundColor, -10);

function colorBrightness(color, amount) {
    if (amount > 0) {
        if ((color.hsb.brightness + amount) <= 100) {
            color.hsb.brightness += amount;
        } else {
            if ((100 - color.hsb.brightness) != 0 && (100 - color.hsb.brightness) < 10) {
                amount = 10 - (100 - color.hsb.brightness);
            }
            color.hsb.brightness = 100;
            if (color.hsb.saturation != 0 && (color.hsb.saturation - amount) >= 0) {
                color.hsb.saturation -= amount;
            } else {
                color.hsb.saturation = 0;
            }
        }
    }
    if (amount < 0) {
        amount *= -1;
        if (color.hsb.saturation != 0 && (color.hsb.saturation + amount) <= 100) {
            color.hsb.saturation += amount;
        } else {
            if ((100 - color.hsb.saturation) != 0 && (100 - color.hsb.saturation) < 10) {
                amount = 10 - (100 - color.hsb.saturation);
            }
            if (color.hsb.saturation != 0) {
                color.hsb.saturation = 100;
            }
            if ((color.hsb.brightness - amount) >= 0) {
                color.hsb.brightness -= amount;
            } else {
                color.hsb.brightness = 0;
            }
        }
    }
}