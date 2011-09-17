-module(my_transform).
-compile(export_all).

parse_transform(Forms, _Options) ->
  ast_walk(Forms).

ast_walk([H|T]) ->
  [ast_walk(H)|ast_walk(T)];
ast_walk({function, Line, greeting, 0, _Clauses}) ->
  greeting_function(Line, "Foo~n");
ast_walk(TopLevelThingy) ->
  TopLevelThingy.

greeting_function(Line, Value) ->
  String = string(Line, Value),
  Clause = clause(Line, [], [], [String]),
  function(Line, greeting, 0, [Clause]).

function(Line, Name, Arity, Clauses) ->
  {function, Line, Name, Arity, Clauses}.
clause(Line, Patterns, Guards, Bodies) ->
    {clause, Line, Patterns, Guards, Bodies}.
string(Line, Value) ->
  {string, Line, Value}.

% [
%   {attribute,1,file,{"./hello_world.erl",1}},
%   {attribute,1,module,hello_world},
%   {attribute,2,compile,export_all},
%   {function,5,start,0,[
%     {clause,5,[],[],[
%       {call,5,{remote,5,{atom,5,io},{atom,5,format}},[
%         {call,5,{atom,5,greeting},[]}
%       ]}
%     ]}
%   ]},
%   {function,6,greeting,0,[
%     {clause,6,[],[],[
%       {string,6,"Hello World~n"}
%     ]}
%   ]},
%   {eof,8}
% ]
