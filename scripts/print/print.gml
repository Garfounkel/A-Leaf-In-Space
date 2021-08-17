// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function print(){
	var output_string = "";
	var str = "";

	for (var i = 0; i < argument_count; i++) {
	    str = argument[i];
	    if (!is_string(str)) str = string(str);
	    output_string += str + " ";
	}

	show_debug_message(output_string);
}