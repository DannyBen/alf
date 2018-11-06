

src="hello \$world"
lastcmd=${ $src =~ \$ ? "match" : "no match" }
echo $lastcmd
