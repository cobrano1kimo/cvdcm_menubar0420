// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require rails-ujs
//= require turbolinks
//= require_tree .

function TestFun()
{
  // try {
    var TSCObj;
    TSCObj = new ActiveXObject('TSCActiveX.TSCLIB');
    TSCObj.ActiveXopenport('TSC TTP-246M Pro');
    TSCObj.ActiveXsendcommand('SIZE 60 mm, 27 mm');
    TSCObj.ActiveXsendcommand('SPEED 4');
    TSCObj.ActiveXsendcommand('DENSITY 12');
    TSCObj.ActiveXsendcommand('DIRECTION 1');
    TSCObj.ActiveXsendcommand('SET TEAR ON');
    TSCObj.ActiveXclearbuffer();
    TSCObj.ActiveXbarcode("134", "25", "128M", "100", "0", "0", "2", "4", "CP508012");
    TSCObj.ActiveXwindowsfont(56, 115, 120, 0, 2, 0,"Arial Narrow","CP508012");
    TSCObj.ActiveXprintlabel('1', '1');
    TSCObj.ActiveXcloseport();
  // } catch (e) {}
}
/**
*
*  Base64 encode / decode
*  http://www.webtoolkit.info/
*
**/

var Base64 = {

        // private property
       _keyStr : "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",

     // public method for encoding
     encode : function (input) {
               var output = "";
          var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
             var i = 0;

         input = Base64._utf8_encode(input);

                while (i < input.length) {

                      chr1 = input.charCodeAt(i++);
                     chr2 = input.charCodeAt(i++);
                     chr3 = input.charCodeAt(i++);

                      enc1 = chr1 >> 2;
                   enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
                   enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
                  enc4 = chr3 & 63;

                      if (isNaN(chr2)) {
                                enc3 = enc4 = 64;
                 } else if (isNaN(chr3)) {
                         enc4 = 64;
                        }

                  output = output +
                 this._keyStr.charAt(enc1) + this._keyStr.charAt(enc2) +
                   this._keyStr.charAt(enc3) + this._keyStr.charAt(enc4);

             }

          return output;
    },

 // public method for decoding
     decode : function (input) {
               var output = "";
          var chr1, chr2, chr3;
             var enc1, enc2, enc3, enc4;
               var i = 0;

         input = input.replace(/[^A-Za-z0-9\+\/\=]/g, "");

          while (i < input.length) {

                      enc1 = this._keyStr.indexOf(input.charAt(i++));
                   enc2 = this._keyStr.indexOf(input.charAt(i++));
                   enc3 = this._keyStr.indexOf(input.charAt(i++));
                   enc4 = this._keyStr.indexOf(input.charAt(i++));

                    chr1 = (enc1 << 2) | (enc2 >> 4);
                     chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
                  chr3 = ((enc3 & 3) << 6) | enc4;

                 output = output + String.fromCharCode(chr1);

                       if (enc3 != 64) {
                         output = output + String.fromCharCode(chr2);
                      }
                 if (enc4 != 64) {
                         output = output + String.fromCharCode(chr3);
                      }

          }

          output = Base64._utf8_decode(output);

              return output;

     },

 // private method for UTF-8 encoding
      _utf8_encode : function (string) {
                string = string.replace(/\r\n/g,"\n");
            var utftext = "";

          for (var n = 0; n < string.length; n++) {

                       var c = string.charCodeAt(n);

                      if (c < 128) {
                         utftext += String.fromCharCode(c);
                        }
                 else if((c > 127) && (c < 2048)) {
                          utftext += String.fromCharCode((c >> 6) | 192);
                             utftext += String.fromCharCode((c & 63) | 128);
                       }
                 else {
                            utftext += String.fromCharCode((c >> 12) | 224);
                            utftext += String.fromCharCode(((c >> 6) & 63) | 128);
                          utftext += String.fromCharCode((c & 63) | 128);
                       }

          }

          return utftext;
   },

 // private method for UTF-8 decoding
      _utf8_decode : function (utftext) {
               var string = "";
          var i = 0;
                var c = c1 = c2 = 0;

               while ( i < utftext.length ) {

                  c = utftext.charCodeAt(i);

                 if (c < 128) {
                         string += String.fromCharCode(c);
                         i++;
                      }
                 else if((c > 191) && (c < 224)) {
                           c2 = utftext.charCodeAt(i+1);
                             string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
                         i += 2;
                   }
                 else {
                            c2 = utftext.charCodeAt(i+1);
                             c3 = utftext.charCodeAt(i+2);
                             string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
                           i += 3;
                   }

          }

          return string;
    }
 
