-module(hello_world).
-compile(export_all).
-compile({parse_transform, my_transform}).

start() -> io:format(greeting()).
greeting() -> "Hello World~n".

