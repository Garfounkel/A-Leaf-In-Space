function roundUp(numToRound, multiple)
{
    if (multiple == 0)
        return numToRound;

    var remainder = numToRound % multiple;
    if (remainder == 0)
        return numToRound;

    return numToRound + multiple - remainder;
}

function DrawCenterOn()
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}

function DrawCenterOff()
{
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}


/// string_limit_width(string,width,ext)
//
//  Returns a given string. If it exceeds a certain pixel width, it is
//  truncated to fit and an extension (such as an ellipsis) is appended.
//  Uses the currently defined font to determine text width.
//
//      str         text, string
//      width       width in pixels, real
//      ext         text to append, string
//
/// GMLscripts.com/license
function string_limit_width(text, width, ext)
{
    var str, wid;
    str = text;
    wid = max(width, string_width(ext));
    if (string_width(str) <= wid) return str;
    while (string_width(str + ext) > wid) {
        str = string_delete(str, string_length(str), 1);
    } 
    return str + ext;
}