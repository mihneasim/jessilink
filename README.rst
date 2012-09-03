jessilink Readme
=================

Simple script that calls YUI Compressor, 
and helps you update paths to js files so that they
contain their md5 hash in URL.

Requirements
---------------

* yui-compressor

Installation
---------------

* Edit jessilink.sh to enter the path to your yui-compressor
* Edit ~/.bashrc and enter this line:

    alias jessilink=/path_to_jessilink/jessilink.sh

You also need to set up your webserver to strip the md5 hash from URL:

  RewriteRule ^/media/(.*)_[0-9a-fA-F]+.min.js$ /media/$1.min.js [QSA,L,PT]


In Django development, if using static serve, you can input in urls.py:

  (r'^media/(?P<path>.*)_[a-fA-F0-9]+.min.js', redirect_static),


Usage
------

  host:your/js/location$ jessilink [/prefix/to/prepend] [only-ones-matching-string]

It will search subfolders for all files ending in "js",
minify them in .min.js (including the md5 hash in the filename)
and then print out inclusion path. Examples:

    $ jessilink /media
    <script type="text/javascript" language="javascript" src="/media/js/main_d86e00ac71807f7115ce9903ad182902.min.js"></script>
    <script type="text/javascript" language="javascript" src="/media/js/animations_07f59f831160ab3642db57664cbe5717.min.js"></script>
    $ jessilink /media animations
    <script type="text/javascript" language="javascript" src="/media/js/animations_07f59f831160ab3642db57664cbe5717.min.js"></script>

